/*============================================= -*- C++ -*- ====*
 * SOFTPRO SignDoc                                              *
 *                                                              *
 * @(#)SignPKCS7.h                                              *
 *                                                              *
 * Copyright SOFTPRO GmbH,                                      *
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
 * @file SignPKCS7.h
 * @author ema
 * @version $Id$ ($Name$)
 * @brief Interface for creating a PKCS #7 signature.
 */

#ifndef SP_SIGNPKCS7_H__
#define SP_SIGNPKCS7_H__

class TimeStampClient;

/**
 * @brief Data source.
 *
 * Interface for getting byte ranges from a document.
 */
class SDPKCS7Source
{
public:
  /// @brief Constructor.
  SDPKCS7Source () { }

  /// @brief Destructor.
  virtual ~SDPKCS7Source () { }

  /**
   * @brief Fetch data from the document.
   *
   * @param[out] aPtr      A pointer to the first byte will be stored here.
   * @param[in] aMaxSize   Fetch up to this many bytes. Must be positive.
   *
   * @return 0 if no more data is available, otherwise the number of bytes
   *         pointed to by the pointer returned in @a aPtr. The return value
   *         is always less than or equal to @a aMaxSize.
   */
  virtual int fetch (const void *&aPtr, int aMaxSize) = 0;
};

/**
 * @brief Interface for creating a PKCS #7 signature.
 *
 * Selection of the certificate is up to the implementation.
 */
class SignPKCS7
{
public:
  /**
   * @brief Hash Algorithm to be used for detached signature.
   *
   * @see DigSigDoc::DetachedAlgorithm
   */
  enum DetachedAlgorithm
  {
    da_not_detached,            ///< Signature is not detached
    da_md5,                     ///< MD5
    da_sha1,                    ///< SHA-1
    da_sha256                   ///< SHA-256
  };

  /**
   * @brief Constructor.
   */
  SignPKCS7 () { }

  /**
   * @brief Destructor.
   *
   * Should release the crypto provider context if one was acquired.
   */
  virtual ~SignPKCS7 () { }

  /**
   * @brief Sign a hash, producing a PKCS #7 signature.
   *
   * @param[in] aHashPtr   Pointer to the first octet of the hash.
   * @param[in] aHashSize  Size of the hash (number of octets
   *                       pointed to by @a aHashPtr).
   * @param[in] aTimeStampClient  Non-NULL to use a time-stamp server.
   * @param[out] aOutput   The ASN.1-encoded PKCS #7 signature will be
   *                       stored here.
   *
   * @return true iff successful.
   */
  virtual bool signHash (const unsigned char *aHashPtr, size_t aHashSize,
                         TimeStampClient *aTimeStampClient,
                         std::string &aOutput) = 0;

  /**
   * @brief Sign data, producing a detached PKCS #7 signature.
   *
   * @param[in] aSource     An object providing data to be hashed.
   * @param[in] aAlgorithm  Hash algorithm to be used for detached signature.
   *                        Must not be da_not_detached.
   * @param[in] aTimeStampClient  Non-NULL to use a time-stamp server.
   * @param[out] aOutput  The ASN.1-encoded PKCS #7 signature will be
   *                      stored here.
   *
   * @return true iff successful.
   */
  virtual bool signDetached (SDPKCS7Source &aSource,
                             DetachedAlgorithm aAlgorithm,
                             TimeStampClient *aTimeStampClient,
                             std::string &aOutput) = 0;

  /**
   * @brief Compute the size of the signature produced by signHash().
   *
   * @param[in] aHashSize   Size of the hash (number of octets).
   * @param[in] aTimeStamp  true to include RFC 3161 time stamp.
   *
   * @return A positive number which is an upper limit to the number
   *         of octets required for the ASN.1-encoded signature,
   *         zero on error.
   */
  virtual size_t getSignHashSize (size_t aHashSize, bool aTimeStamp) = 0;

  /**
   * @brief Compute the size of the signature produced by signDetached().
   *
   * @param[in] aAlgorithm   Hash algorithm to be used for detached signature.
   *                         Must not be da_not_detached.
   * @param[in] aTimeStamp   true to include RFC 3161 time stamp.
   *
   * @return A positive number which is an upper limit to the number
   *         of octets required for the ASN.1-encoded signature,
   *         zero on error.
   */
  virtual size_t getSignDetachedSize (DetachedAlgorithm aAlgorithm,
                                      bool aTimeStamp) = 0;

  /**
   * @brief Get the common name (CN) of the certificate's subject.
   *
   * @param[out] aOutput    The common name will be stored here (UTF-8).
   *
   * @return true iff successful.
   */
  virtual bool getSubjectCommonName (std::string &aOutput) const = 0;

  /**
   * @brief Get an error message for the last operation.
   *
   * After any member function of this object has been called, you can
   * retrieve an error message by calling this function.
   *
   * @return  A pointer to the error message.  The pointer will become
   *          invalid as soon as any member function of this object is called
   *          or this object is destroyed.
   */
  virtual const char *getErrorMessage () const = 0;
};

#endif
