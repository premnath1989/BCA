
//
//  test.m
//  SDTest1
//
//  Created by Eugen Laukart on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <string.h>
#include <errno.h>
#include "SPSignDocCAPI.h"
#include "test.h"
//#include "RootViewController.h"

NSInteger buttonClicked = 0; //LA
NSInteger hasInit = 0;
NSInteger doc_signed = 0;
NSInteger resetSig = 0; //reset Signature button
static struct SIGNDOC_Exception *ex;
static struct SIGNDOC_DocumentHandler *handler;
static struct SIGNDOC_DocumentLoader *loader;
static struct SIGNDOC_Document *doc;
static const char *test_output_file;
static NSString *doc_path;


//defining as global variable
const char *field_1 = NULL;
const char *sfield_1 = NULL;


static void doThrow ()
{
  @throw [NSException exceptionWithName:@"SignDocException"
                                 reason:@"SignDoc error"
                               userInfo:nil];
}

static void handleException (struct SIGNDOC_Exception *ex)
{
  char *txt = SIGNDOC_Exception_get_text (ex);
  NSLog (@"SignDoc error %u (%s)", SIGNDOC_Exception_get_type (ex), txt);
  doThrow ();
}

static void failAlloc (const char *fun)
{
  NSLog (@"%s() failed", fun);
  doThrow ();
}


static void failLoader (struct SIGNDOC_DocumentLoader *loader, const char *fun)
{
  const char *txt = SIGNDOC_DocumentLoader_getErrorMessage (loader, NULL, SIGNDOC_ENCODING_NATIVE);
  NSLog (@"%s() failed, %s", fun, txt);
  doThrow ();
}

static void failDoc (struct SIGNDOC_Document *doc, int rc, const char *fun)
{
  const char *txt = SIGNDOC_Document_getErrorMessage (doc, NULL, SIGNDOC_ENCODING_NATIVE);
  NSLog (@"%s() failed, %d, %s", fun, rc, txt);
  doThrow ();
}

static void failVer (struct SIGNDOC_VerificationResult *ver, int rc, const char *fun)
{
  const char *txt = SIGNDOC_VerificationResult_getErrorMessage (ver, NULL, SIGNDOC_ENCODING_NATIVE);
  NSLog (@"%s() failed, %d, %s", fun, rc, txt);
  doThrow ();
}

static void checkParam (struct SIGNDOC_SignatureParameters *params, int rc, const char *fun)
{
  if (rc == SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_OK)
    return;
  const char *txt = SIGNDOC_SignatureParameters_getErrorMessage (params, NULL, SIGNDOC_ENCODING_NATIVE);
  NSLog (@"%s() failed, %d, %s", fun, rc, txt);
  doThrow ();
}

unsigned char *readFile (const char *path, size_t *size)
{
  FILE *f = fopen (path, "rb");
  if (f == NULL)
    {
      NSLog (@"%s: %s", path, strerror (errno));
      doThrow ();
    }
  fseek (f, 0, SEEK_END);
  long len = ftell (f);
  fseek (f, 0, SEEK_SET);
  *size = (size_t)len;
  unsigned char *p = (unsigned char *)malloc (*size);
  if (p == NULL)
    {
      NSLog (@"readFile(): out of memory");
      fclose (f);
      doThrow ();
    }
  size_t n = fread (p, 1, *size, f);
  if (ferror (f))
    {
      NSLog (@"%s: %s", path, strerror (errno));
      fclose (f);
      doThrow ();
    }
  if (n != *size)
    {
      NSLog (@"readFile(): short read");
      fclose (f);
      doThrow ();
    }
  if (fclose (f) != 0)
    {
      NSLog (@"%s: %s", path, strerror (errno));
      doThrow ();
    }
  return p;
}

static void writeFile (const char *path, const void *ptr, size_t size)
{
  FILE *f = fopen (path, "wb");
  if (f == NULL)
    {
      NSLog (@"%s: %s", path, strerror (errno));
      doThrow ();
    }
  fwrite (ptr, 1, size, f);
  if (ferror (f) || fflush (f) != 0)
    {
      NSLog (@"%s: %s", path, strerror (errno));
      fclose (f);
      doThrow ();
    }
  if (fclose (f) != 0)
    {
      NSLog (@"%s: %s", path, strerror (errno));
      doThrow ();
    }
}

void initTest (const char *filename)
{
    //NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"COA" ofType:@"pdf"];
    //NSURL *url = [NSURL fileURLWithPath:urlAddress];
    //NSString *defaultPDFPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"COA.pdf"];
    //success = [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error];

    
  const char *input_path = filename;
    //const char *input_path = "COA.pdf";
    
    //const char *input_path = [defaultPDFPath UTF8String];
  NSArray *doc_paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
  doc_path = [doc_paths objectAtIndex:0];
  
	ex = SIGNDOC_Exception_new ();
	if (ex == NULL)
        failAlloc ("SIGNDOC_Exception_new");
	SIGNDOC_Exception_set_handler (ex, handleException, NULL);
	
	// The magic numbers are for SignDocSDK.lic
	if (!SIGNDOC_initLicenseManager (ex, 423343885, 1494518706))
	{
		NSLog (@"Cannot initilize license");
		doThrow ();
	}
	
	// Create loader
	
	loader = SIGNDOC_DocumentLoader_new (ex);
	handler = SIGNDOC_PdfDocumentHandler_new (ex);
	if (!SIGNDOC_DocumentLoader_registerDocumentHandler (loader, ex, handler))
        failLoader (loader, "SIGNDOC_DocumentLoader_registerDocumentHandler");
	
	// Load document
	
	NSString *bundle_path = [[NSBundle mainBundle] bundlePath];
	NSString *input_path2 = [NSString stringWithUTF8String:input_path];
    NSString *input_path3;
    if ([input_path2 isEqualToString:@"test2.pdf"]) {
        input_path3 = [bundle_path stringByAppendingPathComponent:input_path2];
    }
	else {
        input_path3 = [[NSString alloc] initWithString: [doc_path stringByAppendingPathComponent: input_path2]];
    }
	const char *input_path4 = [input_path3 UTF8String];
	NSLog (@"Input file: %s", input_path4);
    //NSLog (@"Input file: %s", input_path);
    
	doc = SIGNDOC_DocumentLoader_loadFromFile_cset (loader, ex, SIGNDOC_ENCODING_NATIVE, input_path4, SIGNDOC_NO);
	//doc = SIGNDOC_DocumentLoader_loadFromFile_cset (loader, ex, SIGNDOC_ENCODING_NATIVE, input_path, SIGNDOC_NO);
	if (doc == NULL)
        failLoader (loader, "SIGNDOC_DocumentLoader_loadFromFile_cset");
    
}


