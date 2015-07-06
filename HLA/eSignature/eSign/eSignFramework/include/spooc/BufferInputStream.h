/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/BufferInputStream.h                            *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/BufferInputStream.h                                *
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
 * @file BufferInputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: BufferInputStream.h,v 1.10 2012/03/22 14:06:29 ema Exp $
 * @brief Buffered InputStream.
 *
 */

#ifndef SPOOC_BUFFERINPUTSTREAM_H__
#define SPOOC_BUFFERINPUTSTREAM_H__

#include <spooc/NonCopyable.h>
#include <spooc/FilterInputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Class implementing a buffered InputStream.
 */

class BufferInputStream : public FilterInputStream, private NonCopyable
{
public:
  /**
   * @brief Constructor.
   *
   * @param[in] aSource      The stream from which data is to be read.
   * @param[in] aBuffer      Pointer to a buffer provided by the caller
   *                         or NULL to let the constructor allocate the
   *                         buffer.
   * @param[in] aBufferSize  The size of the buffer, must be at least one.
   */
  BufferInputStream (InputStream &aSource, void *aBuffer, size_t aBufferSize);

  /**
   * @brief Destructor.
   */
  virtual ~BufferInputStream ();

  /**
   * @brief Seek to the specified position within the file.
   */
  virtual void seek (int aPos);

  /**
   * @brief Retrieve the current position.
   */
  virtual int tell () const;

  /**
   * @brief Seek to the specified 64-bit position.
   *
   * Throws InvalidArgument if the position is invalid.
   *
   * Note that it's possible to seek exactly to the end of the file.
   *
   * @param[in] aPos  The position (the first octet is at position zero).
   */
  virtual void seek64 (spooc_int64_t aPos);

  /**
   * @brief Retrieve the current position as 64-bit integer.
   */
  virtual spooc_int64_t tell64 () const;

  /**
   * @brief Read octets from the file.
   *
   * May throw Exception.
   */
  virtual int read (void *aDst, int aLen);

  /**
   * @brief Close the stream.
   *
   * Does not close the stream passed to the constructor.
   */
  virtual void close ();

  /**
   * @brief Get an estimate of the number of octets available for reading.
   *
   * @note This implementation throws NotImplemented.
   *
   * @return  Does not return.
   */
  virtual int avail ();

private:
  unsigned char *mBuffer;
  size_t mPtr;
  size_t mEnd;
  size_t mSize;
  bool mOwner;
};

}}}

#endif
