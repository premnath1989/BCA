/*==============================================================*
 * SOFTPRO SignWare                                             *
 * ADSV developer Toolkit                                       *
 * Module: SPFlatFile.h                                         *
 * Created by: uko                                              *
 * Version: $Name: RST#SignWare#core#REL-3-0-1-2 $                                            *
 *                                                              *
 * @(#)SPFlatFile.h                            1.00 02/06/04    *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
 * Wilhelmstrasse 34, D-71034 Böblingen                         *
 * All rights reserved.                                         *
 *                                                              *
 * This software is the confidential and proprietary            *
 * information of SOFTPRO ("Confidential Information"). You     *
 * shall not disclose such Confidential Information and shall   *
 * use it only in accordance with the terms of the license      *
 * agreement you entered into with SOFTPRO.                     *
 *==============================================================*/
/**
 * @file SPFlatFile.h
 * @author uko
 * @version $Name: RST#SignWare#core#REL-3-0-1-2 $
 * @brief SignWare Dynamic Development toolkit, SPFlatFile object
 *
 * This header defines the SPFlatFile object.
 *
 * SPFlatFile objects are serialized SPReference, SPTemplate or SPSignature objects.
 * SPFlatFile objects include both static and dynamic signature features.
 *
 * In contrast, SPBitmap objects (see @ref SPBitmap.h) are serialized
 * SPImage objects. SPBitmap objects include static image features,
 * but no dynamic signature features.
 */

#ifndef SPFLATFILE_H__
#define SPFLATFILE_H__
#include "SPSignWare.h"

/*==============================================================*
 * Constant definitions                                         *
 *==============================================================*/

/*==============================================================*
 * Structures and type definitions                              *
 *==============================================================*/

/*==============================================================*
 * Function declarations                                        *
 *==============================================================*/
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */
/**
 * @brief Flat file format: SOFTPRO secure (encrypted) biometric signature / reference data.
 *
 * It is recommended to use the SOFTPRO flat file format to save signatures and
 * references and to convert to ISO/IEC 19794 format only when required as
 * the ISO formats don't store the tablet ID and the tablet serial ID.
 *
 * @see SPFlatFileCreateFromSignature, SPFlatFileCreateFromSignature2, SPFlatFileCreateFromReference, SPFlatFileCreateFromReference2
 * @see SP_FF_ISO_19794_MINIMUM, SP_FF_ISO_19794_SIMPLE, SP_FF_ISO_19794_COMPLEX
 */
#define SP_FF_SOFTPRO 0

/**
 * @brief Flat file format: ISO/IEC 19794-7  biometric signature data embedded
 *        in a CBEFF structure according to clause 8 of ISO 19785-3 ("minimum
 *        simple byte-oriented patron format").
 *
 * This format can be used for signatures only, but not for references and
 * templates.
 *
 * @note It is recommended to use the SOFTPRO flat file format to save
 * signatures and references and to convert to ISO/IEC 19794 format only when
 * required as this format does not store the tablet ID, the tablet serial ID,
 * and the timestamp.
 *
 * @see SPFlatFileCreateFromSignature2
 * @see SP_FF_SOFTPRO, SP_FF_ISO_19794_SIMPLE, SP_FF_ISO_19794_COMPLEX
 */
#define SP_FF_ISO_19794_MINIMUM 1

/**
 * @brief Flat file format: ISO/IEC 19794-7  biometric signature data embedded
 *        in a CBEFF structure according to clause 9 of ISO 19785-3
 *        ("fixed-length-fields, byte-oriented patron format using presence
 *        bitmap").
 *
 * This format can be used for signatures only, but not for references and
 * templates.
 *
 * @note It is recommended to use the SOFTPRO flat file format to save
 * signatures and references and to convert to ISO/IEC 19794 format only when
 * required as this format does not store the tablet ID and the tablet
 * serial ID.
 *
 * @see SPFlatFileCreateFromSignature2
 * @see SP_FF_SOFTPRO, SP_FF_ISO_19794_MINIMUM, SP_FF_ISO_19794_COMPLEX
 */
