/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/MemoryInputStream.h                            *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/MemoryInputStream.h                                *
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
 * @file MemoryInputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: MemoryInputStream.h,v 1.20 2012/09/10 08:18:55 ema Exp $
 * @brief InputStream reading from memory.
 *
 */

#ifndef SPOOC_MEMORYINPUTSTREAM_H__
#define SPOOC_MEMORYINPUTSTREAM_H__

#include <stddef.h>
#include <spooc/NonCopyable.h>
#include <spooc/InputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Class implementing an InputStream reading from memory.
 *
 * @see CopyMemoryInputStream
 * @see FixedMemoryOutputStream
 * @see MemoryOutputStream
 */

class MemoryInputStream : public InputStream, private NonCopyable
{
public:
  /**
   * @brief Constructor.
   *
   * Read from the buffer pointed to by aSrc. Note that the buffer contents
   * won't be copied, therefore the buffer must remain valid throughout
   * the use of this object.
   *
   * @param[in] aSrc  Points to the stream contents.
   * @param[in] aLen  Size of the stream contents.
   */

  MemoryInputStream (const unsigned char *aSrc, size_t aLen);

  /// @brief Destructor.

  virtual ~MemoryInputStream ();

  /**
   * @brief Seek to the specified position within the buffer.
   *
   * Throws InvalidArgument if the position is invalid.
   *
   * Note that it's possible to seek exactly to the end of the buffer.
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
   * @brief Read octets from source.
   */

  virtual int read (void *aDst, int aLen);

  /**
   * @brief Close the stream.
   */

  virtual void close ();

  /**
   * @brief Get the number of octets available for reading.
   *
   * @note This implementation returns the exact number of octets
   *       available for reading.
   *
   * @return The number of octets available for reading.
   */

  virtual int avail ();

protected:
  /**
   * @brief Initialize.
   *
   * @param[in] aSrc  Points to the stream contents.
   * @param[in] aLen  Size of the stream contents.
   *
   * @internal
   */
  void init (const unsigned char *aSrc, size_t aLen);

private:
  const unsigned char *mSrc;
  size_t mSize;
  size_t mPos;
};

}}}

#endif
