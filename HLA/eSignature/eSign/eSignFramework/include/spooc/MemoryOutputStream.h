/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/MemoryOutputStream.h                           *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/MemoryOutputStream.h                               *
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
 * @file MemoryOutputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: MemoryOutputStream.h,v 1.17 2012/09/10 08:18:55 ema Exp $
 * @brief OutputStream storing to memory.
 *
 */

#ifndef SPOOC_MEMORYOUTPUTSTREAM_H__
#define SPOOC_MEMORYOUTPUTSTREAM_H__

#include <stddef.h>
#include <spooc/NonCopyable.h>
#include <spooc/OutputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Class implementing an OutputStream writing to memory.
 *
 * @see FixedMemoryOutputStream
 * @see MemoryInputStream
 * @see StringOutputStream
 */

class MemoryOutputStream : public OutputStream, private NonCopyable
{
public:
  /// @brief Constructor.

  MemoryOutputStream ();

  /// @brief Destructor.

  virtual ~MemoryOutputStream ();

  /**
   * @brief Write octets to sink.
   *
   * Throws std::bad_alloc or InvalidArgument or Overflow (memory
   * buffer size would exceed INT_MAX) on error.
   */

  virtual void write (const void *aSrc, int aLen);

  /**
   * @brief Close the stream.
   */

  virtual void close ();

  /**
   * @brief Flush the stream.
   */

  virtual void flush ();

  /**
   * @brief Seek to the specified position within the buffer.
   *
   * Throws InvalidArgument if the position is invalid.
   *
   * Note that it's possible to seek exactly to the end of the buffer.
   */

  virtual void seek (int aPos);

  /**
   * Retrieve the current position.
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
   * @brief Retrieve a pointer to the stream contents.
   *
   * Note that the returned pointer is only valid up to the next
   * output to the stream.
   *
   * @return Pointer to the first octet of the stream contents.
   */

  const unsigned char *data () const;

  /**
   * @brief Retrieve the length of the stream contents.
   *
   * @return Number of octets.
   */

  size_t length () const;

  /**
   * @brief Clear the buffered data.
   *
   * The buffer will be empty and the current position will be zero.
   *
   * The buffer may or may not be deallocated.
   */

  void clear ();

private:
  unsigned char *mBuf;
  size_t mPos;
  size_t mUsed;
  size_t mSize;
};

}}}

#endif