void uninit ()
{
	if (doc != NULL)
        SIGNDOC_Document_delete (doc, ex);
	if (loader != NULL)
        SIGNDOC_DocumentLoader_delete (loader, ex);
	if (ex != NULL)
        SIGNDOC_Exception_delete (ex);
}

struct SIGNDOC_ByteArray *renderTest(unsigned int height, unsigned int width, int page)
{
  struct SIGNDOC_ByteArray *blob;
  struct SIGNDOC_RenderParameters *rp;
  struct SIGNDOC_RenderOutput *ro;
  
  blob = SIGNDOC_ByteArray_new ();
  if (blob == NULL)
    failAlloc ("SIGNDOC_ByteArray_new");
  rp = SIGNDOC_RenderParameters_new (ex);
  ro = SIGNDOC_RenderOutput_new (ex);
  
  SIGNDOC_RenderParameters_setFormat (rp, ex, "png");
  SIGNDOC_RenderParameters_setPage (rp, ex, page);
  SIGNDOC_RenderParameters_fitHeight (rp, ex, height);
  SIGNDOC_RenderParameters_fitWidth (rp, ex, width);
  struct SIGNDOC_Rect *clip = NULL;
  int rc = SIGNDOC_Document_renderPageAsImage (doc, ex, blob, ro, rp, clip);
  if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK) {
    failDoc (doc, rc, "SIGNDOC_Document_renderPageAsImage");
  }
  else {
    NSLog (@"Image width:  %d", SIGNDOC_RenderOutput_getWidth (ro, ex));
    NSLog (@"Image height: %d", SIGNDOC_RenderOutput_getHeight (ro, ex));
  }
  
  if (ro != NULL)
    SIGNDOC_RenderOutput_delete (ro, ex);
  if (rp != NULL)
    SIGNDOC_RenderParameters_delete (rp, ex);
  
  return blob;
}

