//
//  test.h
//  SDTest1
//
//  Created by Eugen Laukart on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

void doTest ();
//added for 2nd signature
//void resetSignatures (const char *fieldName);
void resetSignatures ();

void initTest ();
void uninit ();
int signTest (const char *field_name_sig, unsigned char *signature_data, size_t signature_size, unsigned char *signature_img, size_t image_size, char *dst_file, BOOL selfSigned);
struct SIGNDOC_ByteArray *renderTest(unsigned int height, unsigned int width, int page);

extern NSInteger buttonClicked;
extern NSInteger hasInit;
extern NSInteger doc_signed;
extern NSInteger resetSig;
//static void clearSignatures();
static void checkDocumentRC(struct SIGNDOC_Document *doc, int rc, const char *fun);
unsigned char *readFile (const char *path, size_t *size);