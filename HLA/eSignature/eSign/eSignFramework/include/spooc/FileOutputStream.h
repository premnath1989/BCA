/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/FileOutputStream.h                             *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/FileOutputStream.h                                 *
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
 * @file FileOutputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: FileOutputStream.h,v 1.12 2012/07/23 08:21:07 ema Exp $
 * @brief OutputStream writing to a file.
 *
 */

#ifndef SPOOC_FILEOUTPUTSTREAM_H__
#define SPOOC_FILEOUTPUTSTREAM_H__

#include <string>
#include <spooc/NonCopyable.h>
#include <spooc/OutputStream.h>

namespace de { namespace softpro { namespace spooc {

class UnicodeString;

/**
 * @brief Class implementing an OutputStream writing to a file.
 *
 * If possible, any IoError exception thrown by member functions
 * of this class contain the pathname. Note that the pathname
 * will be UTF-8 encoded.
 */

class FileOutputStream : public OutputStream, private NonCopyable
{
public:
  /**
   * @brief Constructor: Write to a C stream.
   *
   * @param[in] aFile  The C stream to be wrapped.
   */
  FileOutputStream (FILE *aFile);

  /**
   * @brief Constructor: Write to a C stream.
   *
   * @param[in] aFile  The C stream to be wrapped.
   * @param[in] aPath  The pathname (native encoding), used in exceptions,
   *                   can be NULL.
   */
  FileOutputStream (FILE *aFile, const char *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * If the named file already exists, it will be truncated.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The name of the file to be opened (native encoding).
   */
  FileOutputStream (const char *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * If the named file already exists, it will be truncated.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The name of the file to be opened.
   */
  FileOutputStream (const wchar_t *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * If the named file already exists, it will be truncated.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The name of the file to be opened.
   */
  FileOutputStream (const UnicodeString &aPath);

  /**
   * @brief Destructor.
   *
   * Does not close the C stream passed to the constructor taking a C stream.
   */
  virtual ~FileOutputStream ();

  /**
   * @brief Seek to the specified position within the file (int).
   *
   * Throws InvalidArgument if the position is invalid.
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   * Throws IOError if seeking failed for other reasons.
   *
   * Note that it's possible to seek exactly to the end of the file.
   *
   * @see seek64()
   */

  virtual void seek (int aPos);

  /**
   * @brief Retrieve the current position as int.
   *
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   * Throws IOError if getting the position failed for other reasons.
   * Throws Overflow if the position cannot be represented as non-negative
   * int.
   *
   * @see tell64()
   */
  virtual int tell () const;

  /**
   * @brief Write octets to the file.
   *
   * May throw Exception.
   */
  virtual void write (const void *aSrc, int aLen);

  /**
   * @brief Close the stream.
   *
   * Does not close the C stream passed to the constructor taking a C stream.
   */
  virtual void close ();

  /**
   * @brief Flush the stream.
   */
  virtual void flush ();

  /**
   * @brief Seek to the specified 64-bit position within the file.
   *
   * Throws InvalidArgument if the position is invalid.
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   * Throws IOError if seeking failed for other reasons.
   *
   * Note that it's possible to seek exactly to the end of the file.
   */
  virtual void seek64 (spooc_int64_t aPos);

  /**
   * @brief Retrieve the current position as 64-bit integer.
   *
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   * Throws IOError if getting the position failed for other reasons.
   */
  virtual spooc_int64_t tell64 () const;

private:
  void throwIOError (const char *aFun) const;
  void throwSeekingNotSupported (const char *aFun) const;

private:
  FILE *mFile;
  std::string mPath;
  bool mClose;
};

}}}

#endif
