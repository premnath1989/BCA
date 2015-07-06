/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Plugin interface                                             *
 * Module: spooc/Exception.h                                    *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/Exception.h                                        *
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
 * @file Exception.h
 * @author ema
 * @version $Name:  $
 * $Id: Exception.h,v 1.21 2012/07/23 08:21:07 ema Exp $
 * @brief spooclib exceptions.
 *
 */

#ifndef SPOOC_EXCEPTION_H__
#define SPOOC_EXCEPTION_H__

#include <string>
#include <stdexcept>

namespace de { namespace softpro { namespace spooc {

#ifdef __GNUC__
#define SPOOC_EXPORT __attribute__ ((visibility("default")))
#else
#define SPOOC_EXPORT
#endif

  /**
   * @brief Base class for all exceptions.
   */
  class SPOOC_EXPORT Exception : public ::std::runtime_error
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    Exception ();

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    Exception (const std::string &aWhat);
  };

  /**
   * @brief Invalid argument.
   */
  class SPOOC_EXPORT InvalidArgument : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    InvalidArgument () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    InvalidArgument (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Numeric overflow.
   */
  class SPOOC_EXPORT Overflow : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    Overflow () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    Overflow (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief I/O related exceptions are derived from this exception.
   */
  class SPOOC_EXPORT IOError : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    IOError () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    IOError (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief This exception is thrown if not enough data is available.
   */
  class SPOOC_EXPORT Eof : public IOError
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    Eof () : IOError () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    Eof (const std::string &aWhat)
      : IOError (aWhat) { }
  };

  /**
   * @brief Incorrect padding.
   *
   * This exception is thrown by BlockDecryptOutputStream::close()
   * if the padding in the last block is incorrect.
   */
  class SPOOC_EXPORT BadPadding : public IOError
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    BadPadding () : IOError () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    BadPadding (const std::string &aWhat)
      : IOError (aWhat) { }
  };

  /**
   * @brief Function not implemented.
   *
   * This exception is thrown by OutputStream and InputStream functions
   * which are not implemented.
   */
  class SPOOC_EXPORT NotImplemented : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    NotImplemented () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    NotImplemented (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Syntax error in command line.
   *
   * This exception is thrown by CmdLine member functions.
   */
  class SPOOC_EXPORT CmdLineError : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    CmdLineError () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    CmdLineError (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Encoding error.
   *
   * Either an invalid UTF-8 sequence or a surrogate pair was encountered.
   *
   * This exception is thrown by UnicodeString member functions.
   */
  class SPOOC_EXPORT EncodingError : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    EncodingError () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    EncodingError (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Error while decoding Base-64.
   */
  class SPOOC_EXPORT Base64DecoderError : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    Base64DecoderError () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    Base64DecoderError (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief ASN.1 decoder error.
   *
   * The ASN.1 decoder cannot decode the input.
   *
   * This exception is thrown by ASN1Decoder and ASN1Base member functions.
   */
  class SPOOC_EXPORT ASN1DecoderException : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    ASN1DecoderException () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    ASN1DecoderException (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief ASN.1 encoder error.
   *
   * The ASN.1 encoder cannot encode the object or the value.
   *
   * This exception is thrown by ASN1Encoder and ASN1Base member functions.
   */
  class SPOOC_EXPORT ASN1EncoderException : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    ASN1EncoderException () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    ASN1EncoderException (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Limit for FormatToMemory exceeded.
   *
   * This exception is thrown by FormatToMemory::format() and
   * FormatToMemory::vformat().
   */
  class SPOOC_EXPORT FormatLimitExceeded : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    FormatLimitExceeded () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    FormatLimitExceeded (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief Unsupported TIFF field type.
   *
   * This exception is thrown by TiffReader::getSize(),
   * TiffReader::readFieldByIndex(), and TiffReader::readFieldByTag().
   */
  class SPOOC_EXPORT UnsupportedType : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    UnsupportedType () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    UnsupportedType (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief TIFF field type mismatch.
   */
  class SPOOC_EXPORT TypeMismatch : public Exception
  {
  public:
    /**
     * @brief Constructor with empty message.
     */
    TypeMismatch () : Exception () { }

    /**
     * @brief Constructor with message.
     *
     * @param[in] aWhat  The message.
     */
    TypeMismatch (const std::string &aWhat)
      : Exception (aWhat) { }
  };

  /**
   * @brief METAFONT exception.
   */
  class SPOOC_EXPORT MetafontException : public Exception
  {
  public:
    /**
     * @brief Constructor.
     *
     * @param[in] aWhat        An error message.
     * @param[in] aLineNumber  The line number of metafont_internal.cpp where
     *                         the exception is thrown.
     */
    MetafontException (const std::string &aWhat, int aLineNumber)
      : Exception (aWhat), mLineNumber (aLineNumber) { }

  public:
    /**
     * @brief The line number of metafont_internal.cpp where the
     *        exception was thrown.
     */
    int mLineNumber;
  };

#undef SPOOC_EXPORT

}}}

#endif
