/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/BufferOutputStream.h                           *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/BufferOutputStream.h                               *
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
 * @file BufferOutputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: BufferOutputStream.h,v 1.9 2012/03/22 14:06:29 ema Exp $
 * @brief Buffered OutputStream.
 *
 */

#ifndef SPOOC_BUFFEROUTPUTSTREAM_H__
#define SPOOC_BUFFEROUTPUTSTREAM_H__

#include <spooc/NonCopyable.h>
#include <spooc/FilterOutputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Class implementing a buffered OutputStream.
 *
 * @see BufferAllOutputStream, BufferInputStream
 */

class BufferOutputStream : public FilterOutputStream, private NonCopyable
{
public:
  /**
   * @brief Constructor.
   *
   * @param[in] aSink        The stream to which data is to be written.
   * @param[in] aBuffer      Pointer to a buffer provided by the caller
   *                         or NULL to let the constructor allocate the
   *                         buffer.
   * @param[in] aBufferSize  The size of the buffer, must be at least one.
   */
  BufferOutputStream (OutputStream &aSink, void *aBuffer, size_t aBufferSize);

  /**
   * @brief Destructor.
   */
  virtual ~BufferOutputStream ();

  /**
   * @brief Close the stream.
   *
   * Does not close the stream passed to the constructor.
   */
  virtual void close ();

  /**
   * @brief Flush the stream.
   *
   * This function forces any buffered data to be written.
   *
   * Throws an exception on error.
   */
  virtual void flush ();

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
   * @brief Write octets to this stream, using the buffer.
   *
   * May throw Exception.
   */
  virtual void write (const void *aSrc, int aLen);

private:
  unsigned char *mBuffer;
  size_t mPtr;
  size_t mSize;
  bool mOwner;
};

}}}

#endif