int signTest (const char *field_name_sig, unsigned char *signature_data, size_t signature_size, unsigned char *signature_img, size_t image_size, char *dst_file, BOOL selfSigned)
{
  int rc;
  struct SIGNDOC_SignatureParameters *sp = NULL;
  
  rc = SIGNDOC_Document_createSignatureParameters (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                                   field_name_sig, "", &sp);
  if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
    failDoc (doc, rc, "SIGNDOC_Document_createSignatureParameters");
  
  rc = SIGNDOC_SignatureParameters_setInteger (sp, ex, "Method", SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS7_DETACHED);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setInteger");
  rc = SIGNDOC_SignatureParameters_setInteger (sp, ex, "DetachedHashAlgorithm", SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_SHA256);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setInteger");
  rc = SIGNDOC_SignatureParameters_setLength (sp, ex, "FontSize", SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_ABS, 108);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setLength");
  rc = SIGNDOC_SignatureParameters_setInteger (sp, ex, "BiometricEncryption", SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_RSA);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setInteger");
  rc = SIGNDOC_SignatureParameters_setString_cset(sp, ex, SIGNDOC_ENCODING_UTF_8, "BiometricKeyPath", [[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"test-private.key"] UTF8String]);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setString(bio key)");
  rc = SIGNDOC_SignatureParameters_setInteger (sp, ex, "GenerateKeyPair", 1024);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setInteger");
  rc = SIGNDOC_SignatureParameters_setString_cset (sp, ex, SIGNDOC_ENCODING_NATIVE, "CommonName", "1self-signed");
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setString_cset");
  if (selfSigned) {
      
      //NSString *myString = @"Hello";
      //const unsigned char *string = (const unsigned char *) [myString UTF8String];
      //unsigned char *aa = "aaa";
      //rc = SIGNDOC_SignatureParameters_setString_cset(<#struct SIGNDOC_SignatureParameters *aObj#>, <#struct SIGNDOC_Exception *ex#>, <#int aEncoding#>, <#const char *aName#>, <#const char *aValue#>)
      //NSString *myString = @"Hello";
      //const char *cString = [myString cStringUsingEncoding:NSASCIIStringEncoding];
      
      
      //to display the timestamp under the signature
      NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
      [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
      NSString *dateInfo = [NSString stringWithFormat:@"Date and Time: %@",[formatter stringFromDate:[NSDate date]]];
      
      const char *cString = [dateInfo cStringUsingEncoding:NSASCIIStringEncoding];

      
      rc = SIGNDOC_SignatureParameters_setString_cset (sp, ex, SIGNDOC_ENCODING_NATIVE, "Signer", cString);
      checkParam (sp, rc, "SIGNDOC_SignatureParameters_setString_cset");
  }
  rc = SIGNDOC_SignatureParameters_setString_cset (sp, ex, SIGNDOC_ENCODING_NATIVE, "OutputPath", dst_file);
  checkParam (sp, rc, "SIGNDOC_SignatureParameters_setString_cset");
  //if (buttonClicked != 3) // image fields does not have biometric data
  //{
      rc = SIGNDOC_SignatureParameters_setBlob (sp, ex, "BiometricData", signature_data, signature_size);
      checkParam (sp, rc, "SIGNDOC_SignatureParameters_setBlob");
      rc = SIGNDOC_SignatureParameters_setBlob (sp, ex, "Image", signature_img, image_size);
      checkParam (sp, rc, "SIGNDOC_SignatureParameters_setBlob");
  //}
  rc = SIGNDOC_Document_addSignature (doc, ex, sp);
  if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
    failDoc (doc, rc, "SIGNDOC_Document_addSignature");

  if (sp != NULL)
    SIGNDOC_SignatureParameters_delete (sp, ex);
    
    NSLog (@"Signature Field Name: %s", field_name_sig);

  return rc;
}

void doTest ()
{
    NSLog(@"doTest");
    struct SIGNDOC_TextFieldAttributes *tfa = NULL; //1st sign field
    struct SIGNDOC_TextFieldAttributes *stfa = NULL; // 2nd sig field
    struct SIGNDOC_TextFieldAttributes *tfa3 = NULL; //3rd sign field
    struct SIGNDOC_TextFieldAttributes *tfa4 = NULL; //4th sign field
    struct SIGNDOC_TextFieldAttributes *tfa5 = NULL; //5th sign field
    struct SIGNDOC_TextFieldAttributes *tfa6 = NULL; //6th sign field
    struct SIGNDOC_TextFieldAttributes *tfa7 = NULL; //7th sign field
    struct SIGNDOC_TextFieldAttributes *tfa8 = NULL; //8th sign field
    struct SIGNDOC_TextFieldAttributes *tfa9 = NULL; //9th sign field
    struct SIGNDOC_TextFieldAttributes *img_tfa = NULL; //image field
    struct SIGNDOC_FindTextPositionArray *pos = NULL;
    struct SIGNDOC_FindTextPositionArray *pos2 = NULL; //2nd sign field position
    struct SIGNDOC_FindTextPositionArray *pos3 = NULL; //image field position
    struct SIGNDOC_FindTextPositionArray *pos4 = NULL; //3rd sign field position
    struct SIGNDOC_FindTextPositionArray *pos5 = NULL; //4th sign field position
    struct SIGNDOC_FindTextPositionArray *pos6 = NULL; //5th sign field position
    struct SIGNDOC_FindTextPositionArray *pos7 = NULL; //6th sign field position
    struct SIGNDOC_FindTextPositionArray *pos8 = NULL; //7th sign field position
    struct SIGNDOC_FindTextPositionArray *pos9 = NULL; //8th sign field position
    struct SIGNDOC_FindTextPositionArray *pos10 = NULL; //9th sign field position
    struct SIGNDOC_Field *field = NULL;
    struct SIGNDOC_Field *sfield = NULL;
    struct SIGNDOC_Field *img_field = NULL; //image field
    struct SIGNDOC_Field *field3 = NULL;
    struct SIGNDOC_Field *field4 = NULL;
    struct SIGNDOC_Field *field5 = NULL;
    struct SIGNDOC_Field *field6 = NULL;
    struct SIGNDOC_Field *field7 = NULL;
    struct SIGNDOC_Field *field8 = NULL;
    struct SIGNDOC_Field *field9 = NULL;
    struct SIGNDOC_VerificationResult *ver = NULL;
    struct SIGNDOC_ByteArray *blob = NULL;
    
    const char *output_path = "output.pdf";
    //const char *image_path = "output.png";
    const char *bio_path = "test.bio";
    const char *bmp_path = "test.bmp";
    const char *field_name_text = "text1";
    const char *field_name_sig = "sig1";
    
    const char *field_name_text2 = "text2";
    const char *field_name_sig2 = "sig2";
    
    const char *field_name_text3 = "image1";
    const char *field_name_sig3 = "img1";
    
    const char *field_name_text4 = "text3";
    const char *field_name_sig4 = "sig3";
    
    const char *field_name_text5 = "text4";
    const char *field_name_sig5 = "sig4";
    
    const char *field_name_text6 = "text5";
    const char *field_name_sig6 = "sig5";
    
    const char *field_name_text7 = "text6";
    const char *field_name_sig7 = "sig6";
    
    const char *field_name_text8 = "text7";
    const char *field_name_sig8 = "sig7";
    
    const char *field_name_text9 = "text8";
    const char *field_name_sig9 = "sig8";
    
    const char *field_name_text10 = "text9";
    const char *field_name_sig10 = "sig9";
    NSLog (@"Test started");

  //initTest();
	
  @try
    {
     // if already initialized before then do not initialize again.
     if (hasInit == 0)
     {
      // Initialize
      NSString *output_path2 = [NSString stringWithUTF8String:output_path];
      NSString *output_path3 = [doc_path stringByAppendingPathComponent:output_path2];
      test_output_file = [output_path3 UTF8String];
      NSLog (@"Output file: %s", test_output_file);
      remove (test_output_file);

      // Set properties
      {
        int rc = SIGNDOC_Document_setStringProperty (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                                     "encrypted", "priv1", "one");
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_setStringProperty");

        rc = SIGNDOC_Document_setStringProperty (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                                 "public", "pub2", "two");
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_setStringProperty");
      }

        //inserting signature fields
      {
        //if (buttonClicked == 1) {
        	// Insert 1st signature field
        tfa = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa, ex, 116);
          
        field = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_text);
        SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field, ex, 4);
        SIGNDOC_Field_setLeft (field, ex, 450);
        SIGNDOC_Field_setRight (field, ex, 550);
        SIGNDOC_Field_setBottom (field, ex, 1720);
        SIGNDOC_Field_setTop (field, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field, ex, tfa);
        SIGNDOC_Field_setJustification(field, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);

        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_addField");
          
        NSLog (@"1st Signature field added 1");
        SIGNDOC_Field_delete (field, ex);
        field = NULL;
        //}  
        
          //if (buttonClicked == 2) {
          	// Insert 2nd signature field
          stfa = SIGNDOC_TextFieldAttributes_new (ex);
          SIGNDOC_TextFieldAttributes_setFontName (stfa, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
          SIGNDOC_TextFieldAttributes_setFontSize (stfa, ex, 116);
          
          sfield = SIGNDOC_Field_new (ex);
          SIGNDOC_Field_setName (sfield, ex, SIGNDOC_ENCODING_NATIVE, field_name_text2);
          SIGNDOC_Field_setType (sfield, ex, SIGNDOC_FIELD_TYPE_TEXT);
          SIGNDOC_Field_setPage (sfield, ex, 4);
          SIGNDOC_Field_setLeft (sfield, ex, 550);
          SIGNDOC_Field_setRight (sfield, ex, 650);
          SIGNDOC_Field_setBottom (sfield, ex, 1820);
          SIGNDOC_Field_setTop (sfield, ex, 1870);
          SIGNDOC_Field_setTextFieldAttributes (sfield, ex, stfa);
          SIGNDOC_Field_setJustification(sfield, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
          int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
          int src = SIGNDOC_Document_addField (doc, ex, sfield, set_sfield_flags);
          
          if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
              failDoc (doc, src, "SIGNDOC_Document_addField");
          
          NSLog (@"2nd Signature field added 1");
          SIGNDOC_Field_delete (sfield, ex);
          sfield = NULL;
          //}
          
          //if (buttonClicked == 3) {
          	// Insert 3rd signature field
        tfa3 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa3, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa3, ex, 116);
          
        field3 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field3, ex, SIGNDOC_ENCODING_NATIVE, field_name_text4);
        SIGNDOC_Field_setType (field3, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field3, ex, 4);
        SIGNDOC_Field_setLeft (field3, ex, 450);
        SIGNDOC_Field_setRight (field3, ex, 550);
        SIGNDOC_Field_setBottom (field3, ex, 1720);
        SIGNDOC_Field_setTop (field3, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field3, ex, tfa3);
        SIGNDOC_Field_setJustification(field3, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags3 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc3 = SIGNDOC_Document_addField (doc, ex, field3, set_field_flags3);

        if (rc3 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc3, "SIGNDOC_Document_addField");
          
        NSLog (@"3rd Signature field added ");
        SIGNDOC_Field_delete (field3, ex);
        field3 = NULL;
          //}
          
        //if (buttonClicked == 4) {
        	// Insert 4th signature field
        tfa4 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa4, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa4, ex, 116);
          
        field4 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field4, ex, SIGNDOC_ENCODING_NATIVE, field_name_text5);
        SIGNDOC_Field_setType (field4, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field4, ex, 4);
        SIGNDOC_Field_setLeft (field4, ex, 450);
        SIGNDOC_Field_setRight (field4, ex, 550);
        SIGNDOC_Field_setBottom (field4, ex, 1720);
        SIGNDOC_Field_setTop (field4, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field4, ex, tfa4);
        SIGNDOC_Field_setJustification(field4, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags4 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc4 = SIGNDOC_Document_addField (doc, ex, field4, set_field_flags4);

        if (rc4 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc4, "SIGNDOC_Document_addField");
          
        NSLog (@"4th Signature field added ");
        SIGNDOC_Field_delete (field4, ex);
        field4 = NULL;
        //}
        
        
        //if (buttonClicked == 5) {
        	// Insert 5th signature field
        tfa5 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa5, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa5, ex, 116);
          
        field5 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field5, ex, SIGNDOC_ENCODING_NATIVE, field_name_text6);
        SIGNDOC_Field_setType (field5, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field5, ex, 4);
        SIGNDOC_Field_setLeft (field5, ex, 450);
        SIGNDOC_Field_setRight (field5, ex, 550);
        SIGNDOC_Field_setBottom (field5, ex, 1720);
        SIGNDOC_Field_setTop (field5, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field5, ex, tfa5);
        SIGNDOC_Field_setJustification(field5, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags5 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc5 = SIGNDOC_Document_addField (doc, ex, field5, set_field_flags5);

        if (rc5 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc5, "SIGNDOC_Document_addField");
          
        NSLog (@"5th Signature field added ");
        SIGNDOC_Field_delete (field5, ex);
        field5 = NULL;
        //}
        
        //if (buttonClicked == 6) {
        	// Insert 6th signature field
        tfa6 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa6, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa6, ex, 116);
          
        field6 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field6, ex, SIGNDOC_ENCODING_NATIVE, field_name_text7);
        SIGNDOC_Field_setType (field6, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field6, ex, 4);
        SIGNDOC_Field_setLeft (field6, ex, 450);
        SIGNDOC_Field_setRight (field6, ex, 550);
        SIGNDOC_Field_setBottom (field6, ex, 1720);
        SIGNDOC_Field_setTop (field6, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field6, ex, tfa6);
        SIGNDOC_Field_setJustification(field6, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags6 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc6 = SIGNDOC_Document_addField (doc, ex, field6, set_field_flags6);

        if (rc6 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc6, "SIGNDOC_Document_addField");
          
        NSLog (@"6th Signature field added ");
        SIGNDOC_Field_delete (field6, ex);
        field6 = NULL;
        //}
        
        //if (buttonClicked == 7) {
        	// Insert 7th signature field
        tfa7 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa7, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa7, ex, 116);
          
        field7 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field7, ex, SIGNDOC_ENCODING_NATIVE, field_name_text8);
        SIGNDOC_Field_setType (field7, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field7, ex, 4);
        SIGNDOC_Field_setLeft (field7, ex, 450);
        SIGNDOC_Field_setRight (field7, ex, 550);
        SIGNDOC_Field_setBottom (field7, ex, 1720);
        SIGNDOC_Field_setTop (field7, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field7, ex, tfa7);
        SIGNDOC_Field_setJustification(field7, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags7 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc7 = SIGNDOC_Document_addField (doc, ex, field7, set_field_flags7);

        if (rc7 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc7, "SIGNDOC_Document_addField");
          
        NSLog (@"7th Signature field added ");
        SIGNDOC_Field_delete (field7, ex);
        field7 = NULL;
        //}
        
        //if (buttonClicked == 8) {
        	// Insert 8th signature field
        tfa8 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa8, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa8, ex, 116);
          
        field8 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field8, ex, SIGNDOC_ENCODING_NATIVE, field_name_text9);
        SIGNDOC_Field_setType (field8, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field8, ex, 4);
        SIGNDOC_Field_setLeft (field8, ex, 450);
        SIGNDOC_Field_setRight (field8, ex, 550);
        SIGNDOC_Field_setBottom (field8, ex, 1720);
        SIGNDOC_Field_setTop (field8, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field8, ex, tfa8);
        SIGNDOC_Field_setJustification(field8, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags8 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc8 = SIGNDOC_Document_addField (doc, ex, field8, set_field_flags8);

        if (rc8 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc8, "SIGNDOC_Document_addField");
          
        NSLog (@"8th Signature field added ");
        SIGNDOC_Field_delete (field8, ex);
        field8 = NULL;
        //}
        
        //if (buttonClicked == 9) {
          // Insert 9th signature field
        tfa9 = SIGNDOC_TextFieldAttributes_new (ex);
        SIGNDOC_TextFieldAttributes_setFontName (tfa9, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
        SIGNDOC_TextFieldAttributes_setFontSize (tfa9, ex, 116);
          
        field9 = SIGNDOC_Field_new (ex);
        SIGNDOC_Field_setName (field9, ex, SIGNDOC_ENCODING_NATIVE, field_name_text10);
        SIGNDOC_Field_setType (field9, ex, SIGNDOC_FIELD_TYPE_TEXT);
        SIGNDOC_Field_setPage (field9, ex, 4);
        SIGNDOC_Field_setLeft (field9, ex, 450);
        SIGNDOC_Field_setRight (field9, ex, 550);
        SIGNDOC_Field_setBottom (field9, ex, 1720);
        SIGNDOC_Field_setTop (field9, ex, 1750);
        SIGNDOC_Field_setTextFieldAttributes (field9, ex, tfa9);
        SIGNDOC_Field_setJustification(field9, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
        int set_field_flags9 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        int rc9 = SIGNDOC_Document_addField (doc, ex, field9, set_field_flags9);

        if (rc9 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc9, "SIGNDOC_Document_addField");
          
        NSLog (@"9th Signature field added ");
        SIGNDOC_Field_delete (field9, ex);
        field9 = NULL;
        //}
        
        if (buttonClicked == 10) {
          //inserting image field
          img_tfa = SIGNDOC_TextFieldAttributes_new (ex);
          SIGNDOC_TextFieldAttributes_setFontName (img_tfa, ex, SIGNDOC_ENCODING_NATIVE, "Helvetica");
          SIGNDOC_TextFieldAttributes_setFontSize (img_tfa, ex, 116);
          
          img_field = SIGNDOC_Field_new (ex);
          SIGNDOC_Field_setName (img_field, ex, SIGNDOC_ENCODING_NATIVE, field_name_text3);
          SIGNDOC_Field_setType (img_field, ex, SIGNDOC_FIELD_TYPE_TEXT);
          SIGNDOC_Field_setPage (img_field, ex, 4);
          SIGNDOC_Field_setLeft (img_field, ex, 650);
          SIGNDOC_Field_setRight (img_field, ex, 750);
          SIGNDOC_Field_setBottom (img_field, ex, 1920);
          SIGNDOC_Field_setTop (img_field, ex, 1970);
          SIGNDOC_Field_setTextFieldAttributes (img_field, ex, img_tfa);
          SIGNDOC_Field_setJustification(img_field, ex, SIGNDOC_FIELD_JUSTIFICATION_LEFT);
          
          
          int set_img_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
          int img_rc = SIGNDOC_Document_addField (doc, ex, img_field, set_img_field_flags);
          
          if (img_rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
              failDoc (doc, img_rc, "SIGNDOC_Document_addField");
          
          NSLog (@"Image field added");
          SIGNDOC_Field_delete (img_field, ex);
          img_field = NULL;
        } 
      }
     }
       //changing the fields
      
        if (buttonClicked ==1)
        {
        // Signature field 1
        field = SIGNDOC_Field_new (ex);
        int rc = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text, field);
          
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_getField");

        int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc = SIGNDOC_Document_setField (doc, ex, field, set_field_flags);
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_setField");
        NSLog (@"1st Signature field changed");
        SIGNDOC_Field_delete (field, ex);
        field = NULL;
        }
        else if (buttonClicked ==2)
        {
          //signature field 2
          sfield = SIGNDOC_Field_new (ex);
          int src = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                               field_name_text2, sfield);
          if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
              failDoc (doc, src, "SIGNDOC_Document_getField");
          
          int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
          src = SIGNDOC_Document_setField (doc, ex, sfield, set_sfield_flags);
          if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
              failDoc (doc, src, "SIGNDOC_Document_setField");
          NSLog (@"2nd Signature field changed");
          SIGNDOC_Field_delete (sfield, ex);
          sfield = NULL;
        }
        else if (buttonClicked == 3)
        {
              
            /*//image field
            img_field = SIGNDOC_Field_new (ex);
            int img_rc = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                                 field_name_text3, img_field);
            if (img_rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, img_rc, "SIGNDOC_Document_getField");
            
            int set_img_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            img_rc = SIGNDOC_Document_setField (doc, ex, sfield, set_img_field_flags);
            if (img_rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, img_rc, "SIGNDOC_Document_setField");
            NSLog (@"Image field changed");
            SIGNDOC_Field_delete (img_field, ex);
            img_field = NULL;*/
            
            // Signature field 3
        field3 = SIGNDOC_Field_new (ex);
        int rc3 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text4, field3);
          
        if (rc3 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc3, "SIGNDOC_Document_getField");

        int set_field_flags3 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc3 = SIGNDOC_Document_setField (doc, ex, field3, set_field_flags3);
        if (rc3 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc3, "SIGNDOC_Document_setField");
        NSLog (@"3rd Signature field changed");
        SIGNDOC_Field_delete (field3, ex);
        field3 = NULL;
        }
        else if (buttonClicked == 4)
        {
            // Signature field 4
        field4 = SIGNDOC_Field_new (ex);
        int rc4 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text5, field4);
          
        if (rc4 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc4, "SIGNDOC_Document_getField");

        int set_field_flags4 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc4 = SIGNDOC_Document_setField (doc, ex, field4, set_field_flags4);
        if (rc4 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc4, "SIGNDOC_Document_setField");
        NSLog (@"4th Signature field changed");
        SIGNDOC_Field_delete (field4, ex);
        field4 = NULL;
        }
        else if (buttonClicked == 5)
        {
            // Signature field 5
        field5 = SIGNDOC_Field_new (ex);
        int rc5 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text6, field5);
          
        if (rc5 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc5, "SIGNDOC_Document_getField");

        int set_field_flags5 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc5 = SIGNDOC_Document_setField (doc, ex, field5, set_field_flags5);
        if (rc5 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc5, "SIGNDOC_Document_setField");
        NSLog (@"5th Signature field changed");
        SIGNDOC_Field_delete (field5, ex);
        field5 = NULL;
        }
        else if (buttonClicked == 6)
        {
            // Signature field 6
        field6 = SIGNDOC_Field_new (ex);
        int rc6 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text7, field6);
          
        if (rc6 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc6, "SIGNDOC_Document_getField");

        int set_field_flags6 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc6 = SIGNDOC_Document_setField (doc, ex, field6, set_field_flags6);
        if (rc6 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc6, "SIGNDOC_Document_setField");
        NSLog (@"6th Signature field changed");
        SIGNDOC_Field_delete (field6, ex);
        field6 = NULL;
        }
        else if (buttonClicked == 7)
        {
            // Signature field 7
        field7 = SIGNDOC_Field_new (ex);
        int rc7 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text8, field7);
          
        if (rc7 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc7, "SIGNDOC_Document_getField");

        int set_field_flags7 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc7 = SIGNDOC_Document_setField (doc, ex, field7, set_field_flags7);
        if (rc7 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc7, "SIGNDOC_Document_setField");
        NSLog (@"7th Signature field changed");
        SIGNDOC_Field_delete (field7, ex);
        field7 = NULL;
        }
        else if (buttonClicked == 8)
        {
            // Signature field 8
        field8 = SIGNDOC_Field_new (ex);
        int rc8 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text9, field8);
          
        if (rc8 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc8, "SIGNDOC_Document_getField");

        int set_field_flags8 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc8 = SIGNDOC_Document_setField (doc, ex, field8, set_field_flags8);
        if (rc8 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc8, "SIGNDOC_Document_setField");
        NSLog (@"8th Signature field changed");
        SIGNDOC_Field_delete (field8, ex);
        field8 = NULL;
        }
        else if (buttonClicked == 9)
        {
            // Signature field 9
        field9 = SIGNDOC_Field_new (ex);
        int rc9 = SIGNDOC_Document_getField (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            field_name_text10, field9);
          
        if (rc9 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc9, "SIGNDOC_Document_getField");

        int set_field_flags9 = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
        rc9 = SIGNDOC_Document_setField (doc, ex, field9, set_field_flags9);
        if (rc9 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc9, "SIGNDOC_Document_setField");
        NSLog (@"9th Signature field changed");
        SIGNDOC_Field_delete (field9, ex);
        field9 = NULL;
        }
     
      // Find text
            // Signture field 1
            pos = SIGNDOC_FindTextPositionArray_new ();
            if (pos == NULL)
                failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags = 0;
            int rc = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Life Assured", find_text_flags,
                                            pos);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc, "SIGNDOC_Document_findText");
            NSLog (@"Text positions: %u", SIGNDOC_FindTextPositionArray_count (pos));

        
            //signature field 2
            pos2 = SIGNDOC_FindTextPositionArray_new ();
            if (pos2 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags2 = 0;
            int src = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of 2nd Life Assured (If applicable)", find_text_flags2,
                                            pos2);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, src, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 2: %u", SIGNDOC_FindTextPositionArray_count (pos2));
            
            //signature field 3
            pos4 = SIGNDOC_FindTextPositionArray_new ();
            if (pos4 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags3 = 0;
            int rc3 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Policy Owner", find_text_flags3,
                                            pos4);
            if (rc3 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc3, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 3: %u", SIGNDOC_FindTextPositionArray_count (pos4));
            
            //signature field 4
            pos5 = SIGNDOC_FindTextPositionArray_new ();
            if (pos5 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags4 = 0;
            int rc4 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Contingent Owner", find_text_flags4,
                                            pos5);
            if (rc4 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc4, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 4: %u", SIGNDOC_FindTextPositionArray_count (pos5));
            
            //signature field 5
            pos6 = SIGNDOC_FindTextPositionArray_new ();
            if (pos6 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags5 = 0;
            int rc5 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Consenting First Trustee", find_text_flags5,
                                            pos6);
            if (rc5 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc5, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 5: %u", SIGNDOC_FindTextPositionArray_count (pos6));
            
            //signature field 6
            pos7 = SIGNDOC_FindTextPositionArray_new ();
            if (pos7 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags6 = 0;
            int rc6 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Consenting Second Trustee", find_text_flags6,
                                            pos7);
            if (rc6 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc6, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 6: %u", SIGNDOC_FindTextPositionArray_count (pos7));
            
            //signature field 7
            pos8 = SIGNDOC_FindTextPositionArray_new ();
            if (pos8 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags7 = 0;
            int rc7 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Father/Mother/Guardian", find_text_flags7,
                                            pos8);
            if (rc7 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc7, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 7: %u", SIGNDOC_FindTextPositionArray_count (pos8));
            
            //signature field 8
            pos9 = SIGNDOC_FindTextPositionArray_new ();
            if (pos9 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags8 = 0;
            int rc8 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Intermediary/Agent/Witness", find_text_flags8,
                                            pos9);
            if (rc8 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc8, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 8: %u", SIGNDOC_FindTextPositionArray_count (pos9));
            
            //signature field 9
            pos10 = SIGNDOC_FindTextPositionArray_new ();
            if (pos10 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
            int find_text_flags9 = 0;
            int rc9 = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                            1, 4, "Signature of Card Holder", find_text_flags9,
                                            pos10);
            if (rc9 != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc9, "SIGNDOC_Document_findText");
            NSLog (@"Text positions 9: %u", SIGNDOC_FindTextPositionArray_count (pos10));
        
       /* 
        //image field 1
        pos3 = SIGNDOC_FindTextPositionArray_new ();
        if (pos3 == NULL)
            failAlloc ("SIGNDOC_FindTextPositionArray_new");
        int find_text_flags3 = 0;
        int img_rc = SIGNDOC_Document_findText (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                             1, 4, "Signature of Policy Owner", find_text_flags3,
                                             pos3);
        if (img_rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, img_rc, "SIGNDOC_Document_findText");
        NSLog (@"Text positions: %u", SIGNDOC_FindTextPositionArray_count (pos3));
        
        */
        
        // first signature field
        if (SIGNDOC_FindTextPositionArray_count (pos) >= 1 && buttonClicked == 1)
            {
          // Insert signature field
          struct SIGNDOC_FindTextPosition *pos2 = SIGNDOC_FindTextPositionArray_at (pos, 0);
          struct SIGNDOC_CharacterPosition *pos3 = SIGNDOC_FindTextPosition_getLast (pos2, ex);
          struct SIGNDOC_Point *pos4 = SIGNDOC_CharacterPosition_getRef (pos3, ex);
          double x = SIGNDOC_Point_getX (pos4, ex);
          double y = SIGNDOC_Point_getY (pos4, ex);
          //NSLog (@"x=%g, y=%g", x, y);
          field = SIGNDOC_Field_new (ex);
          SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
          SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
          SIGNDOC_Field_setPage (field, ex, 4);
          
          //SIGNDOC_Field_setLeft (field, ex, x + 10);
          //SIGNDOC_Field_setRight (field, ex, x + 110);
          //SIGNDOC_Field_setBottom (field, ex, y - 30);
          //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            
            
          int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
          int rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
          if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc, "SIGNDOC_Document_addField");

          NSLog (@"1st Signature field added");

          // Sign

          NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
          NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
          const char *bio_path4 = [bio_path3 UTF8String];
          NSLog (@"bio file: %s", bio_path4);
          size_t bio_size = 0;
          unsigned char *bio_ptr = readFile (bio_path4, &bio_size);

          NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
          NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
          const char *bmp_path4 = [bmp_path3 UTF8String];
          NSLog (@"bmp file: %s", bmp_path4);
          size_t bmp_size = 0;
          unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);

          //signTest(field_name_sig, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
          //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
          
          NSLog (@"Document signed");
          doc_signed = 1;
          free (bio_ptr);
          free (bmp_ptr);
            }
        
        
        
            //second signature field
            if (SIGNDOC_FindTextPositionArray_count (pos2) >= 1 && buttonClicked == 2)
            {
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos2, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            sfield = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (sfield, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig2);
            SIGNDOC_Field_setType (sfield, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (sfield, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (sfield, ex, x - 100);
            SIGNDOC_Field_setRight (sfield, ex, x - 0);
            SIGNDOC_Field_setTop (sfield, ex, y + 80);
            SIGNDOC_Field_setBottom (sfield, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, sfield, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"2nd Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //third signature field
            if (SIGNDOC_FindTextPositionArray_count (pos4) >= 1 && buttonClicked == 3)
            {
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4a = SIGNDOC_FindTextPositionArray_at (pos4, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4a, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field3 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field3, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig4);
            SIGNDOC_Field_setType (field3, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field3, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field3, ex, x - 100);
            SIGNDOC_Field_setRight (field3, ex, x - 0);
            SIGNDOC_Field_setTop (field3, ex, y + 80);
            SIGNDOC_Field_setBottom (field3, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, sfield, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"3rd Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //fourth signature field
            if (SIGNDOC_FindTextPositionArray_count (pos5) >= 1 && buttonClicked == 4)
            {
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos5, 0);
            struct SIGNDOC_CharacterPosition *pos5a = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5a, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field4 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field4, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig5);
            SIGNDOC_Field_setType (field4, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field4, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field4, ex, x - 100);
            SIGNDOC_Field_setRight (field4, ex, x - 0);
            SIGNDOC_Field_setTop (field4, ex, y + 80);
            SIGNDOC_Field_setBottom (field4, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field4, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"4th Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //fifth signature field
            if (SIGNDOC_FindTextPositionArray_count (pos6) >= 1 && buttonClicked == 5)
            {
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos6, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6a = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6a, ex);
            double y = SIGNDOC_Point_getY (pos6a, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field5 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field5, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig6);
            SIGNDOC_Field_setType (field5, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field5, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field5, ex, x - 100);
            SIGNDOC_Field_setRight (field5, ex, x - 0);
            SIGNDOC_Field_setTop (field5, ex, y + 80);
            SIGNDOC_Field_setBottom (field5, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field5, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"5th Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //sixth signature field
            if (SIGNDOC_FindTextPositionArray_count (pos7) >= 1 && buttonClicked == 6)
            {NSLog(@"clicked6");
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos7, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field6 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field6, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig7);
            SIGNDOC_Field_setType (field6, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field6, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field6, ex, x - 100);
            SIGNDOC_Field_setRight (field6, ex, x - 0);
            SIGNDOC_Field_setTop (field6, ex, y + 80);
            SIGNDOC_Field_setBottom (field6, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field6, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"6th Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //seventh signature field
            if (SIGNDOC_FindTextPositionArray_count (pos8) >= 1 && buttonClicked == 7)
            {NSLog(@"clicked7");
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos8, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field7 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field7, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig8);
            SIGNDOC_Field_setType (field7, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field7, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field7, ex, x - 100);
            SIGNDOC_Field_setRight (field7, ex, x - 0);
            SIGNDOC_Field_setTop (field7, ex, y + 80);
            SIGNDOC_Field_setBottom (field7, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field7, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"7th Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //eighth signature field
            if (SIGNDOC_FindTextPositionArray_count (pos9) >= 1 && buttonClicked == 8)
            {NSLog(@"clicked8");
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos9, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field8 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field8, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig9);
            SIGNDOC_Field_setType (field8, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field8, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field8, ex, x - 100);
            SIGNDOC_Field_setRight (field8, ex, x - 0);
            SIGNDOC_Field_setTop (field8, ex, y + 80);
            SIGNDOC_Field_setBottom (field8, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field8, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"8thth Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //nineth signature field
            if (SIGNDOC_FindTextPositionArray_count (pos10) >= 1 && buttonClicked == 9)
            {NSLog(@"clicked9");
            // Insert signature field
            
            struct SIGNDOC_FindTextPosition *pos4 = SIGNDOC_FindTextPositionArray_at (pos10, 0);
            struct SIGNDOC_CharacterPosition *pos5 = SIGNDOC_FindTextPosition_getLast (pos4, ex);
            struct SIGNDOC_Point *pos6 = SIGNDOC_CharacterPosition_getRef (pos5, ex);
            double x = SIGNDOC_Point_getX (pos6, ex);
            double y = SIGNDOC_Point_getY (pos6, ex);
            //NSLog (@"x=%g, y=%g", x, y);
            /*
            field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
            SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field, ex, x - 100);
            SIGNDOC_Field_setRight (field, ex, x - 0);
            SIGNDOC_Field_setTop (field, ex, y + 80);
            SIGNDOC_Field_setBottom (field, ex, y + 20);
            */
            
            
            field9 = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (field9, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig10);
            SIGNDOC_Field_setType (field9, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (field9, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (field9, ex, x - 100);
            SIGNDOC_Field_setRight (field9, ex, x - 0);
            SIGNDOC_Field_setTop (field9, ex, y + 80);
            SIGNDOC_Field_setBottom (field9, ex, y + 20);
            
            
            /*
            int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
            if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, rc, "SIGNDOC_Document_addField");
            */
            
            int set_sfield_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int src = SIGNDOC_Document_addField (doc, ex, field9, set_sfield_flags);
            if (src != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, src, "SIGNDOC_Document_addField");
            
            NSLog (@"9th Signature field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }
        
        //image field
        if (SIGNDOC_FindTextPositionArray_count (pos3) >= 2)
        {
            // Insert image field
            
            struct SIGNDOC_FindTextPosition *pos6 = SIGNDOC_FindTextPositionArray_at (pos3, 0);
            struct SIGNDOC_CharacterPosition *pos7 = SIGNDOC_FindTextPosition_getLast (pos6, ex);
            struct SIGNDOC_Point *pos8 = SIGNDOC_CharacterPosition_getRef (pos7, ex);
            double x = SIGNDOC_Point_getX (pos8, ex);
            double y = SIGNDOC_Point_getY (pos8, ex);
            NSLog (@"x=%g, y=%g", x, y);
            /*
             field = SIGNDOC_Field_new (ex);
             SIGNDOC_Field_setName (field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig);
             SIGNDOC_Field_setType (field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
             SIGNDOC_Field_setPage (field, ex, 4);
             
             //SIGNDOC_Field_setLeft (field, ex, x + 10);
             //SIGNDOC_Field_setRight (field, ex, x + 110);
             //SIGNDOC_Field_setBottom (field, ex, y - 30);
             //SIGNDOC_Field_setTop (field, ex, y + 30);
             
             SIGNDOC_Field_setLeft (field, ex, x - 100);
             SIGNDOC_Field_setRight (field, ex, x - 0);
             SIGNDOC_Field_setTop (field, ex, y + 80);
             SIGNDOC_Field_setBottom (field, ex, y + 20);
             */
            
            
            img_field = SIGNDOC_Field_new (ex);
            SIGNDOC_Field_setName (img_field, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig3);
            SIGNDOC_Field_setType (img_field, ex, SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG);
            SIGNDOC_Field_setPage (img_field, ex, 4);
            
            //SIGNDOC_Field_setLeft (field, ex, x + 10);
            //SIGNDOC_Field_setRight (field, ex, x + 110);
            //SIGNDOC_Field_setBottom (field, ex, y - 30);
            //SIGNDOC_Field_setTop (field, ex, y + 30);
            
            SIGNDOC_Field_setLeft (img_field, ex, x - 100);
            SIGNDOC_Field_setRight (img_field, ex, x - 0);
            SIGNDOC_Field_setTop (img_field, ex, y + 80);
            SIGNDOC_Field_setBottom (img_field, ex, y + 20);
            
            
            /*
             int set_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
             rc = SIGNDOC_Document_addField (doc, ex, field, set_field_flags);
             if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
             failDoc (doc, rc, "SIGNDOC_Document_addField");
             */
            
            int set_img_field_flags = SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL;
            int img_rc = SIGNDOC_Document_addField (doc, ex, img_field, set_img_field_flags);
            if (img_rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
                failDoc (doc, img_rc, "SIGNDOC_Document_addField");
            
            NSLog (@"Image field added");
            
            // Sign
            
            NSString *bio_path2 = [NSString stringWithUTF8String:bio_path];
            NSString *bio_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bio_path2];
            const char *bio_path4 = [bio_path3 UTF8String];
            NSLog (@"bio file: %s", bio_path4);
            size_t bio_size = 0;
            unsigned char *bio_ptr = readFile (bio_path4, &bio_size);
            
            NSString *bmp_path2 = [NSString stringWithUTF8String:bmp_path];
            NSString *bmp_path3 = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bmp_path2];
            const char *bmp_path4 = [bmp_path3 UTF8String];
            NSLog (@"bmp file: %s", bmp_path4);
            size_t bmp_size = 0;
            unsigned char *bmp_ptr = readFile (bmp_path4, &bmp_size);
            
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            //signTest(field_name_sig2, bio_ptr, bio_size, bmp_ptr, bmp_size, test_output_file, TRUE);
            
            NSLog (@"Document signed");
            doc_signed = 1;
            free (bio_ptr);
            free (bmp_ptr);
        }

            //field_1 = field;
            //sfield_1 = sfield;
        
        /*
      if (doc_signed)
        {
          // Verify

          int rc = SIGNDOC_Document_verifySignature (doc, ex, SIGNDOC_ENCODING_NATIVE, field_name_sig, &ver);
          if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc, "SIGNDOC_Document_verifySignature");
          int ss = -17;
          rc = SIGNDOC_VerificationResult_getState (ver, ex, &ss);
          /** @todo SIGNDOC_VERIFICATIONRESULT_RETURNCODE_OK */
        
        /*
          if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failVer (ver, rc, "SIGNDOC_VerificationResult_getState");
          if (ss == SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_UNMODIFIED)
            NSLog (@"Document unmodified");
          else
            NSLog (@"State = %d", ss);
        }

      // Render page as image

      NSString *image_path2 = [NSString stringWithUTF8String:image_path];
      NSString *image_path3 = [doc_path stringByAppendingPathComponent:image_path2];
      const char *image_path4 = [image_path3 UTF8String];
      NSLog (@"Image file: %s", image_path4);
      remove (image_path4);

      blob = renderTest(1024);
      writeFile (image_path4, SIGNDOC_ByteArray_data (blob),
                 SIGNDOC_ByteArray_count (blob));
      NSLog (@"Image saved");

      if (!doc_signed)
        {
          // Save document
          int rc = SIGNDOC_Document_saveToFile_cset (doc, ex, SIGNDOC_ENCODING_NATIVE,
                                                 test_output_file, 0);
          if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
            failDoc (doc, rc, "SIGNDOC_Document_saveToFile_cset");
          NSLog (@"Document saved");
        }

      {
        // Check properties
        SIGNDOC_Document_delete (doc, ex);
        doc = NULL;

        doc = SIGNDOC_DocumentLoader_loadFromFile_cset (loader, ex, SIGNDOC_ENCODING_NATIVE, test_output_file, SIGNDOC_NO);
        if (doc == NULL)
          failLoader (loader, "SIGNDOC_DocumentLoader_loadFromFile_cset");

        char *v = NULL;
        int rc = SIGNDOC_Document_getStringProperty (doc, ex, SIGNDOC_ENCODING_NATIVE, "encrypted", "priv1", &v);
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_getStringProperty");
        NSLog (@"priv1=%s", v);
        if (strcmp (v, "one") != 0)
          NSLog (@"Wrong value for priv1");
        SIGNDOC_delete (v);

        v = NULL;
        rc = SIGNDOC_Document_getStringProperty (doc, ex, SIGNDOC_ENCODING_NATIVE, "public", "pub2", &v);
        if (rc != SIGNDOC_DOCUMENT_RETURNCODE_OK)
          failDoc (doc, rc, "SIGNDOC_Document_getStringProperty");
        NSLog (@"pub2=%s", v);
        if (strcmp (v, "two") != 0)
          NSLog (@"Wrong value for pub2");
        SIGNDOC_delete (v);
      }
    */
        
    }
  @catch (NSException *e)
    {
      NSLog (@"Exception: %@", e);
    }
  @finally
    {
        
      NSLog (@"Executing finally clause");
      if (blob != NULL)
        SIGNDOC_ByteArray_delete (blob);
      if (ver != NULL)
        SIGNDOC_VerificationResult_delete (ver, ex);
      if (tfa != NULL)
        SIGNDOC_TextFieldAttributes_delete (tfa, ex);
      if (field != NULL)
        SIGNDOC_Field_delete (field, ex);
      if (pos != NULL)
          SIGNDOC_FindTextPositionArray_delete (pos);
      if (stfa != NULL)
            SIGNDOC_TextFieldAttributes_delete (stfa, ex);
      if (sfield != NULL)
            SIGNDOC_Field_delete (sfield, ex);
      if (pos2 != NULL)
            SIGNDOC_FindTextPositionArray_delete (pos2);
    }
  NSLog (@"Test done");
}

static void checkDocumentRC(struct SIGNDOC_Document *doc, int rc, const char *fun)
{
    if (rc == SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_OK)
        return;
    else
        failDoc(doc,rc,fun);
}

void resetSignatures ()
{
    int rc = SIGNDOC_Document_clearAllSignatures(doc,ex);
    checkDocumentRC(doc,rc,"SIGNDOC_Document_clearAllSignatures");
    
}