#define SP_FF_ISO_19794_SIMPLE 2

/**
 * @brief Flat file format: ISO/IEC 19794-7  biometric signature / reference
 *        data embedded in a CBEFF structure according to clause 12 of
 *        ISO 19785-3 ("complex patron format").
 *
 * This format can be used for signatures and references, but not for templates.
 *
 * @note It is recommended to use the SOFTPRO flat file format to save
 * signatures and references and to convert to ISO/IEC 19794 format only when
 * required as this format does not store the tablet ID and the tablet
 * serial ID.
 *
 * @see SPFlatFileCreateFromSignature2, SPFlatFileCreateFromReference2
 * @see SP_FF_SOFTPRO, SP_FF_ISO_19794_MINIMUM, SP_FF_ISO_19794_SIMPLE
 */
#define SP_FF_ISO_19794_COMPLEX 3

/**
 * @brief Create a flat file object in SP_FF_SOFTPRO format from a
 *        reference object.
 *
 * This function uses flat file format @ref SP_FF_SOFTPRO.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pReference [i]
 *      pointer to an SPReference object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @see SPFlatFileFree, SPFlatFileCreateFromReference2, SPFlatFileCreateFromSignature, SPFlatFileIsReferenceL, SPReferenceCreateFromFlatFile
 * @see SP_FF_SOFTPRO
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromReference(SPUCHAR * *ppbFlatFile, SPINT32 *piFlatFileLength, pSPREFERENCE_T pReference);

/**
 * @brief Create a flat file object from a reference object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pReference [i]
 *      pointer to an SPReference object.
 * @param iFormat [i]
 *      desired format of the flat file object to be created:
 *      - SP_FF_ISO_19794_COMPLEX  ISO/IEC 19794-7 biometric interchange data format
 *      - SP_FF_SOFTPRO secure (encrypted) biometric reference data format
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileFree, SPFlatFileCreateFromReference, SPFlatFileCreateFromSignature2, SPFlatFileIsReferenceL, SPReferenceCreateFromFlatFile
 * @see SP_FF_SOFTPRO, SP_FF_ISO_19794_COMPLEX
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromReference2(SPUCHAR * *ppbFlatFile, SPINT32 *piFlatFileLength, pSPREFERENCE_T pReference, SPINT32 iFormat);

/**
 * @brief Create a flat file object in SP_FF_SOFTPRO format from a
 *        signature object.
 *
 * This function uses flat file format @ref SP_FF_SOFTPRO.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pSignature [i]
 *      pointer to an SPSignature object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @see SPFlatFileFree, SPFlatFileCreateFromSignature2, SPFlatFileCreateFromReference, SPFlatFileIsSignatureL, SPSignatureCreateFromFlatFile
 * @see SP_FF_SOFTPRO
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromSignature(SPUCHAR * *ppbFlatFile, SPINT32 *piFlatFileLength, pSPSIGNATURE_T pSignature);

/**
 * @brief Create a flat file object from a signature object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pSignature [i]
 *      pointer to an SPSignature object.
 * @param iFormat [i]
 *      desired format of the flat file object to be created:
 *      - SP_FF_ISO_19794_MINIMUM  ISO/IEC 19794-7 biometric interchange data format
 *      - SP_FF_ISO_19794_SIMPLE   ISO/IEC 19794-7 biometric interchange data format
 *      - SP_FF_ISO_19794_COMPLEX  ISO/IEC 19794-7 biometric interchange data format
 *      - SP_FF_SOFTPRO secure (encrypted) biometric reference data format
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @see SPFlatFileFree, SPFlatFileCreateFromSignature, SPFlatFileCreateFromReference2, SPFlatFileIsSignatureL, SPSignatureCreateFromFlatFile
 * @see SP_FF_SOFTPRO, SP_FF_ISO_19794_MINIMUM, SP_FF_ISO_19794_SIMPLE, SP_FF_ISO_19794_COMPLEX
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromSignature2(SPUCHAR * *ppbFlatFile, SPINT32 *piFlatFileLength, pSPSIGNATURE_T pSignature, SPINT32 iFormat);

/**
 * @brief Create a flat file object from a template object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pTemplate [i]
 *      pointer to an SPTemplate object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileFree, SPFlatFileCreateFromReference, SPFlatFileCreateFromSignature, SPFlatFileIsTemplateL, SPTemplateCreateFromFlatFile
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromTemplate(SPUCHAR **ppbFlatFile, SPINT32 *piFlatFileLength, pSPTEMPLATE_T pTemplate);

/**
 * @brief Create a flat file object from an SPTicket object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pTicket [i]
 *      pointer to an SPTicket object.
 * @return @ref SP_NOERR on sucess, else error code:
 *      - @ref SP_LICENSEERR no license available
 *      - @ref SP_MEMERR out of memory
 *      - @ref SP_INTERR an internal error occured
 *      - @ref SP_PARAMERR invalid parameter
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileFree, SPFlatFileIsTicketL, SPTicketCreateFromFlatFile
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromTicket(SPUCHAR **ppbFlatFile, SPINT32 *piFlatFileLength, pSPTICKET_T pTicket);

/**
 * @brief Deallocate a flat file object.
 *
 * The flat file object must have been created by
 * @ref SPFlatFileCreateFromReference, @ref SPFlatFileCreateFromReference2,
 * @ref SPFlatFileCreateFromSignature, @ref SPFlatFileCreateFromSignature2,
 * @ref SPFlatFileCreateFromTemplate, @ref SPFlatFileCreateFromTicket,
 * or @ref SPFlatFileCreateFromCleanParameter.
 *
 * @param ppbFlatFile [io]
 *      pointer to a variable containing a pointer to an array of bytes
 *      containing a flat file.
 *      The variable will be set to NULL if this function succeeds.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPFlatFileFree(SPUCHAR **ppbFlatFile);

/**
 * @brief Check if a flat file object contains a template.
 *
 * @param pbFlatFile [i] pointer to a flat file object.
 * @return
 *  - 0: the flat file object does not contain a template
 *  - 1: the flat file object contains a template
 *  .
 * @deprecated Replaced by @ref SPFlatFileIsTemplateL.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsTemplate(const SPUCHAR *pbFlatFile);

/**
 * @brief Check if a flat file object contains a reference.
 *
 * @param pbFlatFile [i] pointer to a flat file object.
 * @return
 *  - 0: the flat file object does not contain a reference
 *  - 1: the flat file object contains a reference
 *  .
 * @deprecated Replaced by @ref SPFlatFileIsReferenceL.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsReference(const SPUCHAR *pbFlatFile);

/**
 * @brief Check if a flat file object contains a template.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *  - 0: the flat file object does not contain a template
 *  - 1: the flat file object contains a template
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromTemplate, SPFlatFileIsCleanParameterL, SPFlatFileIsReferenceL, SPFlatFileIsSignatureL, SPFlatFileIsTicketL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsTemplateL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

/**
 * @brief Check if a flat file object contains a reference.
 *
 * @note Prior versions did not differentiate between references and
 *       signatures. The value 1 may therefore be returned even if the
 *       flat file object contains a signature.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *  - 0: the flat file object does not contain a reference
 *  - 1: the flat file object contains a reference
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromReference, SPFlatFileIsCleanParameterL, SPFlatFileIsSignatureL, SPFlatFileIsTemplateL, SPFlatFileIsTicketL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsReferenceL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

/**
 * @brief Check if a flat file object contains a signature.
 *
 * This function is quite expensive as the flat file object
 * must be unpacked to check the signature object integrity.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *  - 0: the flat file object does not contain a signature
 *  - 1: the flat file object contains a signature
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromSignature, SPFlatFileIsCleanParameterL, SPFlatFileIsReferenceL, SPFlatFileIsTemplateL, SPFlatFileIsTicketL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsSignatureL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

/**
 * @brief Check if a flat file object contains a ticket.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *  - 0: the flat file object does not contain a ticket
 *  - 1: the flat file object contains a ticket
 *  .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromTicket, SPFlatFileIsCleanParameterL, SPFlatFileIsReferenceL, SPFlatFileIsSignatureL, SPFlatFileIsTemplateL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsTicketL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

/**
 * @brief Create a flat file object from an SPCleanParameter object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pCleanParameter [i]
 *      pointer to an SPCleanCarameter object.
 * @return
 *    - @ref SP_NOERR on success, else error code:
 *    - @ref SP_MEMERR    out of memory
 *    .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileFree, SPFlatFileIsCleanParameterL, SPCleanParameterCreateFromFlatFile, SPCleanParameterWrite
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromCleanParameter(SPUCHAR **ppbFlatFile, SPINT32 *piFlatFileLength, pSPCLEANPARAMETER_T pCleanParameter);

/**
 * @brief Check if a flat file object contains an SPCleanParameter object.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *    - 0: the flat file object data does not contain an SPCleanParameter object
 *    - 1: the flat file object contains an SPCleanParameter object
 *    .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromCleanParameter, SPFlatFileIsReferenceL, SPFlatFileIsSignatureL, SPFlatFileIsTemplateL, SPFlatFileIsTicketL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsCleanParameterL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

/**
 * @brief Create a flat file object from an SPPropertyMap object.
 *
 * @param ppbFlatFile [o]
 *      pointer to a variable that will be filled with a pointer to an array
 *      of bytes containing the flat file object.  The caller is responsible
 *      for deallocating that array of bytes by calling @ref SPFlatFileFree.
 * @param piFlatFileLength [o]
 *      pointer to a variable that will be filled with the length (in bytes) of
 *      the flat file object returned via @a ppbFlatFile.
 * @param pPropertyMap [i]
 *      pointer to an SPPropertyMap object.
 * @return
 *    - @ref SP_NOERR on success, else error code:
 *    - @ref SP_MEMERR    out of memory
 *    .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileFree, SPFlatFileIsPropertyMapL, SPPropertyMapCreateFromFlatFile, SPPropertyMapWrite
 */
