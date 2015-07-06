
/*=====================================k========== -*- C -*- ==*
 * SignDocShared
 *
 * Module: SPSignDocCAPI.h
 * Created by: ndu
 * Version: $$Name$$
 * 
 * @(#)SPSignDocCAPI.h
 * 
 * Copyright SOFTPRO GmbH,
 * Wilhelmstrasse 34, D-71034 Böblingen
 * All rights reserved.
 *
 * This software is the confidential and proprietary
 * information of SOFTPRO ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license
 * agreement you entered into with SOFTPRO.
 *==============================================================*/

/*
	*****************************************
	* AUTOMATICALLY GENERATED with capi_h.xsl *
	*****************************************
*/

/**
 * @file SPSignDocCAPI.h
 * @author ndu
 * @brief C API wrapper for SignDoc SDK
 *
 */

#include <stdio.h>
#include <wchar.h>

#ifdef __cplusplus
  extern "C" {
#endif

#ifdef _MSC_VER
#define SDCAPI __stdcall
#else
#define SDCAPI
#endif

#define SIGNDOC_YES	1
#define SIGNDOC_NO	0

/**
 * @var const SIGNDOC_EXCEPTION_BAD_ALLOC
 * @memberof SIGNDOC_Exception
 */
#define SIGNDOC_EXCEPTION_BAD_ALLOC 1

/**
 * @var const SIGNDOC_EXCEPTION_PDF
 * @memberof SIGNDOC_Exception
 */
#define SIGNDOC_EXCEPTION_PDF		2

/**
 * @var const SIGNDOC_EXCEPTION_STL
 * @memberof SIGNDOC_Exception
 */
#define SIGNDOC_EXCEPTION_STL		3

/**
 * @var const SIGNDOC_EXCEPTION_GENERIC
 * @memberof SIGNDOC_Exception
 */
#define SIGNDOC_EXCEPTION_GENERIC	4

/**
 * @var const SIGNDOC_EXCEPTION_SPOOC
 * @memberof SIGNDOC_Exception
 */
#define SIGNDOC_EXCEPTION_SPOOC		5
/**
 * @var const SIGNDOC_ANNOTATION_TYPE_UNKNOWN
 * @brief Unknown annotation type. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_TYPE_UNKNOWN (1 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_TYPE_LINE
 * @brief Line annotation. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_TYPE_LINE (2 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_TYPE_SCRIBBLE
 * @brief Scribble annotation (freehand scribble). 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_TYPE_SCRIBBLE (3 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_TYPE_FREETEXT
 * @brief FreeText annotation. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_TYPE_FREETEXT (4 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_LINEENDING_UNKNOWN
 * @brief Unknown line ending style. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_LINEENDING_UNKNOWN (1 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_LINEENDING_NONE
 * @brief No line ending. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_LINEENDING_NONE (2 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_LINEENDING_ARROW
 * @brief Two short lines forming an arrowhead. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_LINEENDING_ARROW (3 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_HALIGNMENT_LEFT
 * @brief 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_HALIGNMENT_LEFT (1 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_HALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_HALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_HALIGNMENT_RIGHT
 * @brief 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_HALIGNMENT_RIGHT (3 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_RETURNCODE_OK
 * @brief Parameter set successfully. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_RETURNCODE_OK (1 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_RETURNCODE_NOT_SUPPORTED
 * @brief Setting the parameter is not supported. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_RETURNCODE_NOT_SUPPORTED (2 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_RETURNCODE_INVALID_VALUE
 * @brief The value for the parameter is invalid. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_RETURNCODE_INVALID_VALUE (3 - 1)

/**
 * @var const SIGNDOC_ANNOTATION_RETURNCODE_NOT_AVAILABLE
 * @brief The value is not available. 
 * @memberof  SIGNDOC_Annotation
 */
#define SIGNDOC_ANNOTATION_RETURNCODE_NOT_AVAILABLE (4 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_DOCUMENTTYPE_UNKNOWN
 * @brief For SignDocDocumentLoader::ping(). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_DOCUMENTTYPE_UNKNOWN (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_DOCUMENTTYPE_PDF
 * @brief PDF document. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_DOCUMENTTYPE_PDF (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_DOCUMENTTYPE_TIFF
 * @brief TIFF document. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_DOCUMENTTYPE_TIFF (3 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_DOCUMENTTYPE_OTHER
 * @brief Other document. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_DOCUMENTTYPE_OTHER (4 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_DOCUMENTTYPE_FDF
 * @brief FDF document. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_DOCUMENTTYPE_FDF (5 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_SAVEFLAGS_INCREMENTAL
 * @brief Save incrementally (PDF). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SAVEFLAGS_INCREMENTAL ( 0x01)
/**
 * @var const SIGNDOC_DOCUMENT_SAVEFLAGS_REMOVE_UNUSED
 * @brief Remove unused objects (PDF). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SAVEFLAGS_REMOVE_UNUSED ( 0x02)
/**
 * @var const SIGNDOC_DOCUMENT_SAVEFLAGS_LINEARIZED
 * @brief Linearize the document (PDF). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SAVEFLAGS_LINEARIZED ( 0x04)
/**
 * @var const SIGNDOC_DOCUMENT_SAVEFLAGS_PDF_1_4
 * @brief Do not use features introduced after PDF 1.4 for saving the document. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SAVEFLAGS_PDF_1_4 ( 0x08)
/**
 * @var const SIGNDOC_DOCUMENT_SAVEFLAGS_PDFA_BUTTONS
 * @brief Fix appearance streams of check boxes and radio buttons for PDF/A documents. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SAVEFLAGS_PDFA_BUTTONS ( 0x10)
/**
 * @var const SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL
 * @brief Fail if no suitable font is found. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_FAIL ( 0x01)
/**
 * @var const SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_WARN
 * @brief Warn if no suitable font is found. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_WARN ( 0x02)
/**
 * @var const SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_IGNORE
 * @brief Ignore font problems. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_SETFIELDFLAGS_FONT_IGNORE ( 0x04)
/**
 * @var const SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_HSPACE
 * @brief Ignore horizontal whitespace (may be required). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_HSPACE ( 0x0001)
/**
 * @var const SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_HYPHENATION
 * @brief Ignore hyphenation (not yet implemented). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_HYPHENATION ( 0x0002)
/**
 * @var const SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_SEQUENCE
 * @brief Use character positions instead of sequence (can be expensive, not yet implemented). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_FINDTEXTFLAGS_IGNORE_SEQUENCE ( 0x0004)
/**
 * @var const SIGNDOC_DOCUMENT_EXPORTFLAGS_TOP
 * @brief Include XML declaration and schema for top-level element. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_EXPORTFLAGS_TOP ( 0x01)
/**
 * @var const SIGNDOC_DOCUMENT_IMPORTFLAGS_ATOMIC
 * @brief Modify all properties from XML or none (on error). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_IMPORTFLAGS_ATOMIC ( 0x01)
/**
 * @var const SIGNDOC_DOCUMENT_IMPORTIMAGEFLAGS_KEEP_ASPECT_RATIO
 * @brief Keep aspect ratio of image, center image on white background. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_IMPORTIMAGEFLAGS_KEEP_ASPECT_RATIO ( 0x01)
/**
 * @var const SIGNDOC_DOCUMENT_IMPORTIMAGEFLAGS_BRIGHTEST_TRANSPARENT
 * @brief Make the brightest color transparent. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_IMPORTIMAGEFLAGS_BRIGHTEST_TRANSPARENT ( 0x02)
/**
 * @var const SIGNDOC_DOCUMENT_KEEPORREMOVE_KEEP
 * @brief Keep the specified pages, remove all other pages. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_KEEPORREMOVE_KEEP (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_KEEPORREMOVE_REMOVE
 * @brief Remove the specified pages, keep all other pages. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_KEEPORREMOVE_REMOVE (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_OK
 * @brief No error. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_OK (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_INVALID_ARGUMENT
 * @brief Invalid argument. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_INVALID_ARGUMENT (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_FIELD_NOT_FOUND
 * @brief Field not found (or not a signature field). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_FIELD_NOT_FOUND (3 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_INVALID_PROFILE
 * @brief Profile unknown or not applicable. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_INVALID_PROFILE (4 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_INVALID_IMAGE
 * @brief Invalid image (e.g., unsupported format). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_INVALID_IMAGE (5 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_TYPE_MISMATCH
 * @brief Field type or property type mismatch. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_TYPE_MISMATCH (6 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_FONT_NOT_FOUND
 * @brief The requested font could not be found or does not contain all required characters. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_FONT_NOT_FOUND (7 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_NO_DATABLOCK
 * @brief No datablock found. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_NO_DATABLOCK (8 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_NOT_SUPPORTED
 * @brief Operation not supported. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_NOT_SUPPORTED (9 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_IO_ERROR
 * @brief I/O error. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_IO_ERROR (10 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_NOT_VERIFIED
 * @brief (used by SignDocVerificationResult) 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_NOT_VERIFIED (11 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_PROPERTY_NOT_FOUND
 * @brief Property not found. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_PROPERTY_NOT_FOUND (12 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_PAGE_NOT_FOUND
 * @brief Page not found (invalid page number). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_PAGE_NOT_FOUND (13 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_WRONG_COLLECTION
 * @brief Property accessed via wrong collection. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_WRONG_COLLECTION (14 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_FIELD_EXISTS
 * @brief Field already exists. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_FIELD_EXISTS (15 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_LICENSE_ERROR
 * @brief License initialization failed or license check failed. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_LICENSE_ERROR (16 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_UNEXPECTED_ERROR
 * @brief Unexpected error. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_UNEXPECTED_ERROR (17 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_CANCELLED
 * @brief Certificate dialog cancelled by user. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_CANCELLED (18 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_NO_BIOMETRIC_DATA
 * @brief (used by SignDocVerificationResult) 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_NO_BIOMETRIC_DATA (19 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_PARAMETER_NOT_SET
 * @brief (Java only) 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_PARAMETER_NOT_SET (20 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_FIELD_NOT_SIGNED
 * @brief Field not signed, for copyAsSignedToStream(). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_FIELD_NOT_SIGNED (21 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_INVALID_SIGNATURE
 * @brief Signature is not valid, for copyAsSignedToStream(). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_INVALID_SIGNATURE (22 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_ANNOTATION_NOT_FOUND
 * @brief Annotation not found, for getAnnotation(). 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_ANNOTATION_NOT_FOUND (23 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_ATTACHMENT_NOT_FOUND
 * @brief Attachment not found. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_ATTACHMENT_NOT_FOUND (24 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_ATTACHMENT_EXISTS
 * @brief Attachment already exists. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_ATTACHMENT_EXISTS (25 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_NO_CERTIFICATE
 * @brief No (matching) certificate found and csf_create_self_signed is not specified. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_NO_CERTIFICATE (26 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_RETURNCODE_AMBIGUOUS_CERTIFICATE
 * @brief More than one matching certificate found and csf_never_ask is specified. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_RETURNCODE_AMBIGUOUS_CERTIFICATE (27 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_MATCH
 * @brief The attachment matches its checksum. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_MATCH (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_NO_CHECKSUM
 * @brief The attachment does not have a checksum. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_NO_CHECKSUM (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_MISMATCH
 * @brief The attachment does not match its checksum. 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_CHECKATTACHMENTRESULT_MISMATCH (3 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_HALIGNMENT_LEFT
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_HALIGNMENT_LEFT (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_HALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_HALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_HALIGNMENT_RIGHT
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_HALIGNMENT_RIGHT (3 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_VALIGNMENT_TOP
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_VALIGNMENT_TOP (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_VALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_VALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_DOCUMENT_VALIGNMENT_BOTTOM
 * @brief 
 * @memberof  SIGNDOC_Document
 */
#define SIGNDOC_DOCUMENT_VALIGNMENT_BOTTOM (3 - 1)

/**
 * @var const SIGNDOC_DOCUMENTLOADER_REMAININGDAYS_PRODUCT
 * @brief Use the expiry date for the product. 
 * @memberof  SIGNDOC_DocumentLoader
 */
#define SIGNDOC_DOCUMENTLOADER_REMAININGDAYS_PRODUCT (1 - 1)

/**
 * @var const SIGNDOC_DOCUMENTLOADER_REMAININGDAYS_SIGNING
 * @brief Use the expiry date for signing documents. 
 * @memberof  SIGNDOC_DocumentLoader
 */
#define SIGNDOC_DOCUMENTLOADER_REMAININGDAYS_SIGNING (2 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_UNKNOWN
 * @brief Unknown type. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_UNKNOWN (1 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_PUSHBUTTON
 * @brief Pushbutton (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_PUSHBUTTON (2 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_CHECK_BOX
 * @brief Check box field (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_CHECK_BOX (3 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_RADIO_BUTTON
 * @brief Radio button (radio button group) (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_RADIO_BUTTON (4 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_TEXT
 * @brief Text field (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_TEXT (5 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_LIST_BOX
 * @brief List box (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_LIST_BOX (6 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG
 * @brief Digital signature field (Adobe DigSig in PDF, SOFTPRO signature in TIFF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_SIGNATURE_DIGSIG (7 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_SIGNATURE_SIGNDOC
 * @brief Digital signature field (traditional SignDoc) (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_SIGNATURE_SIGNDOC (8 - 1)

/**
 * @var const SIGNDOC_FIELD_TYPE_COMBO_BOX
 * @brief Combo box (drop-down box) (PDF). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_TYPE_COMBO_BOX (9 - 1)

/**
 * @var const SIGNDOC_FIELD_FLAG_READONLY
 * @brief ReadOnly. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_READONLY ( 1 << 0)
/**
 * @var const SIGNDOC_FIELD_FLAG_REQUIRED
 * @brief Required. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_REQUIRED ( 1 << 1)
/**
 * @var const SIGNDOC_FIELD_FLAG_NOEXPORT
 * @brief NoExport. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_NOEXPORT ( 1 << 2)
/**
 * @var const SIGNDOC_FIELD_FLAG_NOTOGGLETOOFF
 * @brief NoToggleToOff. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_NOTOGGLETOOFF ( 1 << 3)
/**
 * @var const SIGNDOC_FIELD_FLAG_RADIO
 * @brief Radio. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_RADIO ( 1 << 4)
/**
 * @var const SIGNDOC_FIELD_FLAG_PUSHBUTTON
 * @brief Pushbutton. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_PUSHBUTTON ( 1 << 5)
/**
 * @var const SIGNDOC_FIELD_FLAG_RADIOSINUNISON
 * @brief RadiosInUnison. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_RADIOSINUNISON ( 1 << 6)
/**
 * @var const SIGNDOC_FIELD_FLAG_MULTILINE
 * @brief Multiline (for text fields). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_MULTILINE ( 1 << 7)
/**
 * @var const SIGNDOC_FIELD_FLAG_PASSWORD
 * @brief Password. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_PASSWORD ( 1 << 8)
/**
 * @var const SIGNDOC_FIELD_FLAG_FILESELECT
 * @brief FileSelect. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_FILESELECT ( 1 << 9)
/**
 * @var const SIGNDOC_FIELD_FLAG_DONOTSPELLCHECK
 * @brief DoNotSpellCheck. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_DONOTSPELLCHECK ( 1 << 10)
/**
 * @var const SIGNDOC_FIELD_FLAG_DONOTSCROLL
 * @brief DoNotScroll. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_DONOTSCROLL ( 1 << 11)
/**
 * @var const SIGNDOC_FIELD_FLAG_COMB
 * @brief Comb. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_COMB ( 1 << 12)
/**
 * @var const SIGNDOC_FIELD_FLAG_RICHTEXT
 * @brief RichText. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_RICHTEXT ( 1 << 13)
/**
 * @var const SIGNDOC_FIELD_FLAG_COMBO
 * @brief Combo (always set for combo boxes). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_COMBO ( 1 << 14)
/**
 * @var const SIGNDOC_FIELD_FLAG_EDIT
 * @brief Edit (for combo boxes): If this flag is set, the user can enter an arbitrary value. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_EDIT ( 1 << 15)
/**
 * @var const SIGNDOC_FIELD_FLAG_SORT
 * @brief Sort (for list boxes and combo boxes). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_SORT ( 1 << 16)
/**
 * @var const SIGNDOC_FIELD_FLAG_MULTISELECT
 * @brief MultiSelect (for list boxes). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_MULTISELECT ( 1 << 17)
/**
 * @var const SIGNDOC_FIELD_FLAG_COMMITONSELCHANGE
 * @brief CommitOnSelChange (for list boxes and combo boxes). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_COMMITONSELCHANGE ( 1 << 18)
/**
 * @var const SIGNDOC_FIELD_FLAG_SINGLEPAGE
 * @brief Signature applies to the containing page only (TIFF only). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_SINGLEPAGE ( 1 << 28)
/**
 * @var const SIGNDOC_FIELD_FLAG_ENABLEADDAFTERSIGNING
 * @brief Signature fields can be inserted after signing this field (TIFF only). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_ENABLEADDAFTERSIGNING ( 1 << 29)
/**
 * @var const SIGNDOC_FIELD_FLAG_INVISIBLE
 * @brief Invisible (TIFF only). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_FLAG_INVISIBLE ( 1 << 30)
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_INVISIBLE
 * @brief do not display non-standard annotation 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_INVISIBLE ( 1 << (1 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_HIDDEN
 * @brief do not display or print or interact 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_HIDDEN ( 1 << (2 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_PRINT
 * @brief print the annotation 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_PRINT ( 1 << (3 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_NOZOOM
 * @brief do not scale to match magnification 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_NOZOOM ( 1 << (4 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_NOROTATE
 * @brief do not rotate to match page's rotation 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_NOROTATE ( 1 << (5 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_NOVIEW
 * @brief do not display or interact 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_NOVIEW ( 1 << (6 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_READONLY
 * @brief do not interact 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_READONLY ( 1 << (7 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_LOCKED
 * @brief annotation cannot be deleted or modified, but its value can be changed 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_LOCKED ( 1 << (8 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_TOGGLENOVIEW
 * @brief toggle wf_no_view for certain events 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_TOGGLENOVIEW ( 1 << (9 - 1))
/**
 * @var const SIGNDOC_FIELD_WIDGETFLAG_LOCKEDCONTENTS
 * @brief value cannot be changed 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_WIDGETFLAG_LOCKEDCONTENTS ( 1 << (10 - 1))
/**
 * @var const SIGNDOC_FIELD_JUSTIFICATION_NONE
 * @brief Non-text field (justification does not apply). 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_JUSTIFICATION_NONE (1 - 1)

/**
 * @var const SIGNDOC_FIELD_JUSTIFICATION_LEFT
 * @brief Left-justified. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_JUSTIFICATION_LEFT (2 - 1)

/**
 * @var const SIGNDOC_FIELD_JUSTIFICATION_CENTER
 * @brief Centered. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_JUSTIFICATION_CENTER (3 - 1)

/**
 * @var const SIGNDOC_FIELD_JUSTIFICATION_RIGHT
 * @brief Right-justified. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_JUSTIFICATION_RIGHT (4 - 1)

/**
 * @var const SIGNDOC_FIELD_LOCKTYPE_NA
 * @brief Not a signature field. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_LOCKTYPE_NA (1 - 1)

/**
 * @var const SIGNDOC_FIELD_LOCKTYPE_NONE
 * @brief Don't lock any fields. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_LOCKTYPE_NONE (2 - 1)

/**
 * @var const SIGNDOC_FIELD_LOCKTYPE_ALL
 * @brief Lock all fields in the document. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_LOCKTYPE_ALL (3 - 1)

/**
 * @var const SIGNDOC_FIELD_LOCKTYPE_INCLUDE
 * @brief Lock all lock fields specified by addLockField() etc. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_LOCKTYPE_INCLUDE (4 - 1)

/**
 * @var const SIGNDOC_FIELD_LOCKTYPE_EXCLUDE
 * @brief Lock all fields except the lock fields specified by addLockField() etc. 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_LOCKTYPE_EXCLUDE (5 - 1)

/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_SUBJECTCERT
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_SUBJECTCERT ( 0x01)
/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_ISSUERCERT
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_ISSUERCERT ( 0x02)
/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_POLICY
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_POLICY ( 0x04)
/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_SUBJECTDN
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_SUBJECTDN ( 0x08)
/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_KEYUSAGE
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_KEYUSAGE ( 0x20)
/**
 * @var const SIGNDOC_FIELD_CERTSEEDVALUEFLAG_URL
 * @brief 
 * @memberof  SIGNDOC_Field
 */
#define SIGNDOC_FIELD_CERTSEEDVALUEFLAG_URL ( 0x40)
/**
 * @var const SIGNDOC_PROPERTY_TYPE_STRING
 * @brief 
 * @memberof  SIGNDOC_Property
 */
#define SIGNDOC_PROPERTY_TYPE_STRING (1 - 1)

/**
 * @var const SIGNDOC_PROPERTY_TYPE_INTEGER
 * @brief 
 * @memberof  SIGNDOC_Property
 */
#define SIGNDOC_PROPERTY_TYPE_INTEGER (2 - 1)

/**
 * @var const SIGNDOC_PROPERTY_TYPE_BOOLEAN
 * @brief 
 * @memberof  SIGNDOC_Property
 */
#define SIGNDOC_PROPERTY_TYPE_BOOLEAN (3 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_INTERLACING_OFF
 * @brief No interlacing. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_INTERLACING_OFF (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_INTERLACING_ON
 * @brief Enable Interlacing. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_INTERLACING_ON (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_QUALITY_LOW
 * @brief Low quality, fast. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_QUALITY_LOW (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_QUALITY_HIGH
 * @brief High quality, slow. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_QUALITY_HIGH (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_PIXELFORMAT_DEFAULT
 * @brief RGB for PDF documents, same as document for TIFF documents. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_PIXELFORMAT_DEFAULT (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_PIXELFORMAT_BW
 * @brief Black and white (1 bit per pixel). 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_PIXELFORMAT_BW (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_DEFAULT
 * @brief no compression for PDF documents, same as document for TIFF documents 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_DEFAULT (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_NONE
 * @brief no compression 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_NONE (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_GROUP4
 * @brief CCITT Group 4. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_GROUP4 (3 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_LZW
 * @brief LZW. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_LZW (4 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_RLE
 * @brief RLE. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_RLE (5 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_COMPRESSION_ZIP
 * @brief ZIP. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_COMPRESSION_ZIP (6 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_DONT_VERIFY
 * @brief Don't verify certificate chain. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_DONT_VERIFY (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED
 * @brief Accept self-signed certificates. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_BIO
 * @brief Accept self-signed certificates if biometric data is present. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_BIO (3 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_RSA_BIO
 * @brief Accept self-signed certificates if asymmetrically encrypted biometric data is present. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_RSA_BIO (4 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_REQUIRE_TRUSTED_ROOT
 * @brief Require a trusted root certificate. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATECHAINVERIFICATIONPOLICY_REQUIRE_TRUSTED_ROOT (5 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_DONT_CHECK
 * @brief Don't verify revocation of certificates. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_DONT_CHECK (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_OFFLINE
 * @brief Check revocation, assume that certificates are not revoked if the revocation server is offline. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_OFFLINE (2 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_ONLINE
 * @brief Check revocation, assume that certificates are revoked if the revocation server is offline. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_ONLINE (3 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_VERIFICATIONMODEL_WINDOWS
 * @brief Whatever the Windows Crypto API or OpenSSL implements. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_VERIFICATIONMODEL_WINDOWS (1 - 1)

/**
 * @var const SIGNDOC_RENDERPARAMETERS_VERIFICATIONMODEL_GERMAN_SIG_LAW
 * @brief As specfified by German law. 
 * @memberof  SIGNDOC_RenderParameters
 */
#define SIGNDOC_RENDERPARAMETERS_VERIFICATIONMODEL_GERMAN_SIG_LAW (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_METHOD_SIGNDOC
 * @brief Traditional SignDoc (with data block). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_METHOD_SIGNDOC (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS1
 * @brief PDF DigSig PKCS #1. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS1 (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS7_DETACHED
 * @brief PDF DigSig detached PKCS #7. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS7_DETACHED (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS7_SHA1
 * @brief PDF DigSig PKCS #7 with SHA-1. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_METHOD_DIGSIG_PKCS7_SHA1 (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_METHOD_HASH
 * @brief The signature is just a hash. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_METHOD_HASH (5 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_DEFAULT
 * @brief Best supported hash algorithm. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_DEFAULT (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_SHA1
 * @brief SHA-1. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_SHA1 (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_SHA256
 * @brief SHA-256. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_DETACHEDHASHALGORITHM_SHA256 (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_OPTIMIZE_OPTIMIZE
 * @brief Optimize document before signing for the first time. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_OPTIMIZE_OPTIMIZE (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_OPTIMIZE_DONT_OPTIMIZE
 * @brief Don't optimize document. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_OPTIMIZE_DONT_OPTIMIZE (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_FREEZE
 * @brief Freeze (fix) appearances. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_FREEZE (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_DONT_FREEZE
 * @brief Don't freeze (fix) appearances. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_DONT_FREEZE (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_AUTO
 * @brief Freeze (fix) appearances if appropriate. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PDFABUTTONS_AUTO (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESIGNINGALGORITHM_SHA1_RSA
 * @brief SHA1 with RSA. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESIGNINGALGORITHM_SHA1_RSA (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESIGNINGALGORITHM_MD5_RSA
 * @brief MD5 with RSA. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESIGNINGALGORITHM_MD5_RSA (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_RSA
 * @brief Random session key encrypted with public RSA key. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_RSA (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_FIXED
 * @brief Fixed key (no security). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_FIXED (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_BINARY
 * @brief Binary 256-bit key. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_BINARY (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_PASSPHRASE
 * @brief Passphrase that will be hashed to a 256-bit key. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_PASSPHRASE (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_DONT_STORE
 * @brief The biometric data won't be stored in the document. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_BIOMETRICENCRYPTION_DONT_STORE (5 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_LEFT
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_LEFT (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_RIGHT
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_RIGHT (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_JUSTIFY
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_HALIGNMENT_JUSTIFY (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_TOP
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_TOP (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_BOTTOM
 * @brief 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALIGNMENT_BOTTOM (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_OVERLAY
 * @brief Text and image are independent and overlap (text painted on image). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_OVERLAY (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_BELOW
 * @brief Text is put below the image, the image is scaled to fit. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_BELOW (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_UNDERLAY
 * @brief Text and image are independent and overlap (image painted on text). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTPOSITION_UNDERLAY (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_ABS
 * @brief aValue is the value to be used (units of document coordinates). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_ABS (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_FIELD_HEIGHT
 * @brief Multiply aValue by the field height. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_FIELD_HEIGHT (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_FIELD_WIDTH
 * @brief Multiply aValue by the field width. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_VALUETYPE_FIELD_WIDTH (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_SIGNER
 * @brief String parameter "Signer". 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_SIGNER (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_SIGN_TIME
 * @brief String parameter "SignTime". 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_SIGN_TIME (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_COMMENT
 * @brief String parameter "Comment". 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_COMMENT (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_ADVISER
 * @brief String parameter "Adviser". 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTITEM_ADVISER (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTGROUP_MASTER
 * @brief Master group. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTGROUP_MASTER (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_TEXTGROUP_SLAVE
 * @brief Slave group. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_TEXTGROUP_SLAVE (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_SOFTWARE
 * @brief include software-based certificates 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_SOFTWARE ( 0x01)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_HARDWARE
 * @brief include hardware-based certificates 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_HARDWARE ( 0x02)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_USE_CERTIFICATE_SEED_VALUES
 * @brief include only certificates allowed by the PDF document's certificate seed value dictionary 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_USE_CERTIFICATE_SEED_VALUES ( 0x10)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_ASK_IF_AMBIGUOUS
 * @brief ask the user to select a certificate if there is more than one matching certificate 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_ASK_IF_AMBIGUOUS ( 0x20)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_NEVER_ASK
 * @brief never ask the user to select a certificate; exactly one certificate must match 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_NEVER_ASK ( 0x40)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_CREATE_SELF_SIGNED
 * @brief offer to create a self-signed certificate (cannot be used with csf_never_ask and csf_ask_if_ambiguous) 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_CERTIFICATESELECTIONFLAGS_CREATE_SELF_SIGNED ( 0x80)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_BW
 * @brief black and white 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_BW ( 0x01)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_GRAY
 * @brief use gray levels computed from pressure 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_GRAY ( 0x02)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_ANTIALIAS
 * @brief use gray levels for antialiasing 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RENDERSIGNATUREFLAGS_ANTIALIAS ( 0x04)
/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_IMAGETRANSPARENCY_OPAQUE
 * @brief Make signature image opaque. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_IMAGETRANSPARENCY_OPAQUE (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_IMAGETRANSPARENCY_BRIGHTEST
 * @brief Make the brightest color transparent. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_IMAGETRANSPARENCY_BRIGHTEST (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_OK
 * @brief Parameter set successfully. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_OK (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_UNKNOWN
 * @brief Unknown parameter. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_UNKNOWN (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_NOT_SUPPORTED
 * @brief Setting the parameter is not supported. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_NOT_SUPPORTED (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_INVALID_VALUE
 * @brief The value for the parameter is invalid. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_RETURNCODE_INVALID_VALUE (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_SET
 * @brief Parameter has been set (most parameters have a default value such as the empty string which may be treated as "set" or "not set" depending on the implementation's fancy). 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_SET (1 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_MISSING
 * @brief Parameter must be set but is not set. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_MISSING (2 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_SUPPORTED
 * @brief Parameter is supported and optional, but has not been set or is set to the default value. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_SUPPORTED (3 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_IGNORED
 * @brief Parameter can be (or is) set but will be ignored. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_IGNORED (4 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_NOT_SUPPORTED
 * @brief Parameter is not supported for this field. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_NOT_SUPPORTED (5 - 1)

/**
 * @var const SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_UNKNOWN
 * @brief Unknown parameter. 
 * @memberof  SIGNDOC_SignatureParameters
 */
#define SIGNDOC_SIGNATUREPARAMETERS_PARAMETERSTATE_UNKNOWN (6 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_OK
 * @brief No error. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_OK (SIGNDOC_DOCUMENT_RETURNCODE_OK)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_INVALID_ARGUMENT
 * @brief Invalid argument. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_INVALID_ARGUMENT (SIGNDOC_DOCUMENT_RETURNCODE_INVALID_ARGUMENT)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NOT_SUPPORTED
 * @brief Operation not supported. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NOT_SUPPORTED (SIGNDOC_DOCUMENT_RETURNCODE_NOT_SUPPORTED)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NOT_VERIFIED
 * @brief SignDocDocument::verifySignature() has not been called. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NOT_VERIFIED (SIGNDOC_DOCUMENT_RETURNCODE_NOT_VERIFIED)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NO_BIOMETRIC_DATA
 * @brief No biometric data (or hash) available. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_NO_BIOMETRIC_DATA (SIGNDOC_DOCUMENT_RETURNCODE_NO_BIOMETRIC_DATA)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_RETURNCODE_UNEXPECTED_ERROR
 * @brief Unexpected error. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_RETURNCODE_UNEXPECTED_ERROR (SIGNDOC_DOCUMENT_RETURNCODE_UNEXPECTED_ERROR)
/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_UNMODIFIED
 * @brief No error, signature and document verified. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_UNMODIFIED (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_DOCUMENT_EXTENDED
 * @brief No error, signature and document verified, document modified by adding data to the signed document. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_DOCUMENT_EXTENDED (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_DOCUMENT_MODIFIED
 * @brief Document modified (possibly forged). 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_DOCUMENT_MODIFIED (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_UNSUPPORTED_SIGNATURE
 * @brief Unsupported signature method. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_UNSUPPORTED_SIGNATURE (4 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_INVALID_CERTIFICATE
 * @brief Invalid certificate. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_INVALID_CERTIFICATE (5 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_EMPTY
 * @brief Signature field without signature. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_SIGNATURESTATE_EMPTY (6 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_VALID
 * @brief No error, an RFC 3161 time stamp is present and valid (but you have to check the certificate chain and revocation). 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_VALID (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_MISSING
 * @brief There is no RFC 3161 time stamp. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_MISSING (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_INVALID
 * @brief An RFC 3161 time stamp is present but invalid. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_TIMESTAMPSTATE_INVALID (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_DONT_VERIFY
 * @brief Don't verify the certificate chain. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_DONT_VERIFY (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED
 * @brief Accept self-signed certificates. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_BIO
 * @brief Accept self-signed certificates if biometric data is present. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_BIO (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_RSA_BIO
 * @brief Accept self-signed certificates if asymmetrically encrypted biometric data is present. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_ACCEPT_SELF_SIGNED_WITH_RSA_BIO (4 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_REQUIRE_TRUSTED_ROOT
 * @brief Require a trusted root certificate. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINVERIFICATIONPOLICY_REQUIRE_TRUSTED_ROOT (5 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_DONT_CHECK
 * @brief Don't verify revocation of certificates. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_DONT_CHECK (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_OFFLINE
 * @brief Check revocation, assume that certificates are not revoked if the revocation server is offline. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_OFFLINE (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_ONLINE
 * @brief Check revocation, assume that certificates are revoked if the revocation server is offline. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONVERIFICATIONPOLICY_ONLINE (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_VERIFICATIONMODEL_WINDOWS
 * @brief Whatever the Windows Crypto API or OpenSSL implements. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_VERIFICATIONMODEL_WINDOWS (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_VERIFICATIONMODEL_GERMAN_SIG_LAW
 * @brief As specfified by German law. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_VERIFICATIONMODEL_GERMAN_SIG_LAW (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_OK
 * @brief Chain OK. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_OK (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_BROKEN_CHAIN
 * @brief Chain broken. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_BROKEN_CHAIN (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_UNTRUSTED_ROOT
 * @brief Untrusted root certificate. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_UNTRUSTED_ROOT (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_CRITICAL_EXTENSION
 * @brief A certificate has an unknown critical extension. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_CRITICAL_EXTENSION (4 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_NOT_TIME_VALID
 * @brief A certificate is not yet valid or is expired. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_NOT_TIME_VALID (5 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_PATH_LENGTH
 * @brief Path length constraint not satisfied. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_PATH_LENGTH (6 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_INVALID
 * @brief Invalid certificate or chain. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_INVALID (7 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_ERROR
 * @brief Other error. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATECHAINSTATE_ERROR (8 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_OK
 * @brief No certificate revoked. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_OK (1 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_NOT_CHECKED
 * @brief Revocation not checked. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_NOT_CHECKED (2 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_OFFLINE
 * @brief Revocation server is offline. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_OFFLINE (3 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_REVOKED
 * @brief At least one certificate has been revoked. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_REVOKED (4 - 1)

/**
 * @var const SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_ERROR
 * @brief Error. 
 * @memberof  SIGNDOC_VerificationResult
 */
#define SIGNDOC_VERIFICATIONRESULT_CERTIFICATEREVOCATIONSTATE_ERROR (5 - 1)

/**
 * @var const SIGNDOC_WATERMARK_JUSTIFICATION_LEFT
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_JUSTIFICATION_LEFT (1 - 1)

/**
 * @var const SIGNDOC_WATERMARK_JUSTIFICATION_CENTER
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_JUSTIFICATION_CENTER (2 - 1)

/**
 * @var const SIGNDOC_WATERMARK_JUSTIFICATION_RIGHT
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_JUSTIFICATION_RIGHT (3 - 1)

/**
 * @var const SIGNDOC_WATERMARK_LOCATION_OVERLAY
 * @brief Watermark appears on top of page. 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_LOCATION_OVERLAY (1 - 1)

/**
 * @var const SIGNDOC_WATERMARK_LOCATION_UNDERLAY
 * @brief Watermark appears behind page. 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_LOCATION_UNDERLAY (2 - 1)

/**
 * @var const SIGNDOC_WATERMARK_HALIGNMENT_LEFT
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_HALIGNMENT_LEFT (1 - 1)

/**
 * @var const SIGNDOC_WATERMARK_HALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_HALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_WATERMARK_HALIGNMENT_RIGHT
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_HALIGNMENT_RIGHT (3 - 1)

/**
 * @var const SIGNDOC_WATERMARK_VALIGNMENT_TOP
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_VALIGNMENT_TOP (1 - 1)

/**
 * @var const SIGNDOC_WATERMARK_VALIGNMENT_CENTER
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_VALIGNMENT_CENTER (2 - 1)

/**
 * @var const SIGNDOC_WATERMARK_VALIGNMENT_BOTTOM
 * @brief 
 * @memberof  SIGNDOC_Watermark
 */
#define SIGNDOC_WATERMARK_VALIGNMENT_BOTTOM (3 - 1)

/**
 * @var const SIGNDOC_ENCODING_NATIVE
 * @brief Windows "ANSI" for Windows, LC_CTYPE for Linux. 
 * @memberof  SIGNDOC
 */
#define SIGNDOC_ENCODING_NATIVE (1 - 1)

/**
 * @var const SIGNDOC_ENCODING_UTF_8
 * @brief UTF-8. 
 * @memberof  SIGNDOC
 */
#define SIGNDOC_ENCODING_UTF_8 (2 - 1)

/**
 * @var const SIGNDOC_ENCODING_LATIN_1
 * @brief ISO 8859-1. 
 * @memberof  SIGNDOC
 */
#define SIGNDOC_ENCODING_LATIN_1 (3 - 1)


/**
 * @brief String array
 * @class SIGNDOC_StringArray
 */
struct SIGNDOC_StringArray;

/**
 * @brief Byte array
 * @class SIGNDOC_ByteArray
 */
struct SIGNDOC_ByteArray;

/**
 * @brief Array of byte arrays
 * @class SIGNDOC_ByteArrayArray
 */
struct SIGNDOC_ByteArrayArray;

/**
 * @brief Array of fields
 * @class SIGNDOC_FieldArray
 */
struct SIGNDOC_FieldArray;

/**
 * @brief Text position
 * @class SIGNDOC_FindTextPosition
 */
struct SIGNDOC_FindTextPosition;

/**
 * @brief Array of text positions
 * @class SIGNDOC_FindTextPositionArray
 */
struct SIGNDOC_FindTextPositionArray;

/**
 * @brief Array of properties
 * @class SIGNDOC_PropertyArray
 */
struct SIGNDOC_PropertyArray;

/**
 * @brief Array of Unicode strings
 * @class SIGNDOC_UnicodeString
 */
struct SIGNDOC_UnicodeString;

/**
 * @brief Exception information
 * @class SIGNDOC_Exception
 */
struct SIGNDOC_Exception;

/**
 * @brief Exception handler
 * @memberof SIGNDOC_Exception
 */
typedef void (*SIGNDOC_ExceptionHandler) (struct SIGNDOC_Exception *ex);

/**
 * @class SIGNDOC_PdfDocumentHandler
 */
struct SIGNDOC_PdfDocumentHandler;

/**
 * @class SIGNDOC_TiffDocumentHandler
 */
struct SIGNDOC_TiffDocumentHandler;

/**
 * @class SIGNDOC_BufferInputStream
 * @brief Class implementing a buffered InputStream. 
 *
 */
struct SIGNDOC_BufferInputStream;

/**
 * @class SIGNDOC_BufferOutputStream
 * @brief Class implementing a buffered OutputStream. 
 *
 */
struct SIGNDOC_BufferOutputStream;

/**
 * @class SIGNDOC_FileOutputStream
 * @brief Class implementing an OutputStream writing to a file. 
 *
 * If possible, any IoError exception thrown by member functions of this class contain the pathname. Note that the pathname will be UTF-8 encoded. 
 */
struct SIGNDOC_FileOutputStream;

/**
 * @class SIGNDOC_FilterInputStream
 * @brief 
 *
 * A filtering input stream, inspired by Java's java.io.FilterInputStream, but see 
 * .
 */
struct SIGNDOC_FilterInputStream;

/**
 * @class SIGNDOC_InputStream
 * @brief Interface for an input stream, inspired by Java's java.io.InputStream. 
 *
 */
struct SIGNDOC_InputStream;

/**
 * @class SIGNDOC_MemoryInputStream
 * @brief Class implementing an InputStream reading from memory. 
 *
 */
struct SIGNDOC_MemoryInputStream;

/**
 * @class SIGNDOC_MemoryOutputStream
 * @brief Class implementing an OutputStream writing to memory. 
 *
 */
struct SIGNDOC_MemoryOutputStream;

/**
 * @class SIGNDOC_OutputStream
 * @brief Interface for an output stream, inspired by Java's java.io.OutputStream. 
 *
 */
struct SIGNDOC_OutputStream;

/**
 * @class SIGNDOC_Point
 * @brief A point (page coordinates or canvas coordinates). 
 *
 */
struct SIGNDOC_Point;

/**
 * @class SIGNDOC_Rect
 * @brief A rectangle (page coordinates). 
 *
 * If coordinates are given in pixels (this is true for TIFF documents), the right and top coordinates are exclusive. 
 */
struct SIGNDOC_Rect;

/**
 * @class SIGNDOC_Annotation
 * @brief An annotation. 
 *
 * Currently, annotations are supported for PDF documents only.
 */
struct SIGNDOC_Annotation;

/**
 * @class SIGNDOC_Attachment
 * @brief Output of SignDocDocument::getAttachment(). 
 *
 */
struct SIGNDOC_Attachment;

/**
 * @class SIGNDOC_CharacterPosition
 * @brief Position of a character. 
 *
 * This class uses document coordinates, see signdocshared_coordinates. 
 */
struct SIGNDOC_CharacterPosition;

/**
 * @class SIGNDOC_Color
 * @brief Base class for colors. 
 *
 */
struct SIGNDOC_Color;

/**
 * @class SIGNDOC_Document
 * @brief An interface for SignDoc documents. 
 *
 * An object of this class represents one document.
 * Use 
 *  or 
 *  to create objects.
 * If the document is loaded from a file, the file may remain in use until this object is destroyed or the document is saved to a different file with 
 * . Please do not change the file while there is a 
 *  object for it.
 */
struct SIGNDOC_Document;

/**
 * @class SIGNDOC_DocumentHandler
 * @brief Handler for one document type (internal interface). 
 *
 */
struct SIGNDOC_DocumentHandler;

/**
 * @class SIGNDOC_DocumentLoader
 * @brief Create SignDocDocument objects. 
 *
 * As the error message is stored in this object, each thread should have its own instance of 
 * .
 * To be able to load documents, you have to register at least one document handler. There are two ways for registering document handlers:
 */
struct SIGNDOC_DocumentLoader;

/**
 * @class SIGNDOC_Field
 * @brief One field of a document. 
 *
 * Calling member function of this class does not modify the document, use 
 *  to apply your changes to the document or 
 *  to add the field to the document.
 * In PDF documents, a field may have multiple visible "widgets". For instance, a radio button group (radio button field) usually has multiple visible buttons, ie, widgets.
 * A 
 *  object represents the logical field (containing the type, name, value, etc) as well as all its widgets. Each widget has a page number, a coordinate rectangle, and, for some field types, text field attributes.
 * Only one widget of the field is accessible at a time in a 
 *  object; use 
 *  to select the widget to be operated on.
 * For radio button fields and check box fields, each widget also has a "button value". The button value should remain constant after the document has been created (but it can be changed if needed). The field proper has a value which is either "Off" or one of the button values of its widgets.
 * Each widget of a radio button field or a check box field is either off or on. If all widgets of a radio button field or a check box are off, the field's value is "Off". If at least one widget is on, the field's value is that widget's "button value". As the value of a field must be different for the on and off states of the field, the button values must not be "Off".
 * Check box fields usually have exactly one widget. If that widget's button value is, say, "On", the field's value is either "Off" (for the off state) or "On" (for the on state).
 * Check box fields can have multiple widgets. If all widgets have the same button value, say, "yes", the field's value is either "Off" (for the off state) or "yes" (for the off state). Clicking one widget of the check box field will toggle all widgets of that check box field.
 * Check box fields can have multiple widgets having different button values. If a check box field has two widgets with button values, say, "1" and "2", the field's value is either "Off" (for the off state), "1" (if the first widget is on) or "2" (if the second widget is on). The two widgets cannot be on at the same time.
 * If a check box field has three widgets with button values, say, "one, "two", and "two", respectively, the field's value is either
 "Off" (for the off state), "one" (if the first widget is on) or
 "two" (if the second and third widgets are on). The second and third widgets will always have the same state and that state will never be the same as the state of the first widget.
 * A radio button field usually has at least two widgets, having different button values. If a radio button field has two widgets with button values, say, "a" and "b", the field's value is either "Off" (for the off state), "a" (if the first widget is on), or "b" (if the second widget is on). Clicking the first widget puts the first widget into the on state and the second one into the off state (and vice versa).
 * Different widgets of a radio button field can have the same button value. The behavior for clicking a widget with non-unique button value depends on the f_RadiosInUnison field flag. If that flag is set (it usually is), widgets having the same button value always have the same on/off state. Clicking one of them will turn all of them on. If the f_RadiosInUnison is not set, clicking one widget will put all others (of the same radio button field) into the off state. See 
 *  for details.
 * Signature fields have exactly one widget. Fields of other types must have at least one widget.
 * Other fields such as text fields (except for signature fields) also can have multiple widgets, but all of them display the same value. 
 */
struct SIGNDOC_Field;

/**
 * @class SIGNDOC_FindTextPosition
 * @brief Position of a hit returned by SignDocDocument::findText(). 
 *
 */
struct SIGNDOC_FindTextPosition;

/**
 * @class SIGNDOC_GrayColor
 * @brief Gray color. 
 *
 */
struct SIGNDOC_GrayColor;

/**
 * @class SIGNDOC_Property
 * @brief One property, without value. 
 *
 * Use 
 * , 
 * , or 
 *  to get the value of a property. 
 */
struct SIGNDOC_Property;

/**
 * @class SIGNDOC_RenderOutput
 * @brief Output of SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), and SignDocDocument::renderPageAsSpoocImages(). 
 *
 * If multiple pages are selected (see SignDocRenderParameters::setPages()), the maximum width and maximum height of all selected pages will be used. 
 */
struct SIGNDOC_RenderOutput;

/**
 * @class SIGNDOC_RenderParameters
 * @brief Parameters for SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), and SignDocDocument::renderPageAsSpoocImages(). 
 *
 */
struct SIGNDOC_RenderParameters;

/**
 * @class SIGNDOC_RGBColor
 * @brief RGB color. 
 *
 */
struct SIGNDOC_RGBColor;

/**
 * @class SIGNDOC_SignatureParameters
 * @brief Parameters for signing a document. 
 *
 * The available parameters depend both on the document type and on the signature field for which the 
 *  object has been created.
 *  may fail due to invalid parameters even if all setters reported success as the setters do not check if there are conflicts between parameters.
 * Which certificates are acceptable may be restricted by the application (by using csf_software and csf_hardware of integer parameter "SelectCertificate", blob parameters "FilterCertificatesByIssuerCertificate" and "FilterCertificatesBySubjectCertificate", and string parameters "FilterCertificatesByPolicy" and "FilterCertificatesBySubjectDN") and by the PDF document (certificate seed value dictionary, not yet implemented). If no matching certificate is available (for instance, because integer parameter "SelectCertificate" is zero), 
 *  will fail with rc_no_certificate. If more than one matching certificate is available but csf_never_ask is specified in integer parameter "SelectCertificate"), 
 *  will fail with rc_ambiguous_certificate.
 * The interaction between some parameters is quite complex; the following section tries to summarize the signing methods for PDF documents. 
 * Additionally:
 * 
For TIFF documents, an additional, simplified signing method is available: 
 */
struct SIGNDOC_SignatureParameters;

/**
 * @class SIGNDOC_TextFieldAttributes
 * @brief Attributes of a text field used for the construction of the appearance (PDF documents only). 
 *
 * This class represents a PDF default appearance string.
 * Modifying an object of this type does not modify the underlying field or document. Use 
 *  or 
 *  to update the text attributes of a field or of the document.
 */
struct SIGNDOC_TextFieldAttributes;

/**
 * @class SIGNDOC_VerificationResult
 * @brief Information about a signature field returned by SignDocDocument::verifySignature(). 
 *
 */
struct SIGNDOC_VerificationResult;

/**
 * @class SIGNDOC_Watermark
 * @brief Parameters for a watermark. 
 *
 */
struct SIGNDOC_Watermark;

struct SIGNDOC_Image;
struct SIGNDOC_Images;
struct SIGNDOC_FontCache;
struct SignPKCS7;

/**
 * @brief Release memory block
 * @param ptr pointer to memory block
 */
void SDCAPI SIGNDOC_delete(void *ptr);

/**
 * @brief Creates a new string array
 * @returns string array object
 * @memberof SIGNDOC_StringArray
 */
struct SIGNDOC_StringArray * SDCAPI SIGNDOC_StringArray_new();

/**
 * @brief Destroys a string array
 * @param aArray string array object
 * @memberof SIGNDOC_StringArray
 */
void SDCAPI SIGNDOC_StringArray_delete(struct SIGNDOC_StringArray *aArray);

/**
 * @brief Returns the number of elements in a string array
 * @param aArray string array
 * @returns number of elements in the string array
 * @memberof SIGNDOC_StringArray
 */
unsigned int SDCAPI SIGNDOC_StringArray_count(struct SIGNDOC_StringArray *aArray);

/**
 * @brief Returns a particular string from a string array
 * @param aArray string array
 * @param aIdx index
 * @returns string at position aIdx
 * @memberof SIGNDOC_StringArray
 */
const char * SDCAPI SIGNDOC_StringArray_at(struct SIGNDOC_StringArray *aArray, unsigned int aIdx);

/**
 * @brief Creates a new field array
 * @returns field array object
 * @memberof SIGNDOC_FieldArray
 */
struct SIGNDOC_FieldArray * SDCAPI SIGNDOC_FieldArray_new();

/**
 * @brief Destroys a field array
 * @param aArray field array object
 * @memberof SIGNDOC_FieldArray
 */
void SDCAPI SIGNDOC_FieldArray_delete(struct SIGNDOC_FieldArray *aArray);

/**
 * @brief Returns the number of elements in a field array
 * @param aArray field array
 * @returns number of elements in the field array
 * @memberof SIGNDOC_FieldArray
 */
unsigned int SDCAPI SIGNDOC_FieldArray_count(struct SIGNDOC_FieldArray *aArray);

/**
 * @brief Returns a particular field from an array
 * @param aArray field array
 * @param aIdx index
 * @returns field at position aIdx
 * @memberof SIGNDOC_FieldArray
 */
struct SIGNDOC_Field * SDCAPI SIGNDOC_FieldArray_at(struct SIGNDOC_FieldArray *aArray, unsigned int aIdx);

/**
 * @brief Creates a new FindTextPosition array
 * @returns field array object
 * @memberof SIGNDOC_FindTextPositionArray
 */
struct SIGNDOC_FindTextPositionArray * SDCAPI SIGNDOC_FindTextPositionArray_new();

/**
 * @brief Destroys a FindTextPosition array
 * @param aArray FindTextPosition array object
 * @memberof SIGNDOC_FindTextPositionArray
 */
void SDCAPI SIGNDOC_FindTextPositionArray_delete(struct SIGNDOC_FindTextPositionArray *aArray);

/**
 * @brief Returns the number of elements in an array
 * @param aArray FindTextPosition array
 * @returns number of elements in the FindTextPosition array
 * @memberof SIGNDOC_FindTextPositionArray
 */
unsigned int SDCAPI SIGNDOC_FindTextPositionArray_count(struct SIGNDOC_FindTextPositionArray *aArray);

/**
 * @brief Returns a particular FindTextPosition from an array
 * @param aArray FindTextPosition array
 * @param aIdx index
 * @returns string at position aIdx
 * @memberof SIGNDOC_FindTextPositionArray
 */
struct SIGNDOC_FindTextPosition * SDCAPI SIGNDOC_FindTextPositionArray_at(struct SIGNDOC_FindTextPositionArray *aArray, unsigned int aIdx);

/**
 * @brief Creates a new byte array
 * @returns new byte array object
 * @memberof SIGNDOC_ByteArray
 */
struct SIGNDOC_ByteArray * SDCAPI SIGNDOC_ByteArray_new();

/**
 * @brief Destroys a byte array
 * @param aArray byte array
 * @memberof SIGNDOC_ByteArray
 */
void SDCAPI SIGNDOC_ByteArray_delete(struct SIGNDOC_ByteArray *aArray);

/**
 * @brief Returns the number of elements in a byte array
 * @param aArray
 * @returns number of bytes
 * @memberof SIGNDOC_ByteArray
 */
unsigned int SDCAPI SIGNDOC_ByteArray_count(struct SIGNDOC_ByteArray *aArray);

/**
 * @brief Returns a particular byte of a byte array
 * @param aArray byte array
 * @param aIdx position
 * @returns byte an position aIdx
 * @memberof SIGNDOC_ByteArray
 */ 
unsigned char SDCAPI SIGNDOC_ByteArray_at(struct SIGNDOC_ByteArray *aArray, unsigned int aIdx);

/**
 * @brief Returns a pointer to the data in a byte array
 * @param aArray byte array
 * @return pointer to the data
 * @memberof SIGNDOC_ByteArray
 */
unsigned char * SDCAPI SIGNDOC_ByteArray_data(struct SIGNDOC_ByteArray *aArray);

/**
 * @brief Creates a new array of byte arrays
 * @returns new array of byte arrays
 * @memberof SIGNDOC_ByteArrayArray
 */
struct SIGNDOC_ByteArrayArray * SDCAPI SIGNDOC_ByteArrayArray_new();

/**
 * @brief Deletes an array of byte arrays
 * @param aArray array
 * @memberof SIGNDOC_ByteArrayArray
 */
void SDCAPI SIGNDOC_ByteArrayArray_delete(struct SIGNDOC_ByteArrayArray *aArray);

/**
 * @brief Returns the number of byte arrays
 * @param aArray
 * @returns number of contained elements
 * @memberof SIGNDOC_ByteArrayArray
 */
unsigned int SDCAPI SIGNDOC_ByteArrayArray_count(struct SIGNDOC_ByteArrayArray *aArray);

/**
 * @brief Returns a particular byte array from the array
 * @param aArray array of byte arrays
 * @param aIdx position
 * @returns byte array at position aIdx
 * @memberof SIGNDOC_ByteArrayArray
 */
struct SIGNDOC_ByteArray * SDCAPI SIGNDOC_ByteArrayArray_at(struct SIGNDOC_ByteArrayArray *aArray, unsigned int aIdx);

/**
 * @brief Creates a new exception object
 * @returns new exception
 * @memberof SIGNDOC_Exception
 */
struct SIGNDOC_Exception * SDCAPI SIGNDOC_Exception_new();

/**
 * @brief Frees the memory associated with an exception after handling is done
 * @param ex exception, may be NULL
 * @memberof SIGNDOC_Exception
 */
void SDCAPI SIGNDOC_Exception_dispose(struct SIGNDOC_Exception *ex);

/**
 * @brief Deletes an exception object
 * @param ex exception object, may be NULL
 * @memberof SIGNDOC_Exception
 */
void SDCAPI SIGNDOC_Exception_delete(struct SIGNDOC_Exception *ex);

/**
 * @brief Returns the detailing text of an SIGNDOC_Exception
 * @param ex exception, may be NULL
 * @return exception text, to be freed by the exception handler
 * @see SIGNDOC_delete
 * @see SIGNDOC_Exception_dispose
 * @memberof SIGNDOC_Exception
 */
char * SDCAPI SIGNDOC_Exception_get_text(struct SIGNDOC_Exception *ex);

/**
 * @brief Returns the type of the exception
 * @param ex exception, may be NULL
 * @return exception type code
 * @memberof SIGNDOC_Exception
 */
unsigned int SDCAPI SIGNDOC_Exception_get_type(struct SIGNDOC_Exception *ex);

/**
 * @brief Sets an exception handler that is called when an exception for with this object occurs
 * @param ex exception object, may be NULL
 * @param handler handler function
 * @param closure user specified pointer
 * @memberof SIGNDOC_Exception
 */
void SDCAPI SIGNDOC_Exception_set_handler(struct SIGNDOC_Exception *ex, SIGNDOC_ExceptionHandler handler, void *closure);

		
/**
 * @brief Constructor. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The stream from which data is to be read. 
 * @param[in] aBuffer Pointer to a buffer provided by the caller or NULL to let the constructor allocate the buffer. 
 * @param[in] aBufferSize The size of the buffer, must be at least one. 

 */
struct SIGNDOC_BufferInputStream * SDCAPI SIGNDOC_BufferInputStream_new(struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aSource, void * aBuffer, size_t aBufferSize);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_BufferInputStream_delete(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position within the file. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferInputStream_seek(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_BufferInputStream_tell(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Read octets from the file. 
 * @details May throw Exception. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_BufferInputStream_read(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex, void * aDst, int aLen);

/**
 * @brief Close the stream. 
 * @details Does not close the stream passed to the constructor. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferInputStream_close(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get an estimate of the number of octets available for reading. 
 * @memberof SIGNDOC_BufferInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return Does not return. 

 */
int  SDCAPI SIGNDOC_BufferInputStream_avail(struct SIGNDOC_BufferInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSink The stream to which data is to be written. 
 * @param[in] aBuffer Pointer to a buffer provided by the caller or NULL to let the constructor allocate the buffer. 
 * @param[in] aBufferSize The size of the buffer, must be at least one. 

 */
struct SIGNDOC_BufferOutputStream * SDCAPI SIGNDOC_BufferOutputStream_new(struct SIGNDOC_Exception *ex, struct SIGNDOC_OutputStream * aSink, void * aBuffer, size_t aBufferSize);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_BufferOutputStream_delete(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Close the stream. 
 * @details Does not close the stream passed to the constructor. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferOutputStream_close(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Flush the stream. 
 * @details This function forces any buffered data to be written.
Throws an exception on error. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferOutputStream_flush(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position within the file. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferOutputStream_seek(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_BufferOutputStream_tell(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Write octets to this stream, using the buffer. 
 * @details May throw Exception. 
 * @memberof SIGNDOC_BufferOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_BufferOutputStream_write(struct SIGNDOC_BufferOutputStream *aObj, struct SIGNDOC_Exception *ex, const void * aSrc, int aLen);

/**
 * @brief Constructor: Write to a C stream. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFile The C stream to be wrapped. 

 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_FileOutputStream_new(struct SIGNDOC_Exception *ex, FILE * aFile);

/**
 * @brief Constructor: Write to a C stream. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFile The C stream to be wrapped. 
 * @param[in] aPath The pathname (native encoding), used in exceptions, can be NULL. 

 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_FileOutputStream_new2(struct SIGNDOC_Exception *ex, FILE * aFile, const char * aPath);

/**
 * @brief Constructor: Open a file in binary mode. 
 * @details If the named file already exists, it will be truncated.
May throw Exception.
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The name of the file to be opened (native encoding). 

 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_FileOutputStream_new_from_fn(struct SIGNDOC_Exception *ex, const char * aPath);

/**
 * @brief Constructor: Open a file in binary mode. 
 * @details If the named file already exists, it will be truncated.
May throw Exception.
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The name of the file to be opened. 

 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_FileOutputStream_new_from_fn_w(struct SIGNDOC_Exception *ex, const wchar_t * aPath);

/**
 * @brief Constructor: Open a file in binary mode. 
 * @details If the named file already exists, it will be truncated.
May throw Exception.
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The name of the file to be opened. 

 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_FileOutputStream_new_from_fn_us(struct SIGNDOC_Exception *ex, const struct SIGNDOC_UnicodeString * aPath);

/**
 * @brief Destructor. 
 * @details Does not close the C stream passed to the constructor taking a C stream. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_FileOutputStream_delete(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position within the file (int). 
 * @details Throws InvalidArgument if the position is invalid. Throws NotImplemented if seeking is not supported by the underlying stream. Throws IOError if seeking failed for other reasons.
Note that it's possible to seek exactly to the end of the file.
seek64()
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FileOutputStream_seek(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position as int. 
 * @details Throws NotImplemented if seeking is not supported by the underlying stream. Throws IOError if getting the position failed for other reasons. Throws Overflow if the position cannot be represented as non-negative int.
tell64()
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_FileOutputStream_tell(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Write octets to the file. 
 * @details May throw Exception. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FileOutputStream_write(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex, const void * aSrc, int aLen);

/**
 * @brief Close the stream. 
 * @details Does not close the C stream passed to the constructor taking a C stream. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FileOutputStream_close(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Flush the stream. 
 * @memberof SIGNDOC_FileOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FileOutputStream_flush(struct SIGNDOC_FileOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_FilterInputStream_delete(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Read octets from source. 
 * @details Unless reimplemented, this function forwards the request to the source stream. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_FilterInputStream_read(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex, void * aDst, int aLen);

/**
 * @brief Close the stream. 
 * @details Unlike java.io.FilterInputStream.close(), this function does not call close() on the source stream. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FilterInputStream_close(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position. 
 * @details Unless reimplemented, this function forwards the request to the source stream. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_FilterInputStream_seek(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position. 
 * @details Unless reimplemented, this function forwards the request to the source stream. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_FilterInputStream_tell(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the source stream. 
 * @memberof SIGNDOC_FilterInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_InputStream *  SDCAPI SIGNDOC_FilterInputStream_getSource(struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_FilterInputStream
 */
struct SIGNDOC_BufferInputStream * SDCAPI SIGNDOC_FilterInputStream_to_SIGNDOC_BufferInputStream(const struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_FilterInputStream
 */
struct SIGNDOC_FilterInputStream * SDCAPI SIGNDOC_BufferInputStream_to_SIGNDOC_FilterInputStream(const struct SIGNDOC_FilterInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_InputStream_delete(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Read octets from source. 
 * @details Implementations of this class may define exceptions thrown.
Once this function has returned a value smaller than aLen, end of input has been reached and further calls should return 0.
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aDst Pointer to buffer to be filled. 
 * @param[in] aLen Number of octets to read.
 * @return The number of octets read. 

 */
int  SDCAPI SIGNDOC_InputStream_read(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex, void * aDst, int aLen);

/**
 * @brief Close the stream. 
 * @details Implementations of this class may define exceptions thrown. 
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_InputStream_close(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position (int). 
 * @details Throws InvalidArgument if the position is invalid. Throws NotImplemented if seeking is not supported. Implementations of this class may add more exceptions.
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPos The position (zero being the first octet).

 */
void  SDCAPI SIGNDOC_InputStream_seek(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position (int). 
 * @details Throws NotImplemented if seeking is not supported. Throws Overflow if the position cannot be represented as non-negative int. Implementations of this class may add more exceptions.
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The current position (zero being the first octet)

 */
int  SDCAPI SIGNDOC_InputStream_tell(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get an estimate of the number of octets available for reading. 
 * @details Throws NotImplemented if this function is not supported. Implementations of this class may add more exceptions.
 * @memberof SIGNDOC_InputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The minimum number of octets available for reading. 

 */
int  SDCAPI SIGNDOC_InputStream_avail(struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_InputStream
 */
struct SIGNDOC_FilterInputStream * SDCAPI SIGNDOC_InputStream_to_SIGNDOC_FilterInputStream(const struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_InputStream
 */
struct SIGNDOC_InputStream * SDCAPI SIGNDOC_FilterInputStream_to_SIGNDOC_InputStream(const struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_InputStream
 */
struct SIGNDOC_MemoryInputStream * SDCAPI SIGNDOC_InputStream_to_SIGNDOC_MemoryInputStream(const struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_InputStream
 */
struct SIGNDOC_InputStream * SDCAPI SIGNDOC_MemoryInputStream_to_SIGNDOC_InputStream(const struct SIGNDOC_InputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @details Read from the buffer pointed to by aSrc. Note that the buffer contents won't be copied, therefore the buffer must remain valid throughout the use of this object.
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSrc Points to the stream contents. 
 * @param[in] aLen Size of the stream contents. 

 */
struct SIGNDOC_MemoryInputStream * SDCAPI SIGNDOC_MemoryInputStream_new(struct SIGNDOC_Exception *ex, const unsigned char * aSrc, size_t aLen);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_MemoryInputStream_delete(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position within the buffer. 
 * @details Throws InvalidArgument if the position is invalid.
Note that it's possible to seek exactly to the end of the buffer. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryInputStream_seek(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_MemoryInputStream_tell(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Read octets from source. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_MemoryInputStream_read(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex, void * aDst, int aLen);

/**
 * @brief Close the stream. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryInputStream_close(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the number of octets available for reading. 
 * @memberof SIGNDOC_MemoryInputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The number of octets available for reading. 

 */
int  SDCAPI SIGNDOC_MemoryInputStream_avail(struct SIGNDOC_MemoryInputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_MemoryOutputStream * SDCAPI SIGNDOC_MemoryOutputStream_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_MemoryOutputStream_delete(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Write octets to sink. 
 * @details Throws std::bad_alloc or InvalidArgument or Overflow (memory buffer size would exceed INT_MAX) on error. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryOutputStream_write(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex, const void * aSrc, int aLen);

/**
 * @brief Close the stream. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryOutputStream_close(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Flush the stream. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryOutputStream_flush(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position within the buffer. 
 * @details Throws InvalidArgument if the position is invalid.
Note that it's possible to seek exactly to the end of the buffer. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryOutputStream_seek(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief 
 * @details Retrieve the current position. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_MemoryOutputStream_tell(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Retrieve a pointer to the stream contents. 
 * @details Note that the returned pointer is only valid up to the next output to the stream.
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return Pointer to the first octet of the stream contents. 

 */
const unsigned char *  SDCAPI SIGNDOC_MemoryOutputStream_data(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Retrieve the length of the stream contents. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return Number of octets. 

 */
size_t  SDCAPI SIGNDOC_MemoryOutputStream_length(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Clear the buffered data. 
 * @details The buffer will be empty and the current position will be zero.
The buffer may or may not be deallocated. 
 * @memberof SIGNDOC_MemoryOutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_MemoryOutputStream_clear(struct SIGNDOC_MemoryOutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @details The destructor closes the stream by calling close(), which may throw an exception on error. 
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_OutputStream_delete(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Close the stream. 
 * @details This function forces any buffered data to be written and closes the stream.
You should not write to the stream after calling this function.
Throws an exception on error. 
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_OutputStream_close(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Flush the stream. This function forces any buffered data to be written. 
 * @details Throws an exception on error. 
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_OutputStream_flush(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Seek to the specified position. 
 * @details Throws InvalidArgument if the position is invalid. Throws NotImplemented if seeking is not supported.
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPos The position (the first octet is at position zero).

 */
void  SDCAPI SIGNDOC_OutputStream_seek(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex, int aPos);

/**
 * @brief Retrieve the current position. 
 * @details Throws NotImplemented if seeking is not supported. Throws Overflow if the position cannot be represented as non-negative int. Implementations of this class may add more exceptions.
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The current position (the first octet is at position zero)

 */
int  SDCAPI SIGNDOC_OutputStream_tell(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Write octets to the stream. 
 * @details Throws an exception on error.
 * @memberof SIGNDOC_OutputStream
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSrc Pointer to buffer to be written. 
 * @param[in] aLen Number of octets to write. 

 */
void  SDCAPI SIGNDOC_OutputStream_write(struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex, const void * aSrc, int aLen);
/**
 * @memberof SIGNDOC_OutputStream
 */
struct SIGNDOC_FileOutputStream * SDCAPI SIGNDOC_OutputStream_to_SIGNDOC_FileOutputStream(const struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_OutputStream
 */
struct SIGNDOC_OutputStream * SDCAPI SIGNDOC_FileOutputStream_to_SIGNDOC_OutputStream(const struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_OutputStream
 */
struct SIGNDOC_MemoryOutputStream * SDCAPI SIGNDOC_OutputStream_to_SIGNDOC_MemoryOutputStream(const struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_OutputStream
 */
struct SIGNDOC_OutputStream * SDCAPI SIGNDOC_MemoryOutputStream_to_SIGNDOC_OutputStream(const struct SIGNDOC_OutputStream *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @details All coordinates will be 0. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Point * SDCAPI SIGNDOC_Point_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX The X coordinate. 
 * @param[in] aY The Y coordinate. 

 */
struct SIGNDOC_Point * SDCAPI SIGNDOC_Point_new_from_coords(struct SIGNDOC_Exception *ex, double aX, double aY);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSrc The object to be copied. 

 */
struct SIGNDOC_Point * SDCAPI SIGNDOC_Point_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Point * aSrc);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Point_delete(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRHS The value to be assigned.
 * @return A reference to this object. 

 */
void SDCAPI SIGNDOC_Point_set(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Point * aRHS);

/**
 * @brief Set the coordinates of the point. 
 * @memberof SIGNDOC_Point
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX The X coordinate. 
 * @param[in] aY The Y coordinate. 

 */
void  SDCAPI SIGNDOC_Point_set_double(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex, double aX, double aY);
/**
 * @memberof SIGNDOC_Point
 */
double SDCAPI SIGNDOC_Point_getX(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Point
 */
void SDCAPI SIGNDOC_Point_setX(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex, double aX);
/**
 * @memberof SIGNDOC_Point
 */
double SDCAPI SIGNDOC_Point_getY(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Point
 */
void SDCAPI SIGNDOC_Point_setY(struct SIGNDOC_Point *aObj, struct SIGNDOC_Exception *ex, double aY);

/**
 * @brief Constructor. 
 * @details All coordinates will be 0. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Rect * SDCAPI SIGNDOC_Rect_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX1 The first X coordinate. 
 * @param[in] aY1 The first Y coordinate. 
 * @param[in] aX2 The second X coordinate. 
 * @param[in] aY2 The second Y coordinate. 

 */
struct SIGNDOC_Rect * SDCAPI SIGNDOC_Rect_new_from_coords(struct SIGNDOC_Exception *ex, double aX1, double aY1, double aX2, double aY2);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSrc The object to be copied. 

 */
struct SIGNDOC_Rect * SDCAPI SIGNDOC_Rect_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Rect * aSrc);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Rect_delete(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the coordinates of the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aX1 The first X coordinate. 
 * @param[out] aY1 The first Y coordinate. 
 * @param[out] aX2 The second X coordinate. 
 * @param[out] aY2 The second Y coordinate. 

 */
void  SDCAPI SIGNDOC_Rect_get(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double * aX1, double * aY1, double * aX2, double * aY2);

/**
 * @brief Set the coordinates of the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX1 The first X coordinate. 
 * @param[in] aY1 The first Y coordinate. 
 * @param[in] aX2 The second X coordinate. 
 * @param[in] aY2 The second Y coordinate. 

 */
void  SDCAPI SIGNDOC_Rect_set_double(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aX1, double aY1, double aX2, double aY2);

/**
 * @brief Get the width of the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The width of the rectangle. 

 */
double  SDCAPI SIGNDOC_Rect_getWidth(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the height of the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The height of the rectangle. 

 */
double  SDCAPI SIGNDOC_Rect_getHeight(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Normalizes the rectangle. 
 * @details Normalizes the rectangle to the one with lower-left and upper-right corners assuming that the origin is in the lower-left corner of the page. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Rect_normalize(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Scale the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFactor The factor by which the rectangle is to be scaled. 

 */
void  SDCAPI SIGNDOC_Rect_scale(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aFactor);

/**
 * @brief Scale the rectangle. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFactorX The factor by which the rectangle is to be scaled horizontally. 
 * @param[in] aFactorY The factor by which the rectangle is to be scaled vertically. 

 */
void  SDCAPI SIGNDOC_Rect_scale_xy(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aFactorX, double aFactorY);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Rect
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRHS The value to be assigned.
 * @return A reference to this object. 

 */
void SDCAPI SIGNDOC_Rect_set(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Rect * aRHS);
/**
 * @memberof SIGNDOC_Rect
 */
double SDCAPI SIGNDOC_Rect_getX1(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Rect
 */
void SDCAPI SIGNDOC_Rect_setX1(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aX1);
/**
 * @memberof SIGNDOC_Rect
 */
double SDCAPI SIGNDOC_Rect_getY1(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Rect
 */
void SDCAPI SIGNDOC_Rect_setY1(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aY1);
/**
 * @memberof SIGNDOC_Rect
 */
double SDCAPI SIGNDOC_Rect_getX2(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Rect
 */
void SDCAPI SIGNDOC_Rect_setX2(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aX2);
/**
 * @memberof SIGNDOC_Rect
 */
double SDCAPI SIGNDOC_Rect_getY2(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Rect
 */
void SDCAPI SIGNDOC_Rect_setY2(struct SIGNDOC_Rect *aObj, struct SIGNDOC_Exception *ex, double aY2);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Annotation_delete(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the type of the annotation. 
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Annotation_getType(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the name of the annotation. 
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The name of the annotation or an empty string if the name is not available. 

 */
char *  SDCAPI SIGNDOC_Annotation_getName(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the page number of the annotation. 
 * @details The page number is available for objects returned by SignDocDocument::getAnnotation() only.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return the 1-based page number of the annotation or 0 if the page number is not available. 

 */
int  SDCAPI SIGNDOC_Annotation_getPage(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the bounding box of the annotation. 
 * @details The bounding box is available for objects returned by getAnnotation() only.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The bounding box (using document coordinates, see signdocshared_coordinates) will be stored here.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_getBoundingBox(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Rect * aOutput);

/**
 * @brief Set the name of the annotation. 
 * @details In PDF documents, an annotation can have a name. The names of annotations must be unique within a page. By default, annotations are unnamed.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the annotation.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setName_cset(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Set the name of the annotation. 
 * @details In PDF documents, an annotation can have a name. The names of annotations must be unique within a page. By default, annotations are unnamed.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the annotation.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setName(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aName);

/**
 * @brief Set line ending styles. 
 * @details This function can be used for annotations of type t_line. The default line ending style is le_none.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStart Line ending style for start point. 
 * @param[in] aEnd Line ending style for end point.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setLineEnding(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aStart, int aEnd);

/**
 * @brief Set the foreground color of the annotation. 
 * @details This function can be used for annotations of types t_line, t_scribble, and t_freetext.
The default foreground color is black.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aColor The foreground color of the annotation.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setColor(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Color * aColor);

/**
 * @brief Set the background color of the annotation. 
 * @details This function can be used for annotations of type t_freetext.
The default background color is white.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aColor The background color of the annotation.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setBackgroundColor(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Color * aColor);

/**
 * @brief Set the border color of the annotation. 
 * @details This function can be used for annotations of type t_freetext.
The default border color is black.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aColor The border color of the annotation.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_setBorderColor(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Color * aColor);

/**
 * @brief Set the opacity of the annotation. 
 * @details This function can be used for annotations of types t_line, t_scribble, and t_freetext.
The default opacity is 1.0. Documents conforming to PDF/A must use an opacity of 1.0.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOpacity The opacity, 0.0 (transparent) through 1.0 (opaque).
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setOpacity(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, double aOpacity);

/**
 * @brief Set line width in points. 
 * @details This function can be used for annotations of types t_line and t_scribble. The default line width for PDF documents is 1 point.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aWidth The line width in points (1/72 inch).
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Annotation_setLineWidthInPoints(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, double aWidth);

/**
 * @brief Set border line width in points. 
 * @details This function can be used for annotations of type t_freetext. The default border line width for PDF documents is 1 point.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aWidth The border line width in points (1/72 inch). If this value is negative, no border lines will be drawn.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_setBorderLineWidthInPoints(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, double aWidth);

/**
 * @brief Start a new stroke in a scribble annotation. 
 * @details This function can be used for annotations of type t_scribble. Each stroke must contain at least two points. This function need not be called for the first stroke of a scribble annotation.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_newStroke(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a point to the current stroke of a scribble annotation. 
 * @details This function can be used for annotations of type t_scribble. Each stroke must contain at least two points. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPoint The point to be added.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_addPoint(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Point * aPoint);

/**
 * @brief Add a point to the current stroke of a scribble annotation. 
 * @details This function can be used for annotations of type t_scribble. Each stroke must contain at least two points. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX The X coordinate of the point. 
 * @param[in] aY The Y coordinate of the point.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_addPoint_double(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, double aX, double aY);

/**
 * @brief Set the text of a text annotation. 
 * @details This function can be used for annotations of type t_freetext.
Any sequence of CR and LF characters in the text starts a new paragraph (ie, text following such a sequence will be placed at the beginning of the next output line). In consequence, empty lines in the input do not produce empty lines in the output. To get an empty line in the output, you have to add a paragraph containing a non-breaking space (0xa0) only: "Linebeforeemptyline\n\xa0\nLineafteremptyline"
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aText and aFont. 
 * @param[in] aText The text. Allowed control characters are CR and LF. Any sequence of CR and LF characters starts a new paragraph. 
 * @param[in] aFont The name of the font to be used. The font substitition rules of the loaded font configuration files will be used. The resulting font must be a standard PDF font or a font for which a file is specified in the font configuration files. 
 * @param[in] aFontSize The font size in user space units. 
 * @param[in] aHAlignment Horizontal alignment of the text.

 */
int  SDCAPI SIGNDOC_Annotation_setPlainText(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aText, const char * aFont, double aFontSize, int aHAlignment);

/**
 * @brief Get the text of a text annotation. 
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the text returned in aText.
 * @param[out] aText The text will be stored here. The start of a new paragraph (except for the first one) is represented by CR and/or LF characters.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_getPlainText(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aEncoding, char ** aText);

/**
 * @brief Get the font of a text annotation. 
 * @memberof SIGNDOC_Annotation
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the font name returned in aFont.
 * @param[out] aFont The font name will be stored here. 
 * @param[out] aFontSize The font size in user space units will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Annotation_getFont(struct SIGNDOC_Annotation *aObj, struct SIGNDOC_Exception *ex, int aEncoding, char ** aFont, double * aFontSize);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Attachment * SDCAPI SIGNDOC_Attachment_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_Attachment * SDCAPI SIGNDOC_Attachment_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Attachment * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Attachment_delete(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_Attachment_set(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Attachment * aSource);

/**
 * @brief Efficiently swap this object with another one. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The other object. 

 */
void  SDCAPI SIGNDOC_Attachment_swap(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Attachment * aOther);

/**
 * @brief Get the name of the attachment. 
 * @details This function throws de::softpro::spooc::EncodingError if the name cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The name of the attachment.

 */
char *  SDCAPI SIGNDOC_Attachment_getName(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the name of the attachment as UTF-8-encoded C string. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The name of the attachment. This pointer will become invalid when this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Attachment_getNameUTF8(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the file name of the attachment. 
 * @details This function throws de::softpro::spooc::EncodingError if the file name cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The file name of the attachment.

 */
char *  SDCAPI SIGNDOC_Attachment_getFileName(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the file name of the attachment as UTF-8-encoded C string. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The file name of the attachment. This pointer will become invalid when this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Attachment_getFileNameUTF8(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the description of the attachment. 
 * @details The returned string will be empty if the description is missing.
This function throws de::softpro::spooc::EncodingError if the description cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The description of the attachment.

 */
char *  SDCAPI SIGNDOC_Attachment_getDescription(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the description of the attachment as UTF-8-encoded C string. 
 * @details The returned string will be empty if the description is missing.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The description of the attachment. This pointer will become invalid when this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Attachment_getDescriptionUTF8(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the size (in octets) of the attachment. 
 * @details The return value is -1 if the size of the attachment is not readily available.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The size (in octets) of the attachment or -1.

 */
int  SDCAPI SIGNDOC_Attachment_getSize(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the compressed size (in octets) of the attachment. 
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The compressed size (in octets) of the attachment.

 */
int  SDCAPI SIGNDOC_Attachment_getCompressedSize(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the MIME type of the attachment. 
 * @details The return string will be empty if the MIME type is missing.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The MIME type of the attachment. This pointer will become invalid when this object is destroyed. 

 */
const char *  SDCAPI SIGNDOC_Attachment_getType(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the creation time and date of the attachment. 
 * @details The returned string will be empty if the creation time and date are missing.
ISO 8601 format is used: yyyy-mm-ddThh:mm:ss, optionally followed by a timezone: Z, +hh:mm, or -hh:mm.
The PDF reference is ambiguous; apparently, the creation time is supposed to be the time and date at which the attachment was the PDF document. Changing the description does not update the modification date/time.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The creation time and date of the attachment. This pointer will become invalid when this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Attachment_getCreationTime(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the time and date of the last modification of the attachment. 
 * @details Setting the time and date of the last modification of the attachment is optional. The returned string will be empty if the modification time and date are missing.
ISO 8601 format is used: yyyy-mm-ddThh:mm:ss, optionally followed by a timezone: Z, +hh:mm, or -hh:mm.
The PDF reference is ambiguous; apparently, the modifiation time is supposed to be the time and date of the last modification of the file at the time it was attached. Changing the description does not update the modification date/time.
 * @memberof SIGNDOC_Attachment
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The time and date of the last modification of the attachment. This pointer will become invalid when this object is destroyed. 

 */
const char *  SDCAPI SIGNDOC_Attachment_getModificationTime(struct SIGNDOC_Attachment *aObj, struct SIGNDOC_Exception *ex);
/**
 * @brief Default constructor
 * @param ex exception information, may be NULL
 * @return newly constructed object
 * @memberof SIGNDOC_CharacterPosition
 */
struct SIGNDOC_CharacterPosition * SDCAPI SIGNDOC_CharacterPosition_new(struct SIGNDOC_Exception *ex);
/**
 * @brief Default destructor
 * @param aObj object to be destroyed
 * @param ex exception information, may be NULL
 * @memberof SIGNDOC_CharacterPosition
 */
void SDCAPI SIGNDOC_CharacterPosition_delete(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
int SDCAPI SIGNDOC_CharacterPosition_getPage(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
void SDCAPI SIGNDOC_CharacterPosition_setPage(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex, int aPage);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
struct SIGNDOC_Point * SDCAPI SIGNDOC_CharacterPosition_getRef(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
void SDCAPI SIGNDOC_CharacterPosition_setRef(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Point * aRef);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
struct SIGNDOC_Rect * SDCAPI SIGNDOC_CharacterPosition_getBox(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_CharacterPosition
 */
void SDCAPI SIGNDOC_CharacterPosition_setBox(struct SIGNDOC_CharacterPosition *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Rect * aBox);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Color
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Color_delete(struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Create a copy of this object. 
 * @memberof SIGNDOC_Color
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Color *  SDCAPI SIGNDOC_Color_clone(struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Color
 */
struct SIGNDOC_GrayColor * SDCAPI SIGNDOC_Color_to_SIGNDOC_GrayColor(const struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Color
 */
struct SIGNDOC_Color * SDCAPI SIGNDOC_GrayColor_to_SIGNDOC_Color(const struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Color
 */
struct SIGNDOC_RGBColor * SDCAPI SIGNDOC_Color_to_SIGNDOC_RGBColor(const struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_Color
 */
struct SIGNDOC_Color * SDCAPI SIGNDOC_RGBColor_to_SIGNDOC_Color(const struct SIGNDOC_Color *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Document_delete(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the type of the document. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The document type. 

 */
int  SDCAPI SIGNDOC_Document_getType(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the number of pages. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The number of pages. 

 */
int  SDCAPI SIGNDOC_Document_getPageCount(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Create a SignDocSignatureParameters object for signing a signature field. 
 * @details The caller is responsible for destroying the object.
Any SignDocSignatureParameters object should be used for at most one signature.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFieldName. 
 * @param[in] aFieldName The name of the signature field, encoded according to aEncoding. 
 * @param[in] aProfile The profile name (ASCII). Some document types and signature fields support different sets of default parameters. For instance, DigSig fields of PDF documents have a "FinanzIT" profile. The default profile, "", is supported for all signature fields. 
 * @param[out] aOutput A pointer to the new parameters object will be stored here. The caller is responsible for destroying the object.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_createSignatureParameters(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFieldName, const char * aProfile, struct SIGNDOC_SignatureParameters ** aOutput);

/**
 * @brief Get a list of profiles for a signature field. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFieldName. 
 * @param[in] aFieldName The name of the signature field encoded according to aEncoding. 
 * @param[out] aOutput The names (ASCII) of all profiles supported by the signature field will be stored here, excluding the default profile "" which is always available.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getProfiles(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFieldName, struct SIGNDOC_StringArray * aOutput);

/**
 * @brief Sign the document. 
 * @details This function stores changed properties in the document before signing. If the string parameter "OutputPath" is set, the document will be stored in a new file specified by that parameter. If string parameter "TemporaryDirectory" is set (and "OutputPath" is not set), the document will be stored in a new temporary file. Use getPathname() to obtain the pathname of that temporary file. In either case, the original file won't be modified (however, it will be deleted if it is a temporary file, ie, if "TemporaryDirectory" was used). If neither "OutputPath" nor "TemporaryDirectory" is set, the document will be written to the file from which it was loaded or to which it was most recently saved.
Some document types may allow adding signatures only if all signatures of the documents are valid.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aParameters The signing parameters.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addSignature(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_SignatureParameters * aParameters);

/**
 * @brief Get the timestamp used by the last successful call of addSignature(). 
 * @details This function may return a timestamp even if the last call of addSignature() was not successful. See also string parameters "Timestamp" and "TimeStampServerURL" of SignDocSignatureParameters.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aTime The timestamp in ISO 8601 format (yyyy-mm-ddThh:mm:ss without milliseconds, with optional timezone (or an empty string if there is no timestamp available) will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getLastTimestamp(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, char ** aTime);

/**
 * @brief Get the current pathname of the document. 
 * @details The pathname will be empty if the document is stored in memory (ie, if it has been loaded from memory or saved to a stream).
If a FDF document has been opened, this function will return the pathname of the referenced PDF file.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for aPath. 
 * @param[out] aPath The pathname will be stored here.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_getPathname(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, char ** aPath);

/**
 * @brief Get a bitset indicating which signing methods are available for this document. 
 * @details This document's signature fields offer a subset of the signing methods returned by this function.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return 1<<SignDocSignatureParameters::m_signdoc etc.

 */
int  SDCAPI SIGNDOC_Document_getAvailableMethods(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Verify a signature of the document. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFieldName. 
 * @param[in] aFieldName The name of the signature field encoded according to aEncoding. 
 * @param[out] aOutput A pointer to a new SignDocVerificationResult object or NULL will be stored here. The caller is responsible for destroying that object.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_verifySignature(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFieldName, struct SIGNDOC_VerificationResult ** aOutput);

/**
 * @brief Remove a signature of the document. 
 * @details For some document formats (TIFF), signatures may only be cleared in the reverse order of signing (LIFO).
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFieldName. 
 * @param[in] aFieldName The name of the signature field encoded according to aEncoding.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_clearSignature(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFieldName);

/**
 * @brief Remove all signature of the document. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_clearAllSignatures(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Save the document to a stream. 
 * @details This function may have side effects on the document such as marking it as not modified which may render sf_incremental useless for the next saveToFile() call unless the document is changed between those two calls. sf_incremental is not supported by this function.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The document will be saved to this stream. 
 * @param[in] aFlags Set of flags (of enum SaveFlags, combined with `|') modifying the behavior of this function. Pass 0 for no flags. Which flags are available depends on the document type.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_saveToStream(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_OutputStream * aStream, int aFlags);

/**
 * @brief Save the document to a file. 
 * @details After a successful call to this function, the document behaves as if it had been loaded from the specified file. sf_incremental is supported only if NULL is passed for aPath, that is, when saving to the file from which the document was loaded or to which the document was most recently saved (by saveToFile(), not by saveToStream()).
Saving a signed PDF document without sf_incremental will break all signatures, see getRequiredSaveToFileFlags().
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aPath. 
 * @param[in] aPath The pathname of the file to be created or overwritten. Pass NULL to save to the file from which the document was loaded or most recently saved (which will fail if the documment was loaded from memory or saved to a stream). 
 * @param[in] aFlags Set of flags (of enum SaveFlags, combined with `|') modifying the behavior of this function. Pass 0 for no flags. Which flags are available depends on the document type.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_saveToFile_cset(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aPath, int aFlags);

/**
 * @brief Save the document to a file. 
 * @details After a successful call to this function, the document behaves as if it had been loaded from the specified file. sf_incremental is supported only if NULL is passed for aPath, that is, when saving to the file from which the document was loaded or to which the document was most recently saved (by saveToFile(), not by saveToStream()).
Saving a signed PDF document without sf_incremental will break all signatures.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The pathname of the file to be created or overwritten. Pass NULL to save to the file from which the document was loaded or most recently saved (which will fail if the documment was loaded from memory or saved to a stream). 
 * @param[in] aFlags Set of flags (of enum SaveFlags, combined with `|') modifying the behavior of this function. Pass 0 for no flags. Which flags are available depends on the document type.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_saveToFile(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aPath, int aFlags);

/**
 * @brief Copy the document's backing file to a stream. 
 * @details This function copies to a stream the file from which the document was loaded or to which the document was most recently saved. Changes made to the in-memory copy of the document since it was loaded or saved will not be reflected in the copy written to the stream. This function does not have side effects on the document. This function will fail (returning rc_not_supported) if the document has not been saved to a file since it was loaded from memory or saved to a stream.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The file will be copied to this stream.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_copyToStream(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_OutputStream * aStream);

/**
 * @brief Copy the document to a stream for viewing the document "as signed". 
 * @details This function copies to a stream the document as it was when the specified signature field was signed. If the specified signature field contains the last signature applied to the document, this function is equivalent to copyToStream(). However, for some document formats, this function may require signatures to be valid.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFieldName. 
 * @param[in] aFieldName The name of the signature field encoded according to aEncoding. 
 * @param[in] aStream The file will be copied to this stream.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_copyAsSignedToStream(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFieldName, struct SIGNDOC_OutputStream * aStream);

/**
 * @brief Get all flags currently valid for saveToStream(). 
 * @details sf_pdfa_buttons is returned only if the document claims to be PDF/A-compliant.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The flags will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getSaveToStreamFlags(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get all flags currently valid for saveToFile(). 
 * @details Note that sf_incremental cannot be used together with sf_linearized even if all these flags are returned by this function. sf_pdfa_buttons is returned only if the document claims to be PDF/A-compliant.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The flags will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getSaveToFileFlags(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get all flags currently required for saveToFile(). 
 * @details This function currently stores sf_incremental (saving the document non-incrementally would destroy existing signatures) or 0 (the document may be saved non-incrementally) to aOutput.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The flags will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getRequiredSaveToFileFlags(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get all interactive fields of the specified types. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTypes 0 to get fields of all types. Otherwise, a bitset selecting the field types to be included. To include a field of type t, add 1<<t, where t is a value of SignDocField::Type. 
 * @param[out] aOutput The fields will be stored here. They appear in the order in which they have been defined.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getFields(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTypes, struct SIGNDOC_FieldArray * aOutput);

/**
 * @brief Get all interactive fields of the specified page, in tab order. 
 * @details If the document does not specify a tab order, the fields will be returned in widget order.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The 1-based page number. 
 * @param[in] aTypes 0 to get fields of all types. Otherwise, a bitset selecting the field types to be included. To include a field of type t, add 1<<t, where t is a value of SignDocField::Type. 
 * @param[out] aOutput The fields will be stored here in tab order.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getFieldsOfPage(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, int aTypes, struct SIGNDOC_FieldArray * aOutput);

/**
 * @brief Get an interactive field by name. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The fully-qualified name of the field. 
 * @param[out] aOutput The field will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getField(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, struct SIGNDOC_Field * aOutput);

/**
 * @brief Change a field. 
 * @details This function changes a field in the document using attributes from a SignDocField object. Everything except for the name and the type of the field can be changed. See the member functions of SignDocField for details.
Always get a SignDocField object for a field by calling getField(), getFields(), or getFields(), then apply your modifications to that object, then call setField().
Do not try to build a SignDocField object from scratch for changing a field as future versions of the SignDocField class may have additional attributes.
This function is implemented for PDF documents only.
This function always fails for PDF documents that have signed signature fields.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aField The field to be changed. The font resource name of the default text field attributes may be modified. The value index and the value may be modified for radio button fields and check box fields. 
 * @param[in] aFlags Flags modifying the behavior of this function, see enum SetFieldFlags.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_setField(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Field * aField, unsigned aFlags);

/**
 * @brief Add a field. 
 * @details See the members of SignDocField for details.
This function can add check boxes, radio button groups, text fields, and signature fields to PDF documents.
When adding a radio button group or a check box field, a value must be set, see SignDocField::setValue() and SignDocField::setValueIndex().
The SignDocField::f_NoToggleToOff flag should be set for all radio button groups. Adobe products seem to ignore this flag being not set.
When adding a text field, the justification must be set with SignDocField::setJustification().
Currently, you don't have control over the appearance of the field being inserted except for the text field attributes.
Adding a field to a PDF document that doesn't contain any fields will set the document's default text field attributes to font Helvetica, font size 0, text color black.
Only signature fields can be added to PDF documents having signed signature fields.
TIFF documents support signature fields only and all signature fields must be inserted before the first signature is added to the document (you may want to use invisible fields) unless all existing signature fields have flag f_EnableAddAfterSigning set.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aField The new field. The font resource name of the default text field attributes may be modified. The value index and the value may be modified for radio button fields and check box fields. 
 * @param[in] aFlags Flags modifying the behavior of this function, see enum SetFieldFlags.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addField(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Field * aField, unsigned aFlags);

/**
 * @brief Remove a field. 
 * @details Removing a field of a TIFF document will invalidate all signatures.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The fully-qualified name of the field.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_removeField(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Flatten a field. 
 * @details Flattening a field of a PDF document makes its appearance part of the page and removes the selected widget or all widgets; the field will be removed when all its widgets have been flattened.
Flattening unsigned signature fields does not work correctly.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The fully-qualified name of the field. 
 * @param[in] aWidget The widget index to flatten only one widget or -1 to flatten all widgets.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_flattenField(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, int aWidget);

/**
 * @brief Flatten all fields of the document or of a range of pages. 
 * @details Flattening a field of a PDF document makes its appearance part of the page and removes the selected widget or all widgets; the field will be removed when all its widgets have been flattened. This function selects all widgets on the specified pages.
Flattening unsigned signature fields does not work correctly.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFirstPage 1-based number of first page. 
 * @param[in] aLastPage 1-based number of last page or 0 to process all pages to the end of the document. 
 * @param[in] aFlags Flags modifying the behavior of this function, must be 0.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_flattenFields(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aFirstPage, int aLastPage, unsigned aFlags);

/**
 * @brief Export all fields as XML. 
 * @details This function always uses UTF-8 encoding. The output conforms to schema PdfFields.xsd.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The fields will be saved to this stream. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ExportFlags.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_exportFields(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_OutputStream * aStream, int aFlags);

/**
 * @brief Apply an FDF document to a PDF document. 
 * @details FDF documents can be applied to PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aPath. 
 * @param[in] aPath The pathname of the FDF document. 
 * @param[in] aFlags Flags modifying the behavior of this function, see enum SetFieldFlags.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_applyFdf_cset(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aPath, unsigned aFlags);

/**
 * @brief Apply an FDF document to a PDF document. 
 * @details FDF documents can be applied to PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The pathname of the FDF document. 
 * @param[in] aFlags Flags modifying the behavior of this function, see enum SetFieldFlags.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_applyFdf(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aPath, unsigned aFlags);

/**
 * @brief Get the document's default text field attributes. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aOutput This object will be updated.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getTextFieldAttributes(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_TextFieldAttributes * aOutput);

/**
 * @brief Set the document's default text field attributes. 
 * @details Font name, font size, and text color must be specified. This function fails if aData has any but not all attributes set or if any of the attributes are invalid.
This function fails for signed PDF document.
This function always fails for TIFF documents.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aData The new default text field attributes. The font resource name will be updated.
 * @return rc_ok iff successful.

 */
int  SDCAPI SIGNDOC_Document_setTextFieldAttributes(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_TextFieldAttributes * aData);

/**
 * @brief Get the names and types of all SignDoc properties of a certain collection of properties of the document. 
 * @details Use getBooleanProperty(), getIntegerProperty(), or getStringProperty() to get the values of the properties. Documents supporting a SignDoc data block store properties in the SignDoc data block.
There are three collections of SignDoc document properties:"encrypted" Encrypted properties. Names and values are symmetrically encrypted."public" Public properties. Document viewer applications may be able to display or let the user modify these properties."pdfa" PDF/A properties (PDF documents only):part (PDF/A version identifier)amd (optional PDF/A amendment identifier)conformance (PDF/A conformance level: A or B)
All properties in this collection have string values, the property names are case-sensitive. If the "part" property is present, the document claims to be conforming to PDF/A. Your application may change its behavior when dealing with PDF/A documents. For instance, it might want to avoid transparency.
Using the same property name in the "encrypted" and "public" collections is not possible. Attempts to get, set, or remove a property in the wrong collection will fail with error code rc_wrong_collection. To move a property from one collection to another collection, first remove it from the source collection, then add it to the target collection.
The "pdfa" collection is read-only and a property name existing in that collection does not prevent that property name from appearing in one of the other collections.
The syntax of property names depends on the document type and the collection containing the property.
"public" properties of PDF documents are stored according to XMP in namespace "http://www.softpro.de/pdfa/signdoc/public/", therefore property names must be valid unqualified XML names, see the syntax of "Name" in the XML 1.1 specification at http://www.w3.org/TR/2004/REC-xml11-20040204/#sec-common-syn (section 2.3 Common Syntactic Constructs).
For "encrypted" properties and any properties in TIFF documents, property names can contain arbitrary Unicode characters except for NUL.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aCollection The name of the collection, see above. 
 * @param[out] aOutput The properties will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getProperties(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const char * aCollection, struct SIGNDOC_PropertyArray * aOutput);

/**
 * @brief Get the value of a SignDoc property (integer). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[out] aValue The value will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getIntegerProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, long * aValue);

/**
 * @brief Get the value of a SignDoc property (string). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName and for aValue. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[out] aValue The value will be stored here, encoded according to aEncoding.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getStringProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, char ** aValue);

/**
 * @brief Get the value of a SignDoc property (boolean). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[out] aValue The value will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getBooleanProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, int * aValue);

/**
 * @brief Set the value of a SignDoc property (integer). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
It's not possible to change the type of a property.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[in] aValue The new value of the property.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_setIntegerProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, long aValue);

/**
 * @brief Set the value of a SignDoc property (string). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
It's not possible to change the type of a property. Embedded NUL characters are not supported.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName and aValue. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[in] aValue The new value of the property.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_setStringProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, const char * aValue);

/**
 * @brief Set the value of a SignDoc property (boolean). 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
It's not possible to change the type of a property.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property. 
 * @param[in] aValue The new value of the property.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_setBooleanProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName, int aValue);

/**
 * @brief Remove a SignDoc property. 
 * @details In the "public" and "encrypted" collections, property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aCollection The name of the collection, see getProperties(). 
 * @param[in] aName The name of the property.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_removeProperty(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aCollection, const char * aName);

/**
 * @brief Export properties as XML. 
 * @details This function always uses UTF-8 encoding. The output conforms to schema AllSignDocProperties.xsd (if aCollection is empty) or SignDocProperties.xsd (if aCollection is non-empty).
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aCollection The name of the collection, see getProperties(). If the string is empty, all properties of the "public" and "encrypted" collections will be exported. 
 * @param[in] aStream The properties will be saved to this stream. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ExportFlags.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_exportProperties(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const char * aCollection, struct SIGNDOC_OutputStream * aStream, int aFlags);

/**
 * @brief Import properties from XML. 
 * @details The input must conform to schema AllSignDocProperties.xsd (if aCollection is empty) or SignDocProperties.xsd (if aCollection is non-empty).
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aCollection The name of the collection, see getProperties(). If the string is empty, properties will be imported into all collections, otherwise properties will be imported into the specified collection. 
 * @param[in] aStream The properties will be read from this stream. This function reads the input completely, it doesn't stop at the end tag. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ImportFlags.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_importProperties(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const char * aCollection, struct SIGNDOC_InputStream * aStream, int aFlags);

/**
 * @brief Get the SignDoc data block of the document. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The serialized data block will be copied to this object.
 * @return rc_ok if successful, rc_no_datablock if there is no SignDoc data block, rc_not_supported if the document type does not support a SignDoc data block.

 */
int  SDCAPI SIGNDOC_Document_getDataBlock(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Replace the SignDoc data block of the document. 
 * @details This function discards properties set with setStringProperty() etc., including unsaved changes.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aData Pointer to the first octet of the serialized data block. 
 * @param[in] aSize Size of the serialized data block (number of octets).
 * @return rc_ok if successful, rc_not_supported if the document type does not support a SignDoc data block.

 */
int  SDCAPI SIGNDOC_Document_setDataBlock(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const unsigned char * aData, size_t aSize);

/**
 * @brief Get the resolution of a page. 
 * @details Different pages of the document may have different resolutions. Use getConversionFactors() to get factors for converting document coordinates to real world coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page). 
 * @param[out] aResX The horizontal resolution in DPI will be stored here. The value will be 0.0 if the resolution is not available. 
 * @param[out] aResY The vertical resolution in DPI will be stored here. The value will be 0.0 if the resolution is not available.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getResolution(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, double * aResX, double * aResY);

/**
 * @brief Get the conversion factors for a page. 
 * @details Different pages of the document may have different conversion factors. For TIFF documents, this function yields the same values as getResolution().
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page). 
 * @param[out] aFactorX Divide horizontal coordinates by this number to convert document coordinates to inches. The value will be 0.0 if the conversion factor is not available. 
 * @param[out] aFactorY Divide vertical coordinates by this number to convert document coordinates to inches. The value will be 0.0 if the conversion factor is not available.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getConversionFactors(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, double * aFactorX, double * aFactorY);

/**
 * @brief Get the size of a page. 
 * @details Different pages of the document may have different sizes. Use getConversionFactors() to get factors for converting the page size from document coordinates to real world dimensions.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page). 
 * @param[out] aWidth The width of the page (in document coordinates) will be stored here. 
 * @param[out] aHeight The height of the page (in document coordinates) will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getPageSize(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, double * aWidth, double * aHeight);

/**
 * @brief Get the number of bits per pixel (TIFF only). 
 * @details Different pages of the document may have different numbers of bits per pixel.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page). 
 * @param[out] aBPP The number of bits per pixel of the page (1, 8, 24, or 32) or 0 (for PDF documents) will be stored here.
 * @return rc_ok if successful, rc_invalid_argument if aPage is out of range. 

 */
int  SDCAPI SIGNDOC_Document_getBitsPerPixel(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, int * aBPP);

/**
 * @brief Compute the zoom factor used for rendering. 
 * @details If SignDocRenderParameters::fitWidth(), SignDocRenderParameters::fitHeight(), or SignDocRenderParameters::fitRect() has been called, the actual factor depends on the document's page size. If multiple pages are selected (see SignDocRenderParameters::setPages()), the maximum width and maximum height of all selected pages will be used.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The zoom factor will be stored here. 
 * @param[in] aParams The parameters such as the page number and the zoom factor.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_computeZoom(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, double * aOutput, const struct SIGNDOC_RenderParameters * aParams);

/**
 * @brief Convert a point expressed in canvas (image) coordinates to a point expressed in document coordinate system of the current page. 
 * @details The origin is in the bottom left corner of the page. The origin is in the upper left corner of the image. See signdocshared_coordinates. If multiple pages are selected (see SignDocRenderParameters::setPages()), the first page of the range will be used.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aPoint The point to be converted. 
 * @param[in] aParams The parameters such as the page number and the zoom factor.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_convCanvasPointToPagePoint(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Point * aPoint, const struct SIGNDOC_RenderParameters * aParams);

/**
 * @brief Convert a point expressed in document coordinate system of the current page to a point expressed in canvas (image) coordinates. 
 * @details The origin is in the bottom left corner of the page. The origin is in the upper left corner of the image. See signdocshared_coordinates. If multiple pages are selected (see SignDocRenderParameters::setPages()), the first page of the range will be used.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aPoint The point to be converted. 
 * @param[in] aParams The parameters such as the page number and the zoom factor.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_convPagePointToCanvasPoint(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Point * aPoint, const struct SIGNDOC_RenderParameters * aParams);

/**
 * @brief Render the selected page (or pages) as image. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aImage The image will be stored here as a blob. 
 * @param[out] aOutput The image size will be stored here. 
 * @param[in] aParams Parameters such as the page number. 
 * @param[in] aClipRect The rectangle to be rendered (using document coordinates, see signdocshared_coordinates) or NULL to render the complete page.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_renderPageAsImage(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_ByteArray * aImage, struct SIGNDOC_RenderOutput * aOutput, const struct SIGNDOC_RenderParameters * aParams, const struct SIGNDOC_Rect * aClipRect);

/**
 * @brief Render the selected page to a spooc image. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aImage This object will be updated to contain the desired image. 
 * @param[out] aOutput The image size will be stored here. 
 * @param[in] aParams Parameters such as the page number. There must be exactly one page selected. 
 * @param[in] aClipRect The rectangle to be rendered (using document coordinates, see signdocshared_coordinates) or NULL to render the complete page.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_renderPageAsSpoocImage(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Image * aImage, struct SIGNDOC_RenderOutput * aOutput, const struct SIGNDOC_RenderParameters * aParams, const struct SIGNDOC_Rect * aClipRect);

/**
 * @brief Render the selected page (or pages) to a spooc multi-page image. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aImages This object will be updated to contain the desired images. 
 * @param[out] aOutput The image size will be stored here. 
 * @param[in] aParams Parameters such as the page number. 
 * @param[in] aClipRect The rectangle to be rendered (using document coordinates, see signdocshared_coordinates) or NULL to render the complete page.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_renderPageAsSpoocImages(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Images * aImages, struct SIGNDOC_RenderOutput * aOutput, const struct SIGNDOC_RenderParameters * aParams, const struct SIGNDOC_Rect * aClipRect);

/**
 * @brief Get the size of the rendered page in pixels (without actually rendering it). 
 * @details The returned values may be approximations for some document formats. If multiple pages are selected (see SignDocRenderParameters::setPages()), the maximum width and maximum height of all selected pages will be used.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The width and height of the image that would be computed by renderPageAsImage() with aClipRect being NULL will be stored here. 
 * @param[in] aParams Parameters such as the page number.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getRenderedSize(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_RenderOutput * aOutput, const struct SIGNDOC_RenderParameters * aParams);

/**
 * @brief Create a line annotation. 
 * @details See SignDocAnnotation for details.
This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStart Start point. 
 * @param[in] aEnd End point.
 * @return The new annotation object. The caller is responsible for destroying the object after use.

 */
struct SIGNDOC_Annotation *  SDCAPI SIGNDOC_Document_createLineAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Point * aStart, const struct SIGNDOC_Point * aEnd);

/**
 * @brief Create a line annotation. 
 * @details See SignDocAnnotation for details. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStartX X coordinate of start point. 
 * @param[in] aStartY Y coordinate of start point. 
 * @param[in] aEndX X coordinate of end point. 
 * @param[in] aEndY Y coordinate of end point.
 * @return The new annotation object. The caller is responsible for destroying the object after use.

 */
struct SIGNDOC_Annotation *  SDCAPI SIGNDOC_Document_createLineAnnotation_double(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, double aStartX, double aStartY, double aEndX, double aEndY);

/**
 * @brief Create a scribble annotation. 
 * @details See SignDocAnnotation for details. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The new annotation object. The caller is responsible for destroying the object after use.

 */
struct SIGNDOC_Annotation *  SDCAPI SIGNDOC_Document_createScribbleAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Create a text annotation. 
 * @details See SignDocAnnotation for details. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aLowerLeft coordinates of lower left corner. 
 * @param[in] aUpperRight coordinates of upper right corner.
 * @return The new annotation object. The caller is responsible for destroying the object after use.

 */
struct SIGNDOC_Annotation *  SDCAPI SIGNDOC_Document_createFreeTextAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Point * aLowerLeft, const struct SIGNDOC_Point * aUpperRight);

/**
 * @brief Create a text annotation. 
 * @details See SignDocAnnotation for details. This function uses document (page) coordinates, see signdocshared_coordinates.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aX0 X coordinate of lower left corner. 
 * @param[in] aY0 Y coordinate of lower left corner. 
 * @param[in] aX1 X coordinate of upper right corner. 
 * @param[in] aY1 Y coordinate of upper right corner.
 * @return The new annotation object. The caller is responsible for destroying the object after use.

 */
struct SIGNDOC_Annotation *  SDCAPI SIGNDOC_Document_createFreeTextAnnotation_double(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, double aX0, double aY0, double aX1, double aY1);

/**
 * @brief Add an annotation to a page. 
 * @details See SignDocAnnotation for details.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page). 
 * @param[in] aAnnot Pointer to the new annotation. Ownership remains at the caller.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aPage, const struct SIGNDOC_Annotation * aAnnot);

/**
 * @brief Get a list of all named annotations of a page. 
 * @details Unnamed annotations are ignored by this function.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the names of the annotations returned in aOutput. 
 * @param[in] aPage The page number (1 for the first page). 
 * @param[out] aOutput The names of the annotations will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAnnotations(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aPage, struct SIGNDOC_StringArray * aOutput);

/**
 * @brief Get a named annotation of a page. 
 * @details All setters will fail for the returned object.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aPage The page number (1 for the first page). 
 * @param[in] aName The name of the annotation. 
 * @param[out] aOutput A pointer to a new SignDocAnnotation object or NULL will be stored here. The caller is responsible for destroying that object.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aPage, const char * aName, struct SIGNDOC_Annotation ** aOutput);

/**
 * @brief Remove an annotation identified by name. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aPage The page number (1 for the first page). 
 * @param[in] aName The name of the annotation, must not be empty.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_removeAnnotation(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aPage, const char * aName);

/**
 * @brief Add text to a page. 
 * @details Multiple lines are not supported, the text must not contain CR and LF characters.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aText and aFontName. 
 * @param[in] aText The text. Complex scripts are supported, see signdocshared_complex_scripts. 
 * @param[in] aPage The 1-based page number of the page. 
 * @param[in] aX The X coordinate of the reference point of the first character in document coordinates. 
 * @param[in] aY The Y coordinate of the reference point of the first character in document coordinates. 
 * @param[in] aFontName The font name. This can be the name of a standard font, the name of an already embedded font, or the name of a font defined by a font configuration file. 
 * @param[in] aFontSize The font size (in user space units). 
 * @param[in] aTextColor The text color. 
 * @param[in] aOpacity The opacity, 0.0 (transparent) through 1.0 (opaque). Documents conforming to PDF/A must use an opacity of 1.0. 
 * @param[in] aFlags Must be 0.

 */
int  SDCAPI SIGNDOC_Document_addText(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aText, int aPage, double aX, double aY, const char * aFontName, double aFontSize, const struct SIGNDOC_Color * aTextColor, double aOpacity, int aFlags);

/**
 * @brief Add text in a rectangle of a page (with line breaking). 
 * @details Any sequence of CR and LF characters in the text starts a new paragraph (ie, text following such a sequence will be placed at the beginning of the next output line). In consequence, empty lines in the input do not produce empty lines in the output. To get an empty line in the output, you have to add a paragraph containing a non-breaking space (0xa0) only: "Linebeforeemptyline\n\xa0\nLineafteremptyline"
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aText and aFontName. 
 * @param[in] aText The text. Allowed control characters are CR and LF. Any sequence of CR and LF characters starts a new paragraph. 
 * @param[in] aPage The 1-based page number of the page. 
 * @param[in] aX0 X coordinate of lower left corner. 
 * @param[in] aY0 Y coordinate of lower left corner. 
 * @param[in] aX1 X coordinate of upper right corner. 
 * @param[in] aY1 Y coordinate of upper right corner. 
 * @param[in] aFontName The font name. This can be the name of a standard font, the name of an already embedded font, or the name of a font defined by a font configuration file. 
 * @param[in] aFontSize The font size (in user space units). 
 * @param[in] aLineSkip The vertical distance between the baselines of successive lines (usually 1.2 * aFontSize). 
 * @param[in] aTextColor The text color. 
 * @param[in] aOpacity The opacity, 0.0 (transparent) through 1.0 (opaque). Documents conforming to PDF/A must use an opacity of 1.0. 
 * @param[in] aHAlignment Horizontal alignment of the text. 
 * @param[in] aVAlignment Vertical alignment of the text. 
 * @param[in] aFlags Must be 0.

 */
int  SDCAPI SIGNDOC_Document_addTextRect(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aText, int aPage, double aX0, double aY0, double aX1, double aY1, const char * aFontName, double aFontSize, double aLineSkip, const struct SIGNDOC_Color * aTextColor, double aOpacity, int aHAlignment, int aVAlignment, int aFlags);

/**
 * @brief Add a watermark. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aInput An object describing the watermark.

 */
int  SDCAPI SIGNDOC_Document_addWatermark(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Watermark * aInput);

/**
 * @brief Find text. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aText. 
 * @param[in] aFirstPage 1-based number of first page to be searched. 
 * @param[in] aLastPage 1-based number of last page to be searched or 0 to search to the end of the document. 
 * @param[in] aText Text to be searched for. Multiple successive spaces are treated as single space (and may be ignored subject to aFlags). 
 * @param[in] aFlags Flags modifying the behavior of this function, see enum FindTextFlags. 
 * @param[out] aOutput The positions where aText was found.
 * @return rc_ok on success (even if the text was not found). 

 */
int  SDCAPI SIGNDOC_Document_findText(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aFirstPage, int aLastPage, const char * aText, int aFlags, struct SIGNDOC_FindTextPositionArray * aOutput);

/**
 * @brief Add an attachment to the document. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName and aDescription. 
 * @param[in] aName The name of the attachment. Will also be used as filename of the attachment and must not contain slashes, backslashes, and colons. 
 * @param[in] aDescription The description of the attachment (can be empty). 
 * @param[in] aType The MIME type of the attachment (can be empty, seems to be ignored by Adobe Reader). 
 * @param[in] aModificationTime The time and date of the last modification of the file being attached to the document (can be empty). Must be in ISO 8601 extended calendar date format with optional timezone. 
 * @param[in] aPtr Pointer to the first octet of the attachment. 
 * @param[in] aSize The size (in octets) of the attachment. 
 * @param[in] aFlags Must be zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addAttachmentBlob(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, const char * aDescription, const char * aType, const char * aModificationTime, const void * aPtr, size_t aSize, int aFlags);

/**
 * @brief Add an attachment (read from a file) to the document. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding1 The encoding of aName and aDescription. 
 * @param[in] aName The name of the attachment. Will also be used as filename of the attachment and must not contain slashes, backslashes, and colons. 
 * @param[in] aDescription The description of the attachment (can be empty). 
 * @param[in] aType The MIME type of the attachment (can be empty, seems to be ignored by Adobe Reader). 
 * @param[in] aEncoding2 The encoding of aPath. 
 * @param[in] aPath The pathname of the file to be attached. 
 * @param[in] aFlags Must be zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addAttachmentFile(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding1, const char * aName, const char * aDescription, const char * aType, int aEncoding2, const char * aPath, int aFlags);

/**
 * @brief Remove an attachment from the document. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName and aDescription. 
 * @param[in] aName The name of the attachment.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_removeAttachment(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Change the description of an attachment of the document. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName and aDescription. 
 * @param[in] aName The name of the attachment. 
 * @param[in] aDescription The new description of the attachment.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_changeAttachmentDescription(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, const char * aDescription);

/**
 * @brief Get a list of all attachments of the document. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the names returned in aOutput. 
 * @param[out] aOutput The names of the document's attachments will be stored here. Use getAttachment() to get information for a single attachment.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAttachments(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, struct SIGNDOC_StringArray * aOutput);

/**
 * @brief Get information about an attachment. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the attachment. 
 * @param[out] aOutput Information about the attachment will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAttachment(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, struct SIGNDOC_Attachment * aOutput);

/**
 * @brief Check the checksum of an attachment. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the attachment. 
 * @param[out] aOutput The result of the check will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_checkAttachment(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, int * aOutput);

/**
 * @brief Get an attachment as blob. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the attachment. 
 * @param[out] aOutput The attachment will be stored here.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAttachmentBlob(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Get an InputStream for an attachment. 
 * @details Attachments are supported for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the attachment. 
 * @param[out] aOutput A pointer to a new InputStream object will be stored here; the caller is responsible for deleting that object after use. The InputStream does not support seek(), tell(), and avail().
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_getAttachmentStream(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, struct SIGNDOC_InputStream ** aOutput);

/**
 * @brief Import pages from another document. 
 * @details This function is currently implemented for PDF documents only. The pages to be imported must not contain any interactive fields having names that are already used for intercative fields in the target document.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTargetPage The 1-based number of the page before which to insert the copied pages. The pages will be appended if this value is 0. 
 * @param[in] aSource The document from which to copy the pages. aSource can be this. 
 * @param[in] aSourcePage The 1-based number of the first page (in the source document) to be copied. 
 * @param[in] aPageCount The number of pages to be copied. All pages of aSource starting with aSourcePage will be copied if this value is 0. 
 * @param[in] aFlags Must be zero.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_importPages(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTargetPage, struct SIGNDOC_Document * aSource, int aSourcePage, int aPageCount, int aFlags);

/**
 * @brief Import a page from a blob containing an image. 
 * @details This function is currently implemented for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTargetPage The 1-based number of the page before which to insert the new page. The page will be appended if this value is 0. 
 * @param[in] aPtr Pointer to the first octet of the blob containing the image. Supported formats for inserting into PDF documents are: JPEG, PNG, GIF, TIFF, and BMP. 
 * @param[in] aSize Size (in octets) of the blob pointed to by aPtr. 
 * @param[in] aZoom Zoom factor or zero. If this argument is non-zero, aWidth and aHeight must be zero. The size of the page is computed from the image size and resolution, multiplied by aZoom. 
 * @param[in] aWidth Page width (document coordinates) or zero. If this argument is non-zero, aHeight must also be non-zero and aZoom must be zero. The image will be scaled to this width. 
 * @param[in] aHeight Page height (document coordinates) or zero. If this argument is non-zero, aWidth must also be non-zero and aZoom must be zero. The image will be scaled to this height. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ImportImageFlags. ii_keep_aspect_ratio is not needed if aZoom is non-zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_importPageFromImageBlob(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTargetPage, const unsigned char * aPtr, size_t aSize, double aZoom, double aWidth, double aHeight, int aFlags);

/**
 * @brief Import a page from a file containing an image. 
 * @details This function is currently implemented for PDF documents only.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTargetPage The 1-based number of the page before which to insert the new page. The page will be appended if this value is 0. 
 * @param[in] aEncoding The encoding of aPath. 
 * @param[in] aPath The pathname of the file containing the image. Supported formats for inserting into PDF documents are: JPEG, PNG, GIF, TIFF, and BMP. 
 * @param[in] aZoom Zoom factor or zero. If this argument is non-zero, aWidth and aHeight must be zero. The size of the page is computed from the image size and resolution, multiplied by aZoom. 
 * @param[in] aWidth Page width (document coordinates) or zero. If this argument is non-zero, aHeight must also be non-zero and aZoom must be zero. The image will be scaled to this width. 
 * @param[in] aHeight Page height (document coordinates) or zero. If this argument is non-zero, aWidth must also be non-zero and aZoom must be zero. The image will be scaled to this height. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ImportImageFlags. ii_keep_aspect_ratio is not needed if aZoom is non-zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_importPageFromImageFile(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTargetPage, int aEncoding, const char * aPath, double aZoom, double aWidth, double aHeight, int aFlags);

/**
 * @brief Add an image (from a blob) to a page. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTargetPage The 1-based number of the page. 
 * @param[in] aPtr Pointer to the first octet of the blob containing the image. Supported formats for inserting into PDF documents are: JPEG, PNG, GIF, TIFF, and BMP. 
 * @param[in] aSize Size (in octets) of the blob pointed to by aPtr. 
 * @param[in] aZoom Zoom factor or zero. If this argument is non-zero, aWidth and aHeight must be zero. The size of the page is computed from the image size and resolution, multiplied by aZoom. 
 * @param[in] aX The X coordinate of the point at which the lower left corner of the image shall be placed. 
 * @param[in] aY The Y coordinate of the point at which the lower left corner of the image shall be placed. 
 * @param[in] aWidth Image width (document coordinates) or zero. If this argument is non-zero, aHeight must also be non-zero and aZoom must be zero. The image will be scaled to this width. 
 * @param[in] aHeight Page height (document coordinates) or zero. If this argument is non-zero, aWidth must also be non-zero and aZoom must be zero. The image will be scaled to this height. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ImportImageFlags. ii_keep_aspect_ratio is not needed if aZoom is non-zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addImageFromBlob(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTargetPage, const unsigned char * aPtr, size_t aSize, double aZoom, double aX, double aY, double aWidth, double aHeight, int aFlags);

/**
 * @brief Add an image (from a file) to a page. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTargetPage The 1-based number of the page. 
 * @param[in] aEncoding The encoding of aPath. 
 * @param[in] aPath The pathname of the file containing the image. Supported formats for inserting into PDF documents are: JPEG, PNG, GIF, TIFF, and BMP. 
 * @param[in] aZoom Zoom factor or zero. If this argument is non-zero, aWidth and aHeight must be zero. The size of the page is computed from the image size and resolution, multiplied by aZoom. 
 * @param[in] aX The X coordinate of the point at which the lower left corner of the image shall be placed. 
 * @param[in] aY The Y coordinate of the point at which the lower left corner of the image shall be placed. 
 * @param[in] aWidth Image width (document coordinates) or zero. If this argument is non-zero, aHeight must also be non-zero and aZoom must be zero. The image will be scaled to this width. 
 * @param[in] aHeight Page height (document coordinates) or zero. If this argument is non-zero, aWidth must also be non-zero and aZoom must be zero. The image will be scaled to this height. 
 * @param[in] aFlags Flags modifying the behavior of this function, See enum ImportImageFlags. ii_keep_aspect_ratio is not needed if aZoom is non-zero.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_Document_addImageFromFile(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aTargetPage, int aEncoding, const char * aPath, double aZoom, double aX, double aY, double aWidth, double aHeight, int aFlags);

/**
 * @brief Remove pages from the document. 
 * @details A document must have at least page. This function will fail if you attempt to remove all pages.
Fields will be removed if all their widgets are on removed pages.
Only signatures in signature fields having the SignDocField::f_SinglePage flag set can survive removal of pages.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPagesPtr Pointer to an array of one-based page numbers. The order does not matter, neither does the number of occurences of a page number. 
 * @param[in] aPagesCount Number of page numbers pointed to by aPagesPtr. 
 * @param[in] aMode Tell this function whether to keep or to remove the pages specified by aPagesPtr.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_removePages(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, const int * aPagesPtr, int aPagesCount, int aMode);

/**
 * @brief Request to not make changes to the document which are incompatible with an older version of this class. 
 * @details No features introduced after aMajor.aMinor will be used.
Passing a version number before 1.11 or after the current version will fail.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aMajor Major version number. 
 * @param[in] aMinor Minor version number.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_setCompatibility(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aMajor, int aMinor);

/**
 * @brief Check if the document has unsaved changes. 
 * @details Note that this function might report unsaved changes directly after loading the document if the document is changed during loading by the underlying PDF library.
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aModified Will be set to true if the document has unsaved changes, will be set to false if the document does not have unsaved changes.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_Document_isModified(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int * aModified);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the error message.
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const char *  SDCAPI SIGNDOC_Document_getErrorMessage(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_Document
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const wchar_t *  SDCAPI SIGNDOC_Document_getErrorMessageW(struct SIGNDOC_Document *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_DocumentLoader * SDCAPI SIGNDOC_DocumentLoader_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_DocumentLoader_delete(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Load a document from memory. 
 * @details Signing some types of document may involve writing the document to a file, so using loadFromFile() function may be a better choice.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aData Pointer to the first octet of the document. This array of octets must live at least as long as the returned object. 
 * @param[in] aSize Size of the document (number of octets).
 * @return A pointer to a new SignDocDocument object representing the document, NULL if the document could not be loaded. The caller is responsible for destroying the object.

 */
struct SIGNDOC_Document *  SDCAPI SIGNDOC_DocumentLoader_loadFromMemory(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const unsigned char * aData, size_t aSize);

/**
 * @brief Load a document from a file. 
 * @details Signing the document will overwrite the document, but see integer parameter "Optimize" of SignDocSignatureParameters.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aPath. 
 * @param[in] aPath Pathname of the document file. 
 * @param[in] aWritable Open for writing (for signing in place)
 * @return A pointer to a new SignDocDocument object representing the document, NULL if the document could not be loaded. The caller is responsible for destroying the object.

 */
struct SIGNDOC_Document *  SDCAPI SIGNDOC_DocumentLoader_loadFromFile_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aPath, int aWritable);

/**
 * @brief Load a document from a file. 
 * @details Signing the document will overwrite the document, but see integer parameter "Optimize" of SignDocSignatureParameters.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath Pathname of the document file. 
 * @param[in] aWritable Open for writing (for signing in place)
 * @return A pointer to a new SignDocDocument object representing the document, NULL if the document could not be loaded. The caller is responsible for destroying the object.

 */
struct SIGNDOC_Document *  SDCAPI SIGNDOC_DocumentLoader_loadFromFile(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aPath, int aWritable);

/**
 * @brief Determine the type of a document. 
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream A seekable stream for the document.
 * @return The type of the document, dt_unknown on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_ping(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aStream);

/**
 * @brief Load font configuration from a file. 
 * @details Suitable fonts are required for putting text containing characters that cannot be encoded using WinAnsiEncoding into text fields, FreeText annotations, and DigSig appearances of PDF documents. See section signdocshared_fontconfig.
The font configuration applies to all SignDocDocument objects created by this object.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aPath. 
 * @param[in] aPath The pathname of the file.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadFontConfigFile_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aPath);

/**
 * @brief Load font configuration from a file. 
 * @details Suitable fonts are required for putting text containing characters that cannot be encoded using WinAnsiEncoding into text fields, FreeText annotations, and DigSig appearances of PDF documents. See section signdocshared_fontconfig.
The font configuration applies to all SignDocDocument objects created by this object.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The pathname of the file.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadFontConfigFile(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aPath);

/**
 * @brief Load font configuration from files specified by an environment variable. 
 * @details Suitable fonts are required for putting text containing characters that cannot be encoded using WinAnsiEncoding into text fields, FreeText annotations, and DigSig appearances of PDF documents. See section signdocshared_fontconfig.
Under Windows, directories are separated by semicolons. Under Unix, directories are separated by colons.
The font configuration applies to all SignDocDocument objects created by this object.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the environment variable.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadFontConfigEnvironment(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const char * aName);

/**
 * @brief Load font configuration from a stream. 
 * @details Suitable fonts are required for putting text containing characters that cannot be encoded using WinAnsiEncoding into text fields, FreeText annotations, and DigSig appearances of PDF documents. See section signdocshared_fontconfig.
The font configuration applies to all SignDocDocument objects created by this object.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The font configuration will be read from this stream. This function reads the input completely, it doesn't stop at the end tag. 
 * @param[in] aEncoding The encoding of the string pointed to by aDirectory. 
 * @param[in] aDirectory If non-NULL, relative font pathnames will be relative to this directory. The directory must exist and must be readable. If NULL, relative font pathnames will make this function fail.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadFontConfigStream_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aStream, int aEncoding, const char * aDirectory);

/**
 * @brief Load font configuration from a stream. 
 * @details Suitable fonts are required for putting text containing characters that cannot be encoded using WinAnsiEncoding into text fields, FreeText annotations, and DigSig appearances of PDF documents. See section signdocshared_fontconfig.
The font configuration applies to all SignDocDocument objects created by this object.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The font configuration will be read from this stream. This function reads the input completely, it doesn't stop at the end tag. 
 * @param[in] aDirectory If non-NULL, relative font pathnames will be relative to this directory. The directory must exist and must be readable. If NULL, relative font pathnames will make this function fail.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadFontConfigStream(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aStream, const wchar_t * aDirectory);

/**
 * @brief Load font configuration for PDF documents from a file. 
 * @details Additional fonts may be required for rendering PDF documents. The font configuration for PDF documents contains mappings from font names to font files. See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
The font configuration for PDF documents is global, ie, it affects all PDF documents, no matter by which SignDocDocumentLoader object they have been created.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aPath. 
 * @param[in] aPath The pathname of the file.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadPdfFontConfigFile_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aPath);

/**
 * @brief Load font configuration for PDF documents from a file. 
 * @details Additional fonts may be required for rendering PDF documents. The font configuration for PDF documents contains mappings from font names to font files. See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
The font configuration for PDF documents is global, ie, it affects all PDF documents, no matter by which SignDocDocumentLoader object they have been created.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPath The pathname of the file.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadPdfFontConfigFile(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aPath);

/**
 * @brief Load font configuration for PDF documents from files specified by an environment variable. 
 * @details Additional fonts may be required for rendering PDF documents. The font configuration for PDF documents contains mappings from font names to font files. See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
The font configuration for PDF documents is global, ie, it affects all PDF documents, no matter by which SignDocDocumentLoader object they have been created.
Under Windows, directories are separated by semicolons. Under Unix, directories are separated by colons.
See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the environment variable.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadPdfFontConfigEnvironment(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const char * aName);

/**
 * @brief Load font configuration for PDF documents from a stream. 
 * @details Additional fonts may be required for rendering PDF documents. The font configuration for PDF documents contains mappings from font names to font files. See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
The font configuration for PDF documents is global, ie, it affects all PDF documents, no matter by which SignDocDocumentLoader object they have been created.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The font configuration will be read from this stream. This function reads the input completely, it doesn't stop at the end tag. 
 * @param[in] aEncoding The encoding of the string pointed to by aDirectory. 
 * @param[in] aDirectory If non-NULL, relative font pathnames will be relative to this directory. The directory must exist and must be readable. If NULL, relative font pathnames will make this function fail.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadPdfFontConfigStream_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aStream, int aEncoding, const char * aDirectory);

/**
 * @brief Load font configuration for PDF documents from a stream. 
 * @details Additional fonts may be required for rendering PDF documents. The font configuration for PDF documents contains mappings from font names to font files. See section signdocshared_fontconfig. The "embed" attribute is ignored, substitutions with type="forced" are applied before those with type="fallback".
The font configuration for PDF documents is global, ie, it affects all PDF documents, no matter by which SignDocDocumentLoader object they have been created.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aStream The font configuration will be read from this stream. This function reads the input completely, it doesn't stop at the end tag. 
 * @param[in] aDirectory If non-NULL, relative font pathnames will be relative to this directory. The directory must exist and must be readable. If NULL, relative font pathnames will make this function fail.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_DocumentLoader_loadPdfFontConfigStream(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_InputStream * aStream, const wchar_t * aDirectory);

/**
 * @brief Get the pathnames of font files that failed to load for the most recent loadFontConfig*() or loadPdfFontConfig*() call. 
 * @details This includes files that could not be found and files that could not be loaded. In the former case, the pathname may contain wildcard characters.
Note that loadFontConfig*() and loadPdfFontConfig() no longer fail if a specified font file cannot be found or loaded.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The pathnames will be stored here.

 */
void  SDCAPI SIGNDOC_DocumentLoader_getFailedFontFiles(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_StringArray * aOutput);

/**
 * @brief Get an error message for the last load*() or ping() call. 
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the error message.
 * @return A pointer to a string describing the reason for the failure of the last call of load*() or ping(). The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const char *  SDCAPI SIGNDOC_DocumentLoader_getErrorMessage(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get an error message for the last load() or ping() call. 
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return A pointer to a string describing the reason for the failure of the last call of load() or ping(). The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const wchar_t *  SDCAPI SIGNDOC_DocumentLoader_getErrorMessageW(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Register a document handler. 
 * @details The behavior is undefined if multiple handlers for the same document type are registered.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aHandler An instance of a document handler. This object takes ownerswhip of the object.
 * @return true iff successful. 

 */
int  SDCAPI SIGNDOC_DocumentLoader_registerDocumentHandler(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_DocumentHandler * aHandler);

/**
 * @brief Register a document handler DLL. 
 * @details The DLL must export a function named SignDocCreateDocumentHandler_1 which creates an object implementing SignDocDocumentHandler: SignDocDocumentHandler*SignDocCreateDocumentHandler_1(); The DLL must use the same heap as the module (DLL or EXE) using the registered document handler.
The behavior is undefined if multiple handlers for the same document type are registered.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aName. 
 * @param[in] aName The name or pathname of the DLL.
 * @return true iff successful. 

 */
int  SDCAPI SIGNDOC_DocumentLoader_registerDocumentHandlerLibrary_cset(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Register a document handler DLL. 
 * @details The DLL must export a function named SignDocCreateDocumentHandler_1 which creates an object implementing SignDocDocumentHandler: SignDocDocumentHandler*SignDocCreateDocumentHandler_1(); The DLL must use the same heap as the module (DLL or EXE) using the registered document handler.
The behavior is undefined if multiple handlers for the same document type are registered.
 * @memberof SIGNDOC_DocumentLoader
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name or pathname of the DLL.
 * @return true iff successful. 

 */
int  SDCAPI SIGNDOC_DocumentLoader_registerDocumentHandlerLibrary(struct SIGNDOC_DocumentLoader *aObj, struct SIGNDOC_Exception *ex, const wchar_t * aName);

/**
 * @brief Initialize license management. 
 * @details License management must be initialized before SignDocDocument::renderPageAsImage() and SignDocDocument::addSignature() can be used.
 * @memberof SIGNDOC_DocumentLoader * @param[in] aWho1 The first magic number for the product. 
 * @param[in] aWho2 The second magic number for the product.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_initLicenseManager(struct SIGNDOC_Exception *ex, int aWho1, int aWho2);

/**
 * @brief Initialize license management with license key. 
 * @details License management must be initialized before SignDocDocument::renderPageAsImage() and SignDocDocument::addSignature() can be used.
 * @memberof SIGNDOC_DocumentLoader * @param[in] aKeyPtr Pointer to the first character of the license key. 
 * @param[in] aKeySize Size in octets of the license key. 
 * @param[in] aProduct Must be NULL. 
 * @param[in] aVersion Must be NULL. 
 * @param[in] aTokenPtr NULL or pointer to the first octet of the token. Should be NULL. 
 * @param[in] aTokenSize Size in octet of the license key.
 * @return true if successful, false on error.

 */
int  SDCAPI SIGNDOC_setLicenseKey(struct SIGNDOC_Exception *ex, const void * aKeyPtr, size_t aKeySize, const char * aProduct, const char * aVersion, const void * aTokenPtr, size_t aTokenSize);

/**
 * @brief Get the number of days until the license will expire. 
 * @memberof SIGNDOC_DocumentLoader * @param[in] aWhat Select which expiry date shall be used (rd_product or rd_signing).
 * @return -1 if the license has already expired or is invalid, 0 if the license will expire today, a positive value for the number of days the license is still valid. For licenses without expiry date, that will be several millions of days. 

 */
int  SDCAPI SIGNDOC_DocumentLoader_getRemainingDays(struct SIGNDOC_Exception *ex, int aWhat);

/**
 * @brief Get the installation code needed for creating a license file. 
 * @memberof SIGNDOC_DocumentLoader * @param[out] aCode The installation code will be stored here. Only ASCII characters are used.
 * @return true if successful, false on error. 

 */
int  SDCAPI SIGNDOC_getInstallationCode(struct SIGNDOC_Exception *ex, char ** aCode);

/**
 * @brief Get the version number of SignDocShared or SignDoc SDK. 
 * @memberof SIGNDOC_DocumentLoader * @param[out] aVersion The version number will be stored here. It consists of 3 integers separated by dots, .e.g., "1.16.7"
 * @return true if successful, false on error. 

 */
int  SDCAPI SIGNDOC_DocumentLoader_getVersionNumber(struct SIGNDOC_Exception *ex, char ** aVersion);

/**
 * @brief Get the number of license texts. 
 * @details SignDocSDK includes several Open Source components. You can retrieve the license texts one by one.
 * @memberof SIGNDOC_DocumentLoader * @return The number of license texts.

 */
int  SDCAPI SIGNDOC_DocumentLoader_getLicenseTextCount(struct SIGNDOC_Exception *ex);

/**
 * @brief Get a license text. 
 * @details SignDocSDK includes several Open Source components. You can retrieve the license texts one by one.
 * @memberof SIGNDOC_DocumentLoader * @param[in] aIndex The zero-based index of the license text.
 * @return A pointer to the null-terminated license text. Lines are terminated by LF characters. If aIndex is invalid, NULL will be returned.

 */
const char *  SDCAPI SIGNDOC_DocumentLoader_getLicenseText(struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Constructor. 
 * @details The new SignDocField object will have one widget. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Field * SDCAPI SIGNDOC_Field_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_Field * SDCAPI SIGNDOC_Field_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Field * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Field_delete(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_Field_set(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Field * aSource);

/**
 * @brief Efficiently swap this object with another one. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The other object. 

 */
void  SDCAPI SIGNDOC_Field_swap(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Field * aOther);

/**
 * @brief Get the name of the field. 
 * @details This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The name of the field.

 */
char *  SDCAPI SIGNDOC_Field_getName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the name of the field as UTF-8-encoded C string. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The name of the field. This pointer will become invalid when setName() is called or this object is destroyed. 

 */
const char *  SDCAPI SIGNDOC_Field_getNameUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the name of the field. 
 * @details Different document types impose different restrictions on field names. PDF fields have hierarchical field names with components separated by dots.
SignDocDocument::setField() operates on the field having a fully-qualified name which equals the name set by this function. In consequence, SignDocDocument::setField() cannot change the name of a field.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the field.

 */
void  SDCAPI SIGNDOC_Field_setName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Get the alternate name of the field. 
 * @details The alternate name (if present) should be used for displaying the field name in a user interface. Currently, only PDF documents support alternate field names.
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The alternate name of the field, empty if the field does not have an alternate name.

 */
char *  SDCAPI SIGNDOC_Field_getAlternateName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Set the alternate name of the field. 
 * @details The alternate name (if present) should be used for displaying the field name in a user interface. Currently, only PDF documents support alternate field names.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The alternate name of the field, empty to remove any alternate field name.

 */
void  SDCAPI SIGNDOC_Field_setAlternateName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Get the mapping name of the field. 
 * @details The mapping name (if present) should be used for exporting field data. Currently, only PDF documents support mapping field names.
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The mapping name of the field, empty if the field does not have an mapping name.

 */
char *  SDCAPI SIGNDOC_Field_getMappingName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Set the mapping name of the field. 
 * @details The mapping name (if present) should be used for exporting field data. Currently, only PDF documents support mapping field names.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The mapping name of the field, empty to remove any mapping name.

 */
void  SDCAPI SIGNDOC_Field_setMappingName(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Get the number of values of the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
getChoiceCount(), getValue()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getValueCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get a value of the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
Line breaks for multiline text fields (ie, text fields with flag f_MultiLine set) are encoded as "\r", "\n", or "\r\n".
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the value.
 * @return The selected value of the field or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get a value of the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
Line breaks for multiline text fields (ie, text fields with flag f_MultiLine set) are encoded as "\r", "\n", or "\r\n".
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the value.
 * @return The selected value of the field or an empty string if the index is out of range. This pointer will become invalid when addValue(), clearValues(), removeValue(), or setValue() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getValueUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Clear the values. 
 * @details After calling this function, getValueCount() will return 0 and getValueIndex() will return -1.
addValue(), getValueCount(), getValueIndex(), removeValue()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearValues(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a value to the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
Line breaks for multiline text fields (ie, text fields with flag f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior for values containing line breaks is undefined if the f_MultiLine flag is not set.
After calling this function, getValueIndex() will return -1.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The value to be added. Complex scripts are supported, see signdocshared_complex_scripts.

 */
void  SDCAPI SIGNDOC_Field_addValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aValue);

/**
 * @brief Set a value of the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
After calling this function, getValueIndex() will return -1.
Line breaks for multiline text fields (ie, text fields with flag f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior for values containing line breaks is undefined if the f_MultiLine flag is not set.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the value to be set. If aIndex equals the current number of values, the value will be added. 
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The value to be set. Complex scripts are supported, see signdocshared_complex_scripts.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setValue_by_index(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aValue);

/**
 * @brief Set the value of the field. 
 * @details Pushbutton fields and signature fields don't have a value, list boxes can have multiple values selected if f_MultiSelect is set.
Line breaks for multiline text fields (ie, text fields with flag f_MultiLine set) are encoded as "\r", "\n", or "\r\n". The behavior for values containing line breaks is undefined if the f_MultiLine flag is not set.
Calling this function is equivalent to calling clearValues() and addValue(), but the encoding of aValue is checked before modifying this object.
After calling this function, getValueIndex() will return -1.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The value to be set. Complex scripts are supported, see signdocshared_complex_scripts.

 */
void  SDCAPI SIGNDOC_Field_setValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aValue);

/**
 * @brief Remove a value from the field. 
 * @details After calling this function, getValueIndex() will return -1.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the value to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the current value index. 
 * @details Radio button groups and check box fields can have multiple widgets having the same button value. For check box fields and radio buttons without f_RadiosInUnison set, specifying the selected button by value string is not possible in that case. A 0-based value index can be used to find out which button is selected or to select a button.
Radio button groups and check box fields need not use a value index; in fact, they usually don't.
SignDocDocument::addField() and SignDocDocument::setField() update the value index if the value of a radio button group or check box field is selected by string (ie, setValue()) and the field has ambiguous button names.
The "Off" value never has a value index.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return the 0-based value index or -1 if the value index is not set.

 */
int  SDCAPI SIGNDOC_Field_getValueIndex(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the value index. 
 * @details Radio button groups and check box fields can have multiple widgets having the same button value. For check box fields and radio buttons without f_RadiosInUnison set, specifying the selected button by value string is ambiguous in that case. A 0-based value index can be used to find out which button is selected or to select a button.
Radio button groups and check box fields need not use a value index; in fact, they usually don't. However, you can always set a value index for radio button groups and check box fields.
If the value index is non-negative, SignDocDocument::addField() and SignDocDocument::setField() will use the value index instead of the string value set by setValue().
Calling setValueIndex() doesn't affect the return value of getValue() as the value index is used by SignDocDocument::addField() and SignDocDocument::setField() only. However, successful calls to SignDocDocument::addField() and SignDocDocument::setField() will make getValue() return the selected value.
For radio button groups with f_RadiosInUnison set and non-unique button values and for check box fields with non-unique button values, for each button value, the lowest index having that button value is the canonical one. After calling SignDocDocument::addField() or SignDocDocument::setField(), getValueIndex() will return the canonical value index.
Don't forget to update the value index when adding or removing widgets!
SignDocDocument::addField() and SignDocDocument::setField() will fail if the value index is non-negative for fields other than radio button groups and check box fields.
The "Off" value never has a value index.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex the 0-based value index or -1 to make the value index unset.

 */
void  SDCAPI SIGNDOC_Field_setValueIndex(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Click a check box or a radio button. 
 * @details This function updates both the value (see SetValue()) and the value index (see setValueIndex()) based on the current (non-committed) state of the SignDocField object (not looking at the state of the field in the document). It does nothing for other field types.
Adobe products seem to ignore f_NoToggleToOff flag being not set, this function behaves the same way (ie, as if f_NoToggleToOff was set).
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the widget being clicked.
 * @return true if anything has been changed, false if nothing has been changed (wrong field type, aIndex out of range, radio button already active). 

 */
int  SDCAPI SIGNDOC_Field_clickButton(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the number of available choices for a list box or combo box. 
 * @details List boxes and combo boxes can have multiple possible choices. For other field types, this function returns 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The number of available choices or 0 if not supported for the type of this field.

 */
int  SDCAPI SIGNDOC_Field_getChoiceCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get an available choice of a list box or combo box. 
 * @details List boxes and combo boxes can have multiple possible choices. Each choice has a value (which will be displayed) and an export value (which is used for exporting the value of the field). Usually, both values are identical. This function returns one choice value, use getChoiceExport() to get the associated export value.
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the choice value.
 * @return The selected choice value of the field or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getChoiceValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get an available choice of a list box or combo box. 
 * @details List boxes and combo boxes can have multiple possible choices. Each choice has a value (which will be displayed) and an export value (which is used for exporting the value of the field). Usually, both values are identical. This function returns one choice value, use getChoiceExportUTF8() to get the associated export value.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the choice value.
 * @return The selected choice value of the field or an empty string if the index is out of range. This pointer will become invalid when addChoice(), clearChoices(), removeChoice(), or setChoice() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getChoiceValueUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the export value for an available choice of a list box or combo box. 
 * @details List boxes and combo boxes can have multiple possible choices. Each choice has a value (which will be displayed) and an export value (which is used for exporting the value of the field). Usually, both values are identical. This function returns one export value, use getChoiceValue() to get the associated choice value.
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the export value.
 * @return The selected export value of the field or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getChoiceExport(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get the export value for an available choice of a list box or combo box. 
 * @details List boxes and combo boxes can have multiple possible choices. Each choice has a value (which will be displayed) and an export value (which is used for exporting the value of the field). Usually, both values are identical. This function returns one export value, use getChoiceValue() to get the associated choice value.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the choice value.
 * @return The selected export value of the field or an empty string if the index is out of range. This pointer will become invalid when addChoice(), clearChoices(), removeChoice(), or setChoice() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getChoiceExportUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Clear the choices of a list box or combo box. 
 * @details After calling this function, getChoiceCount() will return 0.
addChoice(), getChoiceCount(), removeChoice(), setButtonValue()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearChoices(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a choice to a list box or combo box. 
 * @details This function uses the choice value as export value.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The choice value and export value to be added. Complex scripts are supported, see signdocshared_complex_scripts.

 */
void  SDCAPI SIGNDOC_Field_addChoice(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aValue);

/**
 * @brief Add a choice to a list box or combo box. 
 * @details This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aValue and aExport. 
 * @param[in] aValue The choice value to be added. Complex scripts are supported, see signdocshared_complex_scripts. 
 * @param[in] aExport The export value to be added.

 */
void  SDCAPI SIGNDOC_Field_addChoice_with_export(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aValue, const char * aExport);

/**
 * @brief Set a choice value of a list box or combo box. 
 * @details This function uses the choice value as export value.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the choice to be set. If aIndex equals the current number of choice, the value will be added. 
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The choice value and export value to be set. Complex scripts are supported, see signdocshared_complex_scripts.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setChoice(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aValue);

/**
 * @brief Set a choice value of a list box or combo box. 
 * @details This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the choice to be set. If aIndex equals the current number of choice, the value will be added. 
 * @param[in] aEncoding The encoding of aValue and aExport. 
 * @param[in] aValue The choice value to be set. Complex scripts are supported, see signdocshared_complex_scripts. 
 * @param[in] aExport The export value to be set.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setChoice_with_export(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aValue, const char * aExport);

/**
 * @brief Remove a choice from a list box or combo box. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the choice to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeChoice(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the type of the field. 
 * @details The default value is t_unknown.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The type of the field.

 */
int  SDCAPI SIGNDOC_Field_getType(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the type of the field. 
 * @details The default value is t_unknown.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aType The type of the field.

 */
void  SDCAPI SIGNDOC_Field_setType(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aType);

/**
 * @brief Get the flags of the field, see enum Flag. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The flags of the field.

 */
int  SDCAPI SIGNDOC_Field_getFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the flags of the field, see enum Flag. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFlags The flags of the field.

 */
void  SDCAPI SIGNDOC_Field_setFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aFlags);

/**
 * @brief Check if this signature field is currently clearable. 
 * @details For some document formats (TIFF), signatures may only be cleared in the reverse order of signing (LIFO). Use this function to find out whether the signature field is currently clearable (as determined by SignDocDocument::getField() or SignDocDocument::getFields(),
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return true iff this is a signature field that can be cleared now.

 */
int  SDCAPI SIGNDOC_Field_isCurrentlyClearable(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get maximum length of text field. 
 * @details The default value is -1.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The maximum length of text fields or -1 if the field is not a text field or if the text field does not have a maximum length.

 */
int  SDCAPI SIGNDOC_Field_getMaxLen(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set maximum length of text fields. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aMaxLen The maximum length (in characters) of the text field or -1 for no maximum length.

 */
void  SDCAPI SIGNDOC_Field_setMaxLen(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aMaxLen);

/**
 * @brief Get the index of the choice to be displayed in the first line of a list box. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The index of the choice to be displayed in the first line of a list box or 0 for other field types.

 */
int  SDCAPI SIGNDOC_Field_getTopIndex(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the index of the choice to be displayed in the first line of a list box. 
 * @details This value is ignored for other field types.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTopIndex The index of the choice to be displayed in the first line of a list box.

 */
void  SDCAPI SIGNDOC_Field_setTopIndex(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aTopIndex);

/**
 * @brief Get the index of the currently selected widget. 
 * @details Initially, the first widget is selected (ie, this function returns 0). However, there is an exception to this rule: SignDocField objects created by SignDocDocument::getFieldsOfPage() can have a different widget selected initially for PDF documents.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The 0-based index of the currently selected widget.

 */
int  SDCAPI SIGNDOC_Field_getWidget(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the number of widgets. 
 * @details Signature fields always have exactly one widget. Radio button fields (radio button groups) usually have one widget per button (but can have more widgets than buttons by having multiple widgets for some or all buttons).
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The number of widgets for this field. 

 */
int  SDCAPI SIGNDOC_Field_getWidgetCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Select a widget. 
 * @details This function selects the widget to be used by getWidgetFlags(), getPage(), getLeft(), getBottom(), getRight(), getTop(), getButtonValue(), getJustification(), getRotation(), getTextFieldAttributes(), setWidgetFlags(), setPage(), setLeft(), setBottom(), setRight(), setTop(), setButtonValue(), setJustification(), setRotation(), and setTextFieldAttributes().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the widget.
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_selectWidget(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Add a widget to the field. 
 * @details The new widget will be added at the end, ie, calling getWidgetCount()before calling addWidget() yields the index of the widget that will be added.
After adding a widget, the new widget will be selected. You must set the page number and the coordinates in the new widget before calling SignDocDocument::addField() or SignDocDocument::setField().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_addWidget(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a widget to the field in front of another widget. 
 * @details The new widget will be inserted at the specified index, ie, the index of the new widget will be aIndex.
After adding a widget, the new widget will be selected. You must set the page number and the coordinates in the new widget before calling SignDocDocument::addField() or SignDocDocument::setField().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the widget in front of which the new widget shall be inserted. You can pass the current number of widgets as returned by getWidgetCount() to add the new widget to the end as addWidget() does.
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_insertWidget(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Remove a widget from the field. 
 * @details This function fails when there is only one widget. That is, a field always has at least one widget.
If the currently selected widget is removed, the following rules apply:When removing the last widget (the one with index getWidgetCount()-1), the predecessor of the removed widget will be selected.Otherwise, the index of the selected widget won't change, ie, the successor of the removed widget will be selected.
If the widget to be removed is not selected, the currently selected widget will remain selected.
All widgets having an index greater than aIndex will have their index decremented by one.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the widget to remove.
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_removeWidget(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the annotation flags of the widget, see enum WidgetFlag. 
 * @details The default value is wf_Print. The annotation flags are used for PDF documents only. Currently, the semantics of the annotation flags are ignored by this software (ie, the flags are stored in the document, but they don't have any meaning to this software).
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The annotation flags of the widget.

 */
int  SDCAPI SIGNDOC_Field_getWidgetFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the annotation flags of the widget, see enum WidgetFlag. 
 * @details The default value is wf_Print. The annotation flags are used for PDF documents only. Currently, the semantics of the annotation flags are ignored by this software (ie, the flags are stored in the document, but they don't have any meaning to this software).
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFlags The annotation flags of the widget.

 */
void  SDCAPI SIGNDOC_Field_setWidgetFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aFlags);

/**
 * @brief Get the page number. 
 * @details This function returns the index of the page on which this field occurs (1 for the first page), or 0 if the page number is unknown.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The 1-based page number or 0 if the page number is unknown.

 */
int  SDCAPI SIGNDOC_Field_getPage(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the page number. 
 * @details This function sets the index of the page on which this field occurs (1 for the first page).
By calling SignDocDocument::getField(), setPage(), and SignDocDocument::setField(), you can move a field's widget to another page but be careful because the two pages may have different conversion factors, see SignDocDocument::getConversionFactors().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The 1-based page number of the field.

 */
void  SDCAPI SIGNDOC_Field_setPage(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aPage);

/**
 * @brief Get the left coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The left coordinate.

 */
double  SDCAPI SIGNDOC_Field_getLeft(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the left coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aLeft The left coordinate.

 */
void  SDCAPI SIGNDOC_Field_setLeft(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, double aLeft);

/**
 * @brief Get the bottom coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The bottom coordinate.

 */
double  SDCAPI SIGNDOC_Field_getBottom(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the bottom coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aBottom The bottom coordinate.

 */
void  SDCAPI SIGNDOC_Field_setBottom(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, double aBottom);

/**
 * @brief Get the right coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates. If coordinates are given in pixels (this is true for TIFF documents), this coordinate is exclusive.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The right coordinate.

 */
double  SDCAPI SIGNDOC_Field_getRight(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the right coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates. If coordinates are given in pixels (this is true for TIFF documents), this coordinate is exclusive.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRight The right coordinate.

 */
void  SDCAPI SIGNDOC_Field_setRight(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, double aRight);

/**
 * @brief Get the top coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates. If coordinates are given in pixels (this is true for TIFF documents), this coordinate is exclusive.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The top coordinate.

 */
double  SDCAPI SIGNDOC_Field_getTop(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the top coordinate. 
 * @details The origin is in the bottom left corner of the page, see signdocshared_coordinates. If coordinates are given in pixels (this is true for TIFF documents), this coordinate is exclusive.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTop The top coordinate.

 */
void  SDCAPI SIGNDOC_Field_setTop(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, double aTop);

/**
 * @brief Get the button value of a widget of a radio button group or check box. 
 * @details Usually, different radio buttons (widgets) of a radio button group (field) have different values. The radio button group has a value (returned by getValue()) which is either "Off" or one of those values. The individual buttons (widgets) of a check box field can also have different export values.
Different radio buttons (widgets) of a radio button group (field) can have the same value; in that case, the radio buttons are linked. The individual buttons of a check box field also can have the same value.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The button value an empty string (for field types that don't use button values).

 */
char *  SDCAPI SIGNDOC_Field_getButtonValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the button value of a widget of a radio button group or check box. 
 * @details See getButtonValue() for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The button value an empty string (for field types that don't use button values). This pointer will become invalid when addWidget(), insertWidget(), removeWidget(), or setButtonValue() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getButtonValueUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief 
 * @details Set the button value of a widget of a radio button group or a check box.
Usually, different radio buttons (widgets) of a radio button group (field) have different values. The radio button group has a value (returned by getValue()) which is either "Off" or one of those values. The individual buttons (widgets) of a check box field can also have different export values.
Different radio buttons (widgets) of a radio button group (field) can have the same value; in that case, the radio buttons are linked. The individual buttons of a check box field also can have the same value.
SignDocDocument::addField() and SignDocDocument::setField() ignore the value set by this function if the field is neither a radio button group nor a check box field.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aValue. 
 * @param[in] aValue The value to be set. Must not be empty, must not be "Off".

 */
void  SDCAPI SIGNDOC_Field_setButtonValue(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aValue);

/**
 * @brief Get the justification of the widget. 
 * @details The default value is j_none.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The justification of the widget, j_none for non-text fields.

 */
int  SDCAPI SIGNDOC_Field_getJustification(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the justification of the widget. 
 * @details The default value is j_none.
The justification must be j_none for all field types except for text fields and list boxes.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aJustification The justification.

 */
void  SDCAPI SIGNDOC_Field_setJustification(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aJustification);

/**
 * @brief Get the rotation of the widget contents. 
 * @details The rotation is specified in degrees (counter-clockwise). The default value is 0.
For instance, if the rotation is 270, left-to right text will display top down.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The rotation of the widget: 0, 90, 180, or 270.

 */
int  SDCAPI SIGNDOC_Field_getRotation(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the rotation of the widget contents. 
 * @details The rotation is specified in degrees (counter-clockwise). The default value is 0.
For instance, if the rotation is 270, left-to right text will display top down.
Currently, the rotation must always be 0 for TIFF documents.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRotation The rotation: 0, 90, 180, or 270.

 */
void  SDCAPI SIGNDOC_Field_setRotation(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aRotation);

/**
 * @brief Get text field attributes. 
 * @details This function returns an empty string if the field uses the document's default font name for fields.
Text fields, signature fields, list boxes, and combo boxes can have text field attributes.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in,out] aOutput This object will be updated.
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_getTextFieldAttributes(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_TextFieldAttributes * aOutput);

/**
 * @brief Set text field attributes. 
 * @details Font name and font size must be specified. The text color is optional. This function fails if any of the attributes of aInput are invalid.
Text field attributes can be specified for text fields, signature fields, list boxes, and combo boxes.
If SignDocTextFieldAttributes::isSet() returns false for aInput, the text field attributes of the field will be removed by SignDocDocument::setField().
The following rules apply if the field does not have text field attributes:If the field inherits text field attributes from a ancestor field, those will be used by PDF processing software.Otherwise, if the document has specifies text field attributes (see SignDocDocument::getTextFieldAttributes()), those will be used by PDF processing software.Otherwise, the field is not valid.
To avoid having invalid fields, SignDocDocument::addField() and SignDocDocument::setField() will use text field attributes specifying Helvetica as the font and black for the text color if the field does not inherit text field attributes from an ancestor field or from the document.
This function always fails for TIFF documents.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return true iff successful.

 */
int  SDCAPI SIGNDOC_Field_setTextFieldAttributes(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_TextFieldAttributes * aInput);

/**
 * @brief Get the lock type. 
 * @details The lock type defines the fields to be locked when signing this signature field.
getLockFields(), setLockType()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getLockType(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the lock type. 
 * @details The lock type defines the fields to be locked when signing this signature field.
addLockField(), getLockType()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_setLockType(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aLockType);

/**
 * @brief Number of field names for lt_include and lt_exclude. 
 * @details addLockField(), clearLockFields(), getLockField(), getLockFieldUTF8(), removeLockField()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getLockFieldCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the name of a lock field. 
 * @details This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the lock field.
 * @return The name of the selected lock field or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getLockField(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get the name of a lock field. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the lock field.
 * @return The name of the selected lock field or an empty string if the index is out of range. This pointer will become invalid when addLockField(), clearLockFields(), removeLockField(), or setLockField() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getLockFieldUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Clear the lock fields. 
 * @details After calling this function, getLockFieldCount() will return 0.
addLockField(), getLockFieldCount(), removeLockField()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearLockFields(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a lock field to the field. 
 * @details This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the lock field to be added.

 */
void  SDCAPI SIGNDOC_Field_addLockField(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Set a lock field. 
 * @details This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the value to be set. If aIndex equals the current number of values, the value will be added. 
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the lock field to be set.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setLockField_by_index(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aName);

/**
 * @brief Set a lock field. 
 * @details Calling this function is equivalent to calling clearLockFields() and addLockField(), but the encoding of aName is checked before modifying this object.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the lock field to be set.

 */
void  SDCAPI SIGNDOC_Field_setLockField(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Remove a lock field. 
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the lock field to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeLockField(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the certificate seed value dictionary flags (/SV/Cert/Ff) of a signature field, see enum CertSeedValueFlag. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The certificate seed value dictionary flags of the field.

 */
unsigned  SDCAPI SIGNDOC_Field_getCertSeedValueFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the certificate seed value dictionary flags (/SV/Cert/Ff) of a signature field, see enum CertSeedValueFlag. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFlags The certificate seed value dicitionary flags of the field.

 */
void  SDCAPI SIGNDOC_Field_setCertSeedValueFlags(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, unsigned aFlags);

/**
 * @brief Number of subject distinguished names in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(), getCertSeedValueSubjectDN(), getCertSeedValueSubjectDNUTF8(), removeCertSeedValueSubjectDN()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValueSubjectDNCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get a subject distinguished name from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the subject distinguished name.
 * @return The selected subject distinguished name (formatted according to RFC 4514) or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getCertSeedValueSubjectDN(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get a subject distinguished name from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the subject distinguished name.
 * @return The selected subject distinguished name (formatted according to RFC 4514) or an empty string if the index is out of range. This pointer will become invalid when addCertSeedValueSubjectDN(), clearCertSeedValueSubjectDNs(), removeCertSeedValueSubjectDN(), or setCertSeedValueSubjectDN() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getCertSeedValueSubjectDNUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Remove all subject distinguished names from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
After calling this function, getCertSeedValueSubjectDNCount() will return 0.
addCertSeedValueSubjectDN(), getCertSeedValueSubjectDNCount(), removeCertSeedValueSubjectDN()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearCertSeedValueSubjectDNs(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a subject distinguished name to the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The subject distinguished name formatted according to RFC 4514.
 * @return true if successful, false if aName cannot be parsed.

 */
int  SDCAPI SIGNDOC_Field_addCertSeedValueSubjectDN(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Set a subject distinguished name in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the value to be set. If aIndex equals the current number of values, the value will be added. 
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The subject distinguished name formatted according to RFC 4514.
 * @return true if successful, false if aIndex is out of range or if aName cannot be parsed.

 */
int  SDCAPI SIGNDOC_Field_setCertSeedValueSubjectDN_by_index(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aName);

/**
 * @brief Set a subject distinguished name in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
Calling this function is equivalent to calling clearCertSeedValueSubjectDNs() and addCertSeedValueSubjectDN(), but the encoding of aName is checked before modifying this object.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The subject distinguished name formatted according to RFC 4514.
 * @return true if successful, false if aName cannot be parsed.

 */
int  SDCAPI SIGNDOC_Field_setCertSeedValueSubjectDN(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Remove a subject distinguished name from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the subject distinguished name to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeCertSeedValueSubjectDN(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Number of subject certificates in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
addCertSeedValueSubjectCertificate(), clearCertSeedValueSubjectCertificates(), getCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateUTF8(), removeCertSeedValueSubjectCertificate()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValueSubjectCertificateCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get a subject certificate of the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the subject certificate. 
 * @param[out] aOutput The DER-encoded certificate will be stored here.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValueSubjectCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Remove all subject certificates from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
After calling this function, getCertSeedValueSubjectCertificateCount() will return 0.
addCertSeedValueSubjectCertificate(), getCertSeedValueSubjectCertificateCount(), removeCertSeedValueSubjectCertificate()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearCertSeedValueSubjectCertificates(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a subject certificate to the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.

 */
void  SDCAPI SIGNDOC_Field_addCertSeedValueSubjectCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const void * aPtr, size_t aSize);

/**
 * @brief Set a subject certificate in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the subject certificate to be set. If aIndex equals the current number of values, the certificate will be added. 
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setCertSeedValueSubjectCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, const void * aPtr, size_t aSize);

/**
 * @brief Set a subject certificate in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
Calling this function is equivalent to calling clearCertSeedValueSubjectCertificates() and addCertSeedValueSubjectCertificate().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.

 */
void  SDCAPI SIGNDOC_Field_setCertSeedValueSubjectCertificate_at(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const void * aPtr, size_t aSize);

/**
 * @brief Remove a subject certificate from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the subject certificate to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeCertSeedValueSubjectCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Number of issuer certificates in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
addCertSeedValueIssuerCertificate(), clearCertSeedValueIssuerCertificates(), getCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateUTF8(), removeCertSeedValueIssuerCertificate()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValueIssuerCertificateCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get a issuer certificate of the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the issuer certificate. 
 * @param[out] aOutput The DER-encoded certificate will be stored here.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValueIssuerCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Remove all issuer certificates from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
After calling this function, getCertSeedValueIssuerCertificateCount() will return 0.
addCertSeedValueIssuerCertificate(), getCertSeedValueIssuerCertificateCount(), removeCertSeedValueIssuerCertificate()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearCertSeedValueIssuerCertificates(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a issuer certificate to the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.

 */
void  SDCAPI SIGNDOC_Field_addCertSeedValueIssuerCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const void * aPtr, size_t aSize);

/**
 * @brief Set a issuer certificate in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the issuer certificate to be set. If aIndex equals the current number of values, the certificate will be added. 
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setCertSeedValueIssuerCertificate_at(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, const void * aPtr, size_t aSize);

/**
 * @brief Set a issuer certificate in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
Calling this function is equivalent to calling clearCertSeedValueIssuerCertificates() and addCertSeedValueIssuerCertificate().
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPtr Pointer to the first octet of the DER-encoded certificate. 
 * @param[in] aSize Size in octets of the DER-encoded certificate.

 */
void  SDCAPI SIGNDOC_Field_setCertSeedValueIssuerCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const void * aPtr, size_t aSize);

/**
 * @brief Remove a issuer certificate from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the issuer certificate to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeCertSeedValueIssuerCertificate(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Number of policy OIDs in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
addCertSeedValuePolicy(), clearCertSeedValuePolicies(), getCertSeedValuePolicy(), getCertSeedValuePolicyUTF8(), removeCertSeedValuePolicy()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
int  SDCAPI SIGNDOC_Field_getCertSeedValuePolicyCount(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get a policy OID from the certificate seed value dictionary. 
 * @details This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value. 
 * @param[in] aIndex 0-based index of the policy OID.
 * @return The selected policy OID or an empty string if the index is out of range.

 */
char *  SDCAPI SIGNDOC_Field_getCertSeedValuePolicy(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, int aIndex);

/**
 * @brief Get a policy OID from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex 0-based index of the policy OID.
 * @return The selected policy OID or an empty string if the index is out of range. This pointer will become invalid when addCertSeedValuePolicy(), clearCertSeedValuePolicies(), removeCertSeedValuePolicy(), or setCertSeedValuePolicy() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Field_getCertSeedValuePolicyUTF8(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Remove all policy OIDs from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
After calling this function, getCertSeedValuePolicyCount() will return 0.
addCertSeedValuePolicy(), getCertSeedValuePolicyCount(), removeCertSeedValuePolicy()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_clearCertSeedValuePolicies(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Add a policy OID to the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aOID. 
 * @param[in] aOID The policy OID.

 */
void  SDCAPI SIGNDOC_Field_addCertSeedValuePolicy(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aOID);

/**
 * @brief Set a policy OID in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the value to be set. If aIndex equals the current number of values, the value will be added. 
 * @param[in] aEncoding The encoding of aOID. 
 * @param[in] aOID The policy OID.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_setCertSeedValuePolicy_by_index(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex, int aEncoding, const char * aOID);

/**
 * @brief Set a policy OID in the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
Calling this function is equivalent to calling clearCertSeedValuePolicies() and addCertSeedValuePolicy(), but the encoding of aOID is checked before modifying this object.
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aOID. 
 * @param[in] aOID The policy OID.

 */
void  SDCAPI SIGNDOC_Field_setCertSeedValuePolicy(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aOID);

/**
 * @brief Remove a policy OID from the certificate seed value dictionary. 
 * @details See the PDF Reference for details.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIndex The 0-based index of the policy OID to be removed.
 * @return true if successful, false if aIndex is out of range.

 */
int  SDCAPI SIGNDOC_Field_removeCertSeedValuePolicy(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aIndex);

/**
 * @brief Get the URL of the RFC 3161 time-stamp server from the signature field seed value dictionary. 
 * @details This function throws de::softpro::spooc::EncodingError if the value cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The URL of the time-stamp server or an empty string if no time-stamp server is defined.

 */
char *  SDCAPI SIGNDOC_Field_getSeedValueTimeStampServerURL(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief This function gets a flag from the signature field seed value dictionary that indicates whether a time stamp is required or not for the signature. 
 * @details If this function returns true, the URL returned by getSeedValueTimeStampServerURL() will be used to add a time stamp to the signature when signing.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return false if a time stamp is not required, true if a time stamp is required.

 */
int  SDCAPI SIGNDOC_Field_getSeedValueTimeStampRequired(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the URL of an RFC 3161 time-stamp server in the signature field seed value dictionary. 
 * @details This function throws de::softpro::spooc::EncodingError if the name is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aURL. 
 * @param[in] aURL The URL (must be ASCII), empty for no time-stamp server. Must be non-empty if aRequired is true. The scheme must be http or https. 
 * @param[in] aRequired true if a time stamp is required, false if a time stamp is not required.
 * @return true if successful, false if aURL is invalid.

 */
int  SDCAPI SIGNDOC_Field_setSeedValueTimeStamp(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aURL, int aRequired);

/**
 * @brief Get color used for empty signature field in TIFF document. 
 * @details The default value is white.
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The color used for empty signature field in TIFF document. The return value is not defined for other cases.

 */
struct SIGNDOC_RGBColor *  SDCAPI SIGNDOC_Field_getEmptyFieldColor(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set color used for empty signature field in TIFF document. 
 * @details The default value is white. For non-TIFF documents, the value set by this function is ignored. The value is also ignored if compatibility with version 1.12 and earlier is requested.
getEmptyFieldColor(), SignDocDocument::setCompatibility()
 * @memberof SIGNDOC_Field
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Field_setEmptyFieldColor(struct SIGNDOC_Field *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_RGBColor * aColor);
/**
 * @brief Default constructor
 * @param ex exception information, may be NULL
 * @return newly constructed object
 * @memberof SIGNDOC_FindTextPosition
 */
struct SIGNDOC_FindTextPosition * SDCAPI SIGNDOC_FindTextPosition_new(struct SIGNDOC_Exception *ex);
/**
 * @brief Default destructor
 * @param aObj object to be destroyed
 * @param ex exception information, may be NULL
 * @memberof SIGNDOC_FindTextPosition
 */
void SDCAPI SIGNDOC_FindTextPosition_delete(struct SIGNDOC_FindTextPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_FindTextPosition
 */
struct SIGNDOC_CharacterPosition * SDCAPI SIGNDOC_FindTextPosition_getFirst(struct SIGNDOC_FindTextPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_FindTextPosition
 */
void SDCAPI SIGNDOC_FindTextPosition_setFirst(struct SIGNDOC_FindTextPosition *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_CharacterPosition * aFirst);
/**
 * @memberof SIGNDOC_FindTextPosition
 */
struct SIGNDOC_CharacterPosition * SDCAPI SIGNDOC_FindTextPosition_getLast(struct SIGNDOC_FindTextPosition *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_FindTextPosition
 */
void SDCAPI SIGNDOC_FindTextPosition_setLast(struct SIGNDOC_FindTextPosition *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_CharacterPosition * aLast);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_GrayColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIntensity 0 (black) through 255 (maximum intensity). 

 */
struct SIGNDOC_GrayColor * SDCAPI SIGNDOC_GrayColor_new(struct SIGNDOC_Exception *ex, unsigned char aIntensity);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_GrayColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_GrayColor * SDCAPI SIGNDOC_GrayColor_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_GrayColor * aSource);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_GrayColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
void SDCAPI SIGNDOC_GrayColor_set(struct SIGNDOC_GrayColor *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_GrayColor * aSource);

/**
 * @brief Create a copy of this object. 
 * @memberof SIGNDOC_GrayColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Color *  SDCAPI SIGNDOC_GrayColor_clone(struct SIGNDOC_GrayColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @brief Default destructor
 * @param aObj object to be destroyed
 * @param ex exception information, may be NULL
 * @memberof SIGNDOC_GrayColor
 */
void SDCAPI SIGNDOC_GrayColor_delete(struct SIGNDOC_GrayColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_GrayColor
 */
unsigned char SDCAPI SIGNDOC_GrayColor_getIntensity(struct SIGNDOC_GrayColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_GrayColor
 */
void SDCAPI SIGNDOC_GrayColor_setIntensity(struct SIGNDOC_GrayColor *aObj, struct SIGNDOC_Exception *ex, unsigned char aIntensity);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Property * SDCAPI SIGNDOC_Property_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_Property * SDCAPI SIGNDOC_Property_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Property * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Property_delete(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_Property_set(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Property * aSource);

/**
 * @brief Efficiently swap this object with another one. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The other object. 

 */
void  SDCAPI SIGNDOC_Property_swap(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Property * aOther);

/**
 * @brief Get the name of the property. 
 * @details Property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
This function throws de::softpro::spooc::EncodingError if the name cannot be represented using the specified encoding.
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The name of the property.

 */
char *  SDCAPI SIGNDOC_Property_getName(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the name of the property as UTF-8-encoded C string. 
 * @details Property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished.
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The name of the property. This pointer will become invalid when setName() is called or this object is destroyed.

 */
const char *  SDCAPI SIGNDOC_Property_getNameUTF8(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the name of the property. 
 * @details Property names are compared under Unicode simple case folding, that is, lower case and upper case is not distinguished. The encoding is specified by aEncoding of SignDocDocument::getProperties().
This function throws de::softpro::spooc::EncodingError if the value is not correctly encoded according to the specified encoding.
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aName. 
 * @param[in] aName The name of the property.

 */
void  SDCAPI SIGNDOC_Property_setName(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName);

/**
 * @brief Get the type of the property. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The type of the property.

 */
int  SDCAPI SIGNDOC_Property_getType(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the type of the property. 
 * @memberof SIGNDOC_Property
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aType The type of the property.

 */
void  SDCAPI SIGNDOC_Property_setType(struct SIGNDOC_Property *aObj, struct SIGNDOC_Exception *ex, int aType);
/**
 * @brief Default constructor
 * @param ex exception information, may be NULL
 * @return newly constructed object
 * @memberof SIGNDOC_RenderOutput
 */
struct SIGNDOC_RenderOutput * SDCAPI SIGNDOC_RenderOutput_new(struct SIGNDOC_Exception *ex);
/**
 * @brief Default destructor
 * @param aObj object to be destroyed
 * @param ex exception information, may be NULL
 * @memberof SIGNDOC_RenderOutput
 */
void SDCAPI SIGNDOC_RenderOutput_delete(struct SIGNDOC_RenderOutput *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RenderOutput
 */
int SDCAPI SIGNDOC_RenderOutput_getWidth(struct SIGNDOC_RenderOutput *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RenderOutput
 */
void SDCAPI SIGNDOC_RenderOutput_setWidth(struct SIGNDOC_RenderOutput *aObj, struct SIGNDOC_Exception *ex, int aWidth);
/**
 * @memberof SIGNDOC_RenderOutput
 */
int SDCAPI SIGNDOC_RenderOutput_getHeight(struct SIGNDOC_RenderOutput *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RenderOutput
 */
void SDCAPI SIGNDOC_RenderOutput_setHeight(struct SIGNDOC_RenderOutput *aObj, struct SIGNDOC_Exception *ex, int aHeight);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_RenderParameters * SDCAPI SIGNDOC_RenderParameters_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_RenderParameters * SDCAPI SIGNDOC_RenderParameters_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_RenderParameters * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_RenderParameters_delete(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_RenderParameters_set(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_RenderParameters * aSource);

/**
 * @brief "Less than" operator. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The object to compare against. 

 */
int  SDCAPI SIGNDOC_RenderParameters_isLessThan(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_RenderParameters * aOther);

/**
 * @brief Select the page to be rendered. 
 * @details There is no initial value, ie, either this function or setPages() must be called.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The page number (1 for the first page).
 * @return true if successful, false if the page number is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setPage(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aPage);

/**
 * @brief Get the number of the selected page. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aPage The page number (1 for the first page) will be stored here.
 * @return true if successful, false if setPage() has not been called successfully or if multiple pages have been selected with setPages()

 */
int  SDCAPI SIGNDOC_RenderParameters_getPage(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aPage);

/**
 * @brief Select a range of pages to be rendered. 
 * @details There is no initial value, ie, either this function or setPage() must be called.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFirst The first page number of the range (1 for the first page of the document). 
 * @param[in] aLast The last page number of the range (1 for the first page of the document).
 * @return true if successful, false if the page numbers are invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setPages(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aFirst, int aLast);

/**
 * @brief Get the selected range of page numbers. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aFirst The first page number of the range (1 for the first page of the document) will be stored here. 
 * @param[out] aLast The last page number of the range (1 for the first page of the document) will be stored here.
 * @return true if successful, false if setPage() and setPages() have not been called.

 */
int  SDCAPI SIGNDOC_RenderParameters_getPages(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aFirst, int * aLast);

/**
 * @brief Set the resolution for rendering PDF documents. 
 * @details The values passed to this function will be ignored for TIFF documents as the resolution is computed automatically from the zoom factor and the document's resolution.
If this function is not called, 96 DPI (subject to change) will be used for rendering PDF documents.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aResX Horizontal resolution in DPI. 
 * @param[in] aResY Vertical resolution in DPI.
 * @return true if successful, false if the resolution is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setResolution(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, double aResX, double aResY);

/**
 * @brief Get the resolution set by setResolution(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aResX Horizontal resolution in DPI. 
 * @param[out] aResY Vertical resolution in DPI.
 * @return true if successful, false if setResolution() has not been called successfully.

 */
int  SDCAPI SIGNDOC_RenderParameters_getResolution(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, double * aResX, double * aResY);

/**
 * @brief Set the zoom factor for rendering. 
 * @details There is no initial value, ie, this function or fitWidth() or fitHeight() or fitRect() must be called. This function overrides fitWidth(), fitHeight(), and fitRect().
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aZoom The zoom factor.
 * @return true if successful, false if the zoom factor is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setZoom(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, double aZoom);

/**
 * @brief Get the zoom factor set by setZoom(). 
 * @details This function does not retrieve the zoom factor to be computed for fitWidth(), fitHeight(), and fitRect(). Use SignDocDocument::computeZoom() for that.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aZoom The zoom factor will be stored here.
 * @return true if successful, false if setZoom() has not been called successfully or has been overridden.

 */
int  SDCAPI SIGNDOC_RenderParameters_getZoom(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, double * aZoom);

/**
 * @brief Set the width for automatic computation of the zoom factor to make the rendered image fit the specified width. 
 * @details This function overrides the zoom factor set by fitHeight(), fitRect(), and setZoom().
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aWidth The desired width of the rendered image.
 * @return true if successful, false if the specified width is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_fitWidth(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aWidth);

/**
 * @brief Get the width set by fitWidth(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aWidth The width will be stored here.
 * @return true if successful, false if fitWidth() has not been called successfully or has been overridden.

 */
int  SDCAPI SIGNDOC_RenderParameters_getFitWidth(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aWidth);

/**
 * @brief Set the height for automatic computation of the zoom factor to make the rendered image fit the specified height. 
 * @details This function overrides the zoom factor set by fitWidth(), fitRect(), and setZoom().
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aHeight The desired height of the rendered image.
 * @return true if successful, false if the specified height is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_fitHeight(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aHeight);

/**
 * @brief Get the height set by fitHeight(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aHeight The height will be stored here.
 * @return true if successful, false if fitHeight() has not been called successfully or has been overridden.

 */
int  SDCAPI SIGNDOC_RenderParameters_getFitHeight(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aHeight);

/**
 * @brief Set the width and height for automatic computation of the zoom factor to make the rendered image fit the specified width and height. 
 * @details This function overrides the zoom factor set by fitWidth(), fitHeight(), and setZoom().
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aWidth The desired width of the rendered image. 
 * @param[in] aHeight The desired height of the rendered image.
 * @return true if successful, false if the specified width or height is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_fitRect(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aWidth, int aHeight);

/**
 * @brief Get the width and height set by fitRect(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aWidth The width will be stored here. 
 * @param[out] aHeight The height will be stored here.
 * @return true if successful, false if fitRect() has not been called successfully or has been overridden.

 */
int  SDCAPI SIGNDOC_RenderParameters_getFitRect(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aWidth, int * aHeight);

/**
 * @brief Set the image format. 
 * @details There is no initial value, ie, this function must be called if this object is to be used for SignDocDocument::renderPageAsImage(). The image format is ignored for SignDocDocument::renderPageAsSpoocImage() and SignDocDocument::renderPageAsSpoocImages().
Currently, this function does not check the image format.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFormat The desired format of the image ("jpg", "png", "tiff", "gif", or "bmp").
 * @return true if successful, false if the image format is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setFormat(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, const char * aFormat);

/**
 * @brief Get the image format. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aFormat The image format will be stored here.
 * @return true if successful, false if setFormat() has not been called successfully.

 */
int  SDCAPI SIGNDOC_RenderParameters_getFormat(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, char ** aFormat);

/**
 * @brief Set the interlacing method. 
 * @details Interlacing is used for progressive encoding. The initial value is i_off. The interlacing method is ignored for SignDocDocument::renderPageAsSpoocImage().
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aInterlacing The interlacing method.
 * @return true if successful, false if the interlacing mode is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setInterlacing(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aInterlacing);

/**
 * @brief Get the interlacing method. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aInterlacing The interlacing mode will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getInterlacing(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aInterlacing);

/**
 * @brief Set the desired quality. 
 * @details This setting affects scaling of pages of TIFF documents. The initial value is q_low.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aQuality The desired quality.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setQuality(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aQuality);

/**
 * @brief Get the desired quality. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aQuality The quality setting will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getQuality(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aQuality);

/**
 * @brief Set the pixel format. 
 * @details The initial value is pf_default.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPixelFormat The pixel format.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setPixelFormat(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aPixelFormat);

/**
 * @brief Get the pixel format. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aPixelFormat The pixel format will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getPixelFormat(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aPixelFormat);

/**
 * @brief Set the compression compression. 
 * @details The initial value is c_default.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aCompression The compression method.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setCompression(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aCompression);

/**
 * @brief Get the compression method. 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aCompression The compression method will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getCompression(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aCompression);

/**
 * @brief Set the certificate chain verification policy. 
 * @details The certificate chain verification policy is used by SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), and SignDocDocument::renderPageAsSpoocImages() if setDecorations(true) has been called
The default value is ccvp_accept_self_signed_with_rsa_bio. ccvp_require_trusted_root is not implemented for PKCS #1 signatures.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPolicy The certificate chain verification policy.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setCertificateChainVerificationPolicy(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aPolicy);

/**
 * @brief Get the certificate chain verification policy. 
 * @details See setCertificateChainVerificationPolicy() for details.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aPolicy The certificate chain verification policy will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getCertificateChainVerificationPolicy(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aPolicy);

/**
 * @brief Set the certificate revocation verification policy. 
 * @details The certificate revocation verification policy is used by SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), and SignDocDocument::renderPageAsSpoocImages() if setDecorations(true) has been called
The default value is crvp_dont_check. crvp_online and crvp_offline are not supported for PKCS #1 signatures.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPolicy The certificate revocation verification policy.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setCertificateRevocationVerificationPolicy(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aPolicy);

/**
 * @brief Get the certificate revocation verification policy. 
 * @details See setCertificateRevocationVerificationPolicy() for details.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aPolicy The certificate revocation verification policy will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getCertificateRevocationVerificationPolicy(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aPolicy);

/**
 * @brief Set the certificate verification model. 
 * @details The certificate verification model is used by SignDocDocument::renderPageAsImage(), SignDocDocument::renderPageAsSpoocImage(), and SignDocDocument::renderPageAsSpoocImages() if setDecorations(true) has been called
The default value is vm_windows.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aModel The certificate verification model.
 * @return true if successful, false if the argument is invalid.

 */
int  SDCAPI SIGNDOC_RenderParameters_setVerificationModel(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aModel);

/**
 * @brief Get the certificate verification model. 
 * @details See setVerificationModel() for details.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aModel The certificate verification model will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getVerificationModel(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aModel);

/**
 * @brief Enable rendering of decorations. 
 * @details The default value is false.
For PDF documents, pages may optionally be rendered with decorations: An icon visualizing the signature status will be added to each signature field:no icon (signature field not signed)green check mark (signature is OK)green check mark with yellow triangle (signature is OK but the certificate is not trusted or the document has been extended, ie, modified and saved incrementally after signing)red cross (signature broken)
For TIFF documents, this value is ignored; a red cross will be displayed in signature fields if the signature is broken.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aDecorations true to render decorations.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_setDecorations(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aDecorations);

/**
 * @brief Get the value set by setDecorations(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aDecorations The flag will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getDecorations(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aDecorations);

/**
 * @brief Enable rendering for printing. 
 * @details The default value is false (render for displaying).
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPrint true to render for printing, false to render for displaying.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_setPrint(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int aPrint);

/**
 * @brief Get the value set by setPrint(). 
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aPrint The flag will be stored here.
 * @return true if successful. This function never fails.

 */
int  SDCAPI SIGNDOC_RenderParameters_getPrint(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, int * aPrint);

/**
 * @brief Compare against another SignDocRenderParameters object. 
 * @details The exact order of SignDocRenderParameters is unspecified but consistent.
 * @memberof SIGNDOC_RenderParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The object to compare against.
 * @return -1 if this object compares smaller than aOther, 0 if this object compares equal to aOther, 1 if this object compares greater than aOther. 

 */
int  SDCAPI SIGNDOC_RenderParameters_compare(struct SIGNDOC_RenderParameters *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_RenderParameters * aOther);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_RGBColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRed Red component, 0 through 255 (maximum intensity). 
 * @param[in] aGreen Green component, 0 through 255 (maximum intensity). 
 * @param[in] aBlue Blue component, 0 through 255 (maximum intensity). 

 */
struct SIGNDOC_RGBColor * SDCAPI SIGNDOC_RGBColor_new_from_rgb(struct SIGNDOC_Exception *ex, unsigned char aRed, unsigned char aGreen, unsigned char aBlue);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_RGBColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_RGBColor * SDCAPI SIGNDOC_RGBColor_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_RGBColor * aSource);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_RGBColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
void SDCAPI SIGNDOC_RGBColor_set(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_RGBColor * aSource);

/**
 * @brief Create a copy of this object. 
 * @memberof SIGNDOC_RGBColor
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Color *  SDCAPI SIGNDOC_RGBColor_clone(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @brief Default destructor
 * @param aObj object to be destroyed
 * @param ex exception information, may be NULL
 * @memberof SIGNDOC_RGBColor
 */
void SDCAPI SIGNDOC_RGBColor_delete(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RGBColor
 */
unsigned char SDCAPI SIGNDOC_RGBColor_getRed(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RGBColor
 */
void SDCAPI SIGNDOC_RGBColor_setRed(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex, unsigned char aRed);
/**
 * @memberof SIGNDOC_RGBColor
 */
unsigned char SDCAPI SIGNDOC_RGBColor_getGreen(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RGBColor
 */
void SDCAPI SIGNDOC_RGBColor_setGreen(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex, unsigned char aGreen);
/**
 * @memberof SIGNDOC_RGBColor
 */
unsigned char SDCAPI SIGNDOC_RGBColor_getBlue(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex);
/**
 * @memberof SIGNDOC_RGBColor
 */
void SDCAPI SIGNDOC_RGBColor_setBlue(struct SIGNDOC_RGBColor *aObj, struct SIGNDOC_Exception *ex, unsigned char aBlue);

/**
 * @brief Destructor. 
 * @details Overwrites this object's copies of the private key and biometric data. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_SignatureParameters_delete(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the status of a parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive).
 * @return see enum ParameterState. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_getState(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName);

/**
 * @brief Set a string parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding used for aValue. 
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aValue The value of the parameter. The encoding is specified by aEncoding.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_setString_cset(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, const char * aValue);

/**
 * @brief Set a string parameter. 
 * @details See the other setString() function for a list of available string parameters.
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aValue The value of the parameter.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_setString(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName, const wchar_t * aValue);

/**
 * @brief Set an integer parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aValue The value of the parameter.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_SignatureParameters_setInteger(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName, int aValue);

/**
 * @brief Set a blob parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aData A pointer to the first octet of the value. 
 * @param[in] aSize Size of the blob (number of octets).
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_SignatureParameters_setBlob(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName, const unsigned char * aData, size_t aSize);

/**
 * @brief Set a length parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aType Define how the length is specified. 
 * @param[in] aValue The value of the parameter.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_setLength(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName, int aType, double aValue);

/**
 * @brief Set a color parameter. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aName The name of the parameter (case-sensitive). 
 * @param[in] aValue The value of the parameter.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_setColor(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, const char * aName, const struct SIGNDOC_Color * aValue);

/**
 * @brief Add another string to be displayed, top down. 
 * @details For DigSig signature fields, this function adds another string to the appearance stream of PDF documents. The first call clears any default strings. The default values depend on the profile passed to SignDocDocument::createSignatureParameters().
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aItem Select the string to be added. 
 * @param[in] aGroup The string's group for font size computation.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_addTextItem(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, int aItem, int aGroup);

/**
 * @brief Set an object which will create a PKCS #7 signature. 
 * @details By default, PKCS #7 signatures are handled internally which means that the private key must be available on this machine.
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPKCS7 The object that will create the PKCS #7 signature. This function does not take ownership of that object.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_SignatureParameters_setPKCS7(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, struct SignPKCS7 * aPKCS7);

/**
 * @brief Get a bitset indicating which signing methods are available for this signature field. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return 1<<m_signdoc etc.

 */
int  SDCAPI SIGNDOC_SignatureParameters_getAvailableMethods(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the error message.
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const char *  SDCAPI SIGNDOC_SignatureParameters_getErrorMessage(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_SignatureParameters
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const wchar_t *  SDCAPI SIGNDOC_SignatureParameters_getErrorMessageW(struct SIGNDOC_SignatureParameters *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_TextFieldAttributes * SDCAPI SIGNDOC_TextFieldAttributes_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_TextFieldAttributes * SDCAPI SIGNDOC_TextFieldAttributes_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_TextFieldAttributes * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_TextFieldAttributes_delete(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_TextFieldAttributes_set(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_TextFieldAttributes * aSource);

/**
 * @brief Efficiently swap this object with another one. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The other object. 

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_swap(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_TextFieldAttributes * aOther);

/**
 * @brief Check if text field attributes are set or not. 
 * @details If this function returns false for a SignDocTextFieldAttributes object retrieved from a text field, the document's default text field attributes will be used (if present).
This function returns false for all SignDocTextFieldAttributes objects retrieved from TIFF documents (but you can set the attributes anyway, making isSet() return true).
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return true if any attribute is set, false if no attributes are set.

 */
int  SDCAPI SIGNDOC_TextFieldAttributes_isSet(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Check if the text field attributes are valid. 
 * @details This function does not check if the font name refers to a valid font. This function does not check the string set by setRest().
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return true if isSet() would return false or if all attributes are set and are valid, false otherwise.

 */
int  SDCAPI SIGNDOC_TextFieldAttributes_isValid(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Unset all attributes. 
 * @details isSet() will return false. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_clear(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the name of the font. 
 * @details This function returns an empty string if isSet() would return false.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The name of the font.

 */
char *  SDCAPI SIGNDOC_TextFieldAttributes_getFontName(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Set the name of the font. 
 * @details The font name can be the name of a standard font, the name of an already embedded font, or the name of a font defined by a font configuration file.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFontName. 
 * @param[in] aFontName The new font name.

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_setFontName(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFontName);

/**
 * @brief Get the resource name of the font. 
 * @details This function returns an empty string if isSet() would return false.
Note that setting the resource name is not possible.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the return value.
 * @return The resource name of the font.

 */
char *  SDCAPI SIGNDOC_TextFieldAttributes_getFontResourceName(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get the font size. 
 * @details This function returns 0 if isSet() would return false.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return The font size (in user space units). If the font size is 0, the default font size (which depends on the field size) will be used.

 */
double  SDCAPI SIGNDOC_TextFieldAttributes_getFontSize(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the font size. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFontSize The font size (in user space units). If the font size is 0, the default font size (which depends on the field size) will be used.

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_setFontSize(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, double aFontSize);

/**
 * @brief Get the text color. 
 * @details This function returns NULL if isSet() would return false.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return A pointer to an object describing the text color or NULL if the text color is not available. The caller is responsible for destroying the object.

 */
struct SIGNDOC_Color *  SDCAPI SIGNDOC_TextFieldAttributes_getTextColor(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the text color. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTextColor The text color. 

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_setTextColor(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Color * aTextColor);

/**
 * @brief Get unparsed parts of default appearance string. 
 * @details If this function returns a non-empty string, there are unsupported operators in the default appearance string.
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return Concatenated unparsed parts of the default appearance string, ie, the default appearance string sans font name, font size, and text color. If this function returns a non-empty string, it will start with a space character.

 */
char *  SDCAPI SIGNDOC_TextFieldAttributes_getRest(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Set unparsed parts of default appearance string. 
 * @memberof SIGNDOC_TextFieldAttributes
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aInput. 
 * @param[in] aInput The new string of unparsed operators. If this string is non-empty and does not start with a space character, a space character will be prepended automatically. 

 */
void  SDCAPI SIGNDOC_TextFieldAttributes_setRest(struct SIGNDOC_TextFieldAttributes *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aInput);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_VerificationResult_delete(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Get the signature state. 
 * @details If the state is ss_unsupported_signature or ss_invalid_certificate, getErrorMessage() will provide additional information.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The signature state.
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_VerificationResult_getState(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get the signing method. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The signing method.
 * @return rc_ok if successful, rc_not_verified if verification has failed. 

 */
int  SDCAPI SIGNDOC_VerificationResult_getMethod(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get the message digest algorithm of the signature. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The message digest algorithm (such as "SHA-1") will be stored here. If the message digest algorithm is unsupported, an empty string will be stored.
 * @return rc_ok if successful, rc_not_verified if verification has failed. 

 */
int  SDCAPI SIGNDOC_VerificationResult_getDigestAlgorithm(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, char ** aOutput);

/**
 * @brief Get the certificates of the signature. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The ASN.1-encoded X.509 certificates will be stored here. If there are multiple certificates, the first one (at index 0) is the signing certificate.
 * @return rc_ok if successful, rc_not_verified if verification has failed. 

 */
int  SDCAPI SIGNDOC_VerificationResult_getCertificates(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_ByteArrayArray * aOutput);

/**
 * @brief Verify the certificate chain of the signature's certificate. 
 * @details Currently, this function supports PKCS #7 signatures only. getErrorMessage() will return an error message if this function fails (return value not rc_ok) or the verification result returned in aOutput is not ccs_ok.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aModel Model to be used for verification. 
 * @param[out] aOutput The result of the certificate chain verification.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyCertificateChain(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aModel, int * aOutput);

/**
 * @brief Check the revocation status of the certificate chain of the signature's certificate. 
 * @details verifyCertificateChain() or verifyCertificateSimplified() must have been called successfully.
Currently, this function supports PKCS #7 signatures only. getErrorMessage() will return an error message if this function fails (return value not rc_ok) or the verification result returned in aOutput is not crs_ok.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aModel Model to be used for verification. 
 * @param[out] aOutput The result of the certificate revocation check.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyCertificateRevocation(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aModel, int * aOutput);

/**
 * @brief Simplified verification of the certificate chain and revocation status of the signature's certificate. 
 * @details This function just returns a good / not good value according to policies defined by the arguments. It does not tell the caller what exactly is wrong. However, getErrorMessage() will return an error message if this function fails. Do not attempt to base decisions on that error message, please use verifyCertificateChain() and verifyCertificateRevocation() instead of this function if you need details about the failure.
If aChainPolicy is ccvp_dont_verify, aRevocationPolicy must be crvp_dont_check, otherwise this function will return rc_invalid_argument.
Currently, only self-signed certificates are supported for PKCS #1, therefore ccvp_require_trusted_root always makes this function fail for PKCS #1 signatures. crvp_online and crvp_offline also make this function fail for PKCS #1 signatures.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aChainPolicy Policy for verification of the certificate chain. 
 * @param[in] aRevocationPolicy Policy for verification of the revocation status of the certificates. 
 * @param[in] aModel Model to be used for verification.
 * @return rc_ok if successful, rc_not_verified if verification has failed, rc_invalid_argument if the arguments are invalid.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyCertificateSimplified(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aChainPolicy, int aRevocationPolicy, int aModel);

/**
 * @brief Get the certificate chain length. 
 * @details verifyCertificateChain() or verifyCertificateSimplified() must have been called successfully.
Currently, this function supports PKCS #7 signatures only.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The chain length will be stored here if this function is is successful. If the signature was performed with a self-signed certificate, the chain length will be 1.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_getCertificateChainLength(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Get a string parameter from the signature field. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for aOutput. 
 * @param[in] aName The name of the parameter. 
 * @param[out] aOutput The string retrieved from the signature field.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_getSignatureString(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aName, char ** aOutput);

/**
 * @brief Get the biometric data of the field. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aKeyPtr Pointer to the first octet of the key (must be NULL if aKeyPath is not NULL). 
 * @param[in] aKeySize Size of the key pointed to by aKeyPtr (must be 0 if aKeyPath is not NULL). 
 * @param[in] aKeyPath Pathname of the file containing the key (must be NULL if aKeyPtr is not NULL). 
 * @param[in] aPassphrase Passphrase for decrypting the key contained in the file named by aKeyPath. If this argument is NULL or points to the empty string, it will be assumed that the key file is not protected by a passphrase. aPassphrase is used only when reading the key from a file for SignDocSignatureParameters::be_rsa. The passphrase must contain ASCII characters only. 
 * @param[out] aOutput The decrypted biometric data will be stored here.
 * @return rc_ok if successful, rc_no_biometric_data if no biometric data is availabable.

 */
int  SDCAPI SIGNDOC_VerificationResult_getBiometricData(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, const unsigned char * aKeyPtr, size_t aKeySize, const wchar_t * aKeyPath, const char * aPassphrase, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Get the biometric data of the field. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of the string pointed to by aKeyPath. 
 * @param[in] aKeyPtr Pointer to the first octet of the key (must be NULL if aKeyPath is not NULL). 
 * @param[in] aKeySize Size of the key pointed to by aKeyPtr (must be 0 if aKeyPath is not NULL). 
 * @param[in] aKeyPath Pathname of the file containing the key (must be NULL if aKeyPtr is not NULL). 
 * @param[in] aPassphrase Passphrase for decrypting the key contained in the file named by aKeyPath. If this argument is NULL or points to the empty string, it will be assumed that the key file is not protected by a passphrase. aPassphrase is used only when reading the key from a file for SignDocSignatureParameters::be_rsa. The passphrase must contain ASCII characters only. 
 * @param[out] aOutput The decrypted biometric data will be stored here.
 * @return rc_ok if successful, rc_no_biometric_data if no biometric data is availabable.

 */
int  SDCAPI SIGNDOC_VerificationResult_getBiometricData_cset(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const unsigned char * aKeyPtr, size_t aKeySize, const char * aKeyPath, const char * aPassphrase, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Get the encrypted biometric data of the field. 
 * @details Use this function if you cannot use getBiometricData() for decrypting the biometric data (for instance, because the private key is stored in an HSM).
In the following description of the format of the encrypted data retrieved by this function, all numbers are stored in little-endian format (howver, RSA uses big-endian format):
4 octets: version number4 octets: number of following octets (hash and body)32 octets: SHA-256 hash of body (ie, of the octets which follow)body (format depends on version number)
If the version number is 1, the encryption method is be_rsa with a 2048-bit key and the body has this format:
32 octets: SHA-256 hash of unencrypted biometric data256 octets: AES-256 session key encrypted with 2048-bit RSA 2.0 (OAEP) with SHA-256rest: biometric data encrypted with AES-256 in CBC mode using padding as described in RFC 2246. The IV is zero (not a problem as the session key is random).
If the version number is 2, the body has this format:
4 octets: method (be_fixed, be_binary, be_passphrase)32 octets: IV32 octets: SHA-256 hash of unencrypted biometric datarest: biometric data encrypted with AES-256 in CBC mode using padding as described in RFC 2246.
If the version number is 3, the encryption method is be_rsa with a key longer than 2048 bits and the body has this format:
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The decrypted biometric data will be stored here. See above for the format.
 * @return rc_ok if successful, rc_no_biometric_data if no biometric data is availabable.

 */
int  SDCAPI SIGNDOC_VerificationResult_getEncryptedBiometricData(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_ByteArray * aOutput);

/**
 * @brief Get the encryption method used for biometric data of the signature field. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The encryption method.
 * @return rc_ok if successful, rc_no_biometric_data if no biometric data is availabable.

 */
int  SDCAPI SIGNDOC_VerificationResult_getBiometricEncryption(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Check the hash of the biometric data. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aBioPtr Pointer to unencrypted biometric data, typically retrieved by getBiometricData(). 
 * @param[in] aBioSize Size of unencrypted biometric data in octets. 
 * @param[out] aOutput Result of the operation: true if the hash is OK, false if the hash doesn't match (the document has been tampered with). 

 */
int  SDCAPI SIGNDOC_VerificationResult_checkBiometricHash(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, const unsigned char * aBioPtr, size_t aBioSize, int * aOutput);

/**
 * @brief Get the state of the RFC 3161 time stamp. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The state of the RFC 3161 time stamp.
 * @return rc_ok if successful. 

 */
int  SDCAPI SIGNDOC_VerificationResult_getTimeStampState(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int * aOutput);

/**
 * @brief Verify the certificate chain of the RFC 3161 time stamp. 
 * @details getErrorMessage() will return an error message if this function fails (return value not rc_ok) or the verification result returned in aOutput is not ccs_ok.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aModel Model to be used for verification. 
 * @param[out] aOutput The result of the certificate chain verification.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyTimeStampCertificateChain(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aModel, int * aOutput);

/**
 * @brief Check the revocation status of the certificate chain of the RFC 3161 time stamp. 
 * @details getErrorMessage() will return an error message if this function fails (return value not rc_ok) or the verification result returned in aOutput is not crs_ok.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aModel Model to be used for verification. 
 * @param[out] aOutput The result of the certificate revocation check.
 * @return rc_ok if successful, rc_not_verified if verification has failed.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyTimeStampCertificateRevocation(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aModel, int * aOutput);

/**
 * @brief Simplified verification of the certificate chain and revocation status of the RFC 3161 time stamp. 
 * @details This function just returns a good / not good value according to policies defined by the arguments. It does not tell the caller what exactly is wrong. However, getErrorMessage() will return an error message if this function fails. Do not attempt to base decisions on that error message, please use verifyTimeStampCertificateChain() and verifyTimeStampCertificateRevocation() instead of this function if you need details about the failure.
If aChainPolicy is ccvp_dont_verify, aRevocationPolicy must be crvp_dont_check, otherwise this function will return rc_invalid_argument.
ccvp_accept_self_signed_with_bio and ccvp_accept_self_signed_with_rsa_bio are treated like ccvp_accept_self_signed.
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aChainPolicy Policy for verification of the certificate chain. 
 * @param[in] aRevocationPolicy Policy for verification of the revocation status of the certificates. 
 * @param[in] aModel Model to be used for verification.
 * @return rc_ok if successful, rc_not_verified if verification has failed, rc_invalid_argument if the arguments are invalid, rc_not_supported if there is no RFC 3161 time stamp.

 */
int  SDCAPI SIGNDOC_VerificationResult_verifyTimeStampCertificateSimplified(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aChainPolicy, int aRevocationPolicy, int aModel);

/**
 * @brief Get the value of the RFC 3161 time stamp. 
 * @details You must call verifyTimeStampCertificateChain() and verifyTimeStampCertificateRevocation() to find out whether the time stamp can be trusted. If either of these functions report a problem, the time stamp should not be displayed.
A signature has either an RFC 3161 time stamp (returned by this function) or a time stamp stored as string parameter (returned by getSignatureString().
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The RFC 3161 time stamp in ISO 8601 format: "yyyy-mm-ddThh:mm:ssZ" (without milliseconds).
 * @return rc_ok if successful.

 */
int  SDCAPI SIGNDOC_VerificationResult_getTimeStamp(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, char ** aOutput);

/**
 * @brief Get the certificates of the RFC 3161 time stamp. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[out] aOutput The ASN.1-encoded X.509 certificates will be stored here. If there are multiple certificates, the first one (at index 0) is the signing certificate.
 * @return rc_ok if successful, rc_not_verified if verification has failed. 

 */
int  SDCAPI SIGNDOC_VerificationResult_getTimeStampCertificates(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_ByteArrayArray * aOutput);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding to be used for the error message.
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const char *  SDCAPI SIGNDOC_VerificationResult_getErrorMessage(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex, int aEncoding);

/**
 * @brief Get an error message for the last function call. 
 * @memberof SIGNDOC_VerificationResult
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @return A pointer to a string describing the reason for the failure of the last function call. The string is empty if the last call succeeded. The pointer is valid until this object is destroyed or a member function of this object is called.

 */
const wchar_t *  SDCAPI SIGNDOC_VerificationResult_getErrorMessageW(struct SIGNDOC_VerificationResult *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Constructor. 
 * @details All parameters are set to their default values. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
struct SIGNDOC_Watermark * SDCAPI SIGNDOC_Watermark_new(struct SIGNDOC_Exception *ex);

/**
 * @brief Copy constructor. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The object to be copied. 

 */
struct SIGNDOC_Watermark * SDCAPI SIGNDOC_Watermark_dup(struct SIGNDOC_Exception *ex, const struct SIGNDOC_Watermark * aSource);

/**
 * @brief Destructor. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void SDCAPI SIGNDOC_Watermark_delete(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Assignment operator. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aSource The source object. 

 */
void SDCAPI SIGNDOC_Watermark_set(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Watermark * aSource);

/**
 * @brief Efficiently swap this object with another one. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOther The other object. 

 */
void  SDCAPI SIGNDOC_Watermark_swap(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, struct SIGNDOC_Watermark * aOther);

/**
 * @brief Reset all parameters to their default values. 
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL

 */
void  SDCAPI SIGNDOC_Watermark_clear(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex);

/**
 * @brief Set the text to be used for the watermark. 
 * @details The default value is empty.
The text can contain multiple lines, the newline character is used to separate lines. If there are multiple lines, their relative position is specified by setJustification().
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aText. 
 * @param[in] aText The text. Complex scripts are supported, see signdocshared_complex_scripts.

 */
void  SDCAPI SIGNDOC_Watermark_setText(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aText);

/**
 * @brief Set the name of the font. 
 * @details The font name can be the name of a standard font, the name of an already embedded font, or the name of a font defined by a font configuration file.
The default value is "Helvetica".
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aEncoding The encoding of aFontName. 
 * @param[in] aFontName The new font name.

 */
void  SDCAPI SIGNDOC_Watermark_setFontName(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aEncoding, const char * aFontName);

/**
 * @brief Set the font size. 
 * @details The default value is 24.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aFontSize The font size (in user space units).

 */
void  SDCAPI SIGNDOC_Watermark_setFontSize(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, double aFontSize);

/**
 * @brief Set the text color. 
 * @details The default value is SignDocGrayColor(0) (black).
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aTextColor The text color. 

 */
void  SDCAPI SIGNDOC_Watermark_setTextColor(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, const struct SIGNDOC_Color * aTextColor);

/**
 * @brief Set the justification for multi-line text. 
 * @details The default value is j_left.
If the text (see setText()) contains only one line (ie, no newline characters), this parameter will be ignored.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aJustification The justification.

 */
void  SDCAPI SIGNDOC_Watermark_setJustification(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aJustification);

/**
 * @brief Set the rotation. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aRotation The rotation in degrees (-180 through 180), 0 is horizontal (left to right), 45 is bottom left to upper right. 

 */
void  SDCAPI SIGNDOC_Watermark_setRotation(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, double aRotation);

/**
 * @brief Set the opacity. 
 * @details The default value is 1.0. Documents conforming to PDF/A must use an opacity of 1.0.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aOpacity The opacity, 0.0 (transparent) through 1.0 (opaque).

 */
void  SDCAPI SIGNDOC_Watermark_setOpacity(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, double aOpacity);

/**
 * @brief Disable scaling or set scaling relative to page. 
 * @details The default value is 0.5.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aScale 0 to disable scaling (use the font size set by setFontSize()) or 0.01 through 64.0 to scale relative to the page size. 

 */
void  SDCAPI SIGNDOC_Watermark_setScale(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, double aScale);

/**
 * @brief Set whether the watermark will appear behind the page or on top of the page. 
 * @details The default value is l_overlay.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aLocation l_overlay or l_underlay.

 */
void  SDCAPI SIGNDOC_Watermark_setLocation(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aLocation);

/**
 * @brief Set the horizontal position of the watermark. 
 * @details The default values are ha_center and 0.
The distance is measured from the left edge of the page to the left edge of the watermark (ha_left), from the center of the page to the center of the watermark (ha_center), or from the right edge of the page to the right edge of the watermark.
For ha_left and ha_center, positive values push the watermark to the right, for ha_right, positive values push the watermark to the left.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aAlignment Measure distance from here. 
 * @param[in] aDistance The distance in user space units.

 */
void  SDCAPI SIGNDOC_Watermark_setHorizontalPosition(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aAlignment, double aDistance);

/**
 * @brief Set the vertical position of the watermark. 
 * @details The default values are va_center and 0.
The distance is measured from the top edge of the page to the top edge of the watermark (va_top), from the center of the page to the center of the watermark (va_center), or from the bottom edge of the page to the bottom edge of the watermark.
For va_bottom and va_center, positive values push the watermark up, for va_top, positive values push the watermark down.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aAlignment Measure distance from here. 
 * @param[in] aDistance The distance in user space units.

 */
void  SDCAPI SIGNDOC_Watermark_setVerticalPosition(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aAlignment, double aDistance);

/**
 * @brief Set the first page number. 
 * @details The default value is 1.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The 1-based page number of the first page.

 */
void  SDCAPI SIGNDOC_Watermark_setFirstPage(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aPage);

/**
 * @brief Set the last page number. 
 * @details The default value is 0.
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aPage The 1-based page number of the last page or 0 for the last page of the document.

 */
void  SDCAPI SIGNDOC_Watermark_setLastPage(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aPage);

/**
 * @brief Set the page number increment. 
 * @details The default value is 1 (add watermark to all pages between the first page and the last page)
 * @memberof SIGNDOC_Watermark
 * @param[in] aObj object to operate on
 * @param[in,out] ex exception information, may be NULL
 * @param[in] aIncr Add this number to the page number when iterating over pages adding watermarks. Must be positive.

 */
void  SDCAPI SIGNDOC_Watermark_setPageIncrement(struct SIGNDOC_Watermark *aObj, struct SIGNDOC_Exception *ex, int aIncr);

/**
 * @brief Creates a new PDF document handler
 * @returns PDF document handler
 * @memberof SIGNDOC_PdfDocumentHandler
 */
struct SIGNDOC_DocumentHandler * SDCAPI SIGNDOC_PdfDocumentHandler_new (struct SIGNDOC_Exception *ex);

/**
 * @brief Creates a new TIFF document handler
 * @returns TIFF document handler
 * @memberof SIGNDOC_TiffDocumentHandler
 */
struct SIGNDOC_DocumentHandler * SDCAPI SIGNDOC_TiffDocumentHandler_new (struct SIGNDOC_Exception *ex);

#ifdef __cplusplus
  } // extern "C"
#endif
	