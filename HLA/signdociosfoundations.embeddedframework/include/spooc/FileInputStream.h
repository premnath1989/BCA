/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/FileInputStream.h                              *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/FileInputStream.h                                  *
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
 * @file FileInputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: FileInputStream.h,v 1.13 2012/07/23 08:21:07 ema Exp $
 * @brief InputStream reading from a file.
 *
 */

#ifndef SPOOC_FILEINPUTSTREAM_H__
#define SPOOC_FILEINPUTSTREAM_H__

#include <string>
#include <spooc/NonCopyable.h>
#include <spooc/InputStream.h>

namespace de { namespace softpro { namespace spooc {

class UnicodeString;

/**
 * @brief Class implementing an InputStream reading from a file.
 *
 * If possible, any IoError exception thrown by member functions
 * of this class contain the pathname. Note that the pathname
 * will be UTF-8 encoded.
 */

class FileInputStream : public InputStream, private NonCopyable
{
public:
  /**
   * @brief Constructor: Read from a C stream.
   *
   * @param[in] aFile  The C stream to be wrapped.
   */
  FileInputStream (FILE *aFile);

  /**
   * @brief Constructor: Read from a C stream.
   *
   * @param[in] aFile  The C stream to be wrapped.
   * @param[in] aPath  The pathname (native encoding), used in exceptions,
   *                   can be NULL.
   */
  FileInputStream (FILE *aFile, const char *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The pathname of the file to be opened (native encoding).
   */
  FileInputStream (const char *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The pathname of the file to be opened.
   */
  FileInputStream (const wchar_t *aPath);

  /**
   * @brief Constructor: Open a file in binary mode.
   *
   * May throw Exception.
   *
   * @param[in] aPath  The pathname of the file to be opened.
   */
  FileInputStream (const UnicodeString &aPath);

  /**
   * @brief Destructor.
   *
   * Does not close the C stream passed to the constructor taking a C stream.
   */
  virtual ~FileInputStream ();

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
   * @brief Read octets from the file.
   *
   * May throw Exception.
   */
  virtual int read (void *aDst, int aLen);

  /**
   * @brief Close the stream.
   *
   * Does not close the C stream passed to the constructor taking a C stream.
   */
  virtual void close ();

  /**
   * @brief Get an estimate of the number of octets available for reading.
   *
   * @note This implementation throws NotImplemented for
   *       non-seekable files. This function is quite expensive
   *       for buffered seekable files.
   *
   * @return The exact number of octets available for reading.
   */
  virtual int avail ();

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