SPEXTERN SPINT32 SPLINK SPFlatFileCreateFromPropertyMap(SPUCHAR **ppbFlatFile, SPINT32 *piFlatFileLength, pSPPROPERTYMAP_T pPropertyMap);

/**
 * @brief Check if a flat file object contains an SPPropertyMap object.
 *
 * @param pbFlatFile [i]
 *      pointer to a flat file object.
 * @param iFlatFileLength [i]
 *      length (in bytes) of the flat file object pointed to by @a pbFlatFile.
 * @return
 *    - 0: the flat file object data does not contain an SPPropertyMap object
 *    - 1: the flat file object contains an SPPropertyMap object
 *    .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFlatFileCreateFromPropertyMap, SPFlatFileIsReferenceL, SPFlatFileIsSignatureL, SPFlatFileIsTemplateL, SPFlatFileIsTicketL
 */
SPEXTERN SPINT32 SPLINK SPFlatFileIsPropertyMapL(const SPUCHAR *pbFlatFile, SPINT32 iFlatFileLength);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* SPFLATFILE_H__ */

 /*
  * $Log: SPFlatFile.h,v $
  * Revision 1.4  2011/03/29 12:37:12  ema
  * Documentation: Linux (x86_64).
  *
  * Revision 1.3  2010/08/17 15:53:54  ema
  * Improve documentation.
  *
  * Revision 1.2  2010/06/07 12:08:13  ema
  * Use old-style comments.
  *
  * Revision 1.1.1.1  2010/04/19 08:53:48  uko
  * Reimport in flat file structure
  *
  * Revision 1.36  2008/10/13 16:55:24  uko
  * removed ActiveSWObj class, IActiveSWObjEvents
  * Added object SPPropertyMap
  *
  * Revision 1.35  2008/01/14 00:05:43  ema
  * Improve documentation.
  *
  * Revision 1.34  2008/01/08 15:22:15  ema
  * Improve documentation.
  *
  * Revision 1.33  2008/01/08 09:56:19  ema
  * Improve documentation.
  *
  * Revision 1.32  2008/01/07 10:13:54  ema
  * Improve documentation.
  *
  * Revision 1.31  2008/01/04 16:27:37  ema
  * Improve documentation.
  *
  * Revision 1.30  2008/01/04 12:24:04  ema
  * Improve documentation.
  *
  * Revision 1.29  2007/11/20 16:43:14  uko
  * Documentation for ISO format
  *
  * Revision 1.28  2007/11/16 15:47:18  ema
  * Improve ISO support, add complex patron format (for writing only, currently).
  *
  * Revision 1.27  2007/11/15 16:48:35  ema
  * Support CBEFF wrappers according to clauses 8 (SP_FF_ISO_19794_MINIMUM)
  * and 9 (SP_FF_ISO_19794_SIMPLE) of ISO 19785-3.
  *
  * Revision 1.26  2007/11/06 08:37:27  uko
  * Document biometric data formats
  *
  * Revision 1.25  2007/11/06 07:27:47  uko
  * *** empty log message ***
  *
  * Revision 1.24  2007/11/06 07:23:13  uko
  * ISO format support
  *
  * Revision 1.23  2007/11/05 09:39:17  uko
  * *** empty log message ***
  *
  * Revision 1.22  2007/10/16 16:48:53  uko
  * Start support ISO signature format
  *
  * Revision 1.21  2007/02/19 08:58:26  uko
  * Bugzilla #4050
  *
  * Revision 1.20  2006/08/14 16:28:19  uko
  * New versions
  * Added SPReferenceGetImage2, SPSignwareIsTeller, SPFlatFile.IsTicket
  *
  * Revision 1.19  2006/03/13 09:19:00  uko
  * Updated documentation
  * SignAlyze: Added images (icons, installer bitmap)
  * SignoView: extended plugin interface to support views
  *
  * Revision 1.18  2006/03/13 08:43:12  uko
  * Corrected zip code: D 71034
  *
  * Revision 1.17  2006/01/03 14:11:13  uko
  * Changed company name to SOFTPRO GmbH
  *
  * Revision 1.16  2005/02/21 07:20:39  uko
  * New Object SPImage
  *
  * Revision 1.15  2004/11/29 07:49:12  uko
  * Add new Method SPSmartcardDriverReset
  * Renamed Samples.inc -> Sample.inc
  *
  * Revision 1.14  2004/11/22 09:39:12  uko
  * New Object SPTicket
  *
  * Revision 1.13  2004/10/11 16:51:58  uko
  * Added docu
  *
  * Revision 1.12  2004/10/11 06:41:30  uko
  * Consolidated J-API
  *
  * Revision 1.11  2004/01/12 19:29:44  uko
  * Added SPFlatFileIsXXl
  * Changed some parameters to const
  *
  * Revision 1.10  2003/12/22 10:48:05  uko
  * Use dynamic signature Format incl Timestamp
  * Updated documentation
  *
  * Revision 1.9  2003/11/24 07:53:31  uko
  * Some types changed to const
  *
  * Revision 1.8  2003/09/22 06:56:59  uko
  * Docs added [i] / [o] / [io]
  *
  * Revision 1.7  2002/10/29 11:36:44  uko
  * Docu corrections
  *
  * Revision 1.6  2002/07/08 18:38:29  uko
  * *** empty log message ***
  *
  * Revision 1.5  2002/07/08 09:38:24  uko
  * *** empty log message ***
  *
  * Revision 1.4  2002/06/24 09:24:32  uko
  * Further dev-work
  *
  * Revision 1.3  2002/06/18 15:28:15  uko
  * *** empty log message ***
  *
  * Revision 1.2  2002/06/11 14:30:48  uko
  * *** empty log message ***
  *
  * Revision 1.1  2002/06/10 13:27:39  uko
  * New Module group SignWare
  *
  */

