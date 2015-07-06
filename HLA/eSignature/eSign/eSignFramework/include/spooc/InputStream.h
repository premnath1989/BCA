/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/InputStream.h                                  *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/InputStream.h                                      *
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
 * @file InputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: InputStream.h,v 1.18 2012/03/22 14:06:30 ema Exp $
 * @brief Interface for an input stream.
 *
 */

#ifndef SPOOC_INPUTSTREAM_H__
#define SPOOC_INPUTSTREAM_H__

#include <spooc/Types.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Interface for an input stream, inspired by Java's
 * java.io.InputStream.
 *
 * @see BigEndianDataInputStream
 * @see DataInputStream
 * @see OutputStream
 */

class InputStream
{
public:

  /**
   * @brief Constructor.
   */
  InputStream ();

  /**
   * @brief Destructor.
   */
  virtual ~InputStream ();

  /**
   * @brief Read octets from source.
   *
   * Implementations of this class may define exceptions thrown.
   *
   * Once this function has returned a value smaller than
   * @a aLen, end of input has been reached and further calls
   * should return 0.
   *
   * @param[out] aDst  Pointer to buffer to be filled.
   * @param[in] aLen   Number of octets to read.
   *
   * @return The number of octets read.
   */
  virtual int read (void *aDst, int aLen) = 0;

  /**
   * @brief Close the stream.
   *
   * Implementations of this class may define exceptions thrown.
   */
  virtual void close () = 0;

  /**
   * @brief Seek to the specified position (int).
   *
   * Throws InvalidArgument if the position is invalid.
   * Throws NotImplemented if seeking is not supported.
   * Implementations of this class may add more exceptions.
   *
   * @param[in] aPos  The position (zero being the first octet).
   *
   * @see seek64()
   */
  virtual void seek (int aPos) = 0;

  /**
   * @brief Retrieve the current position (int).
   *
   * Throws NotImplemented if seeking is not supported.
   * Throws Overflow if the position cannot be represented as non-negative
   * int.
   * Implementations of this class may add more exceptions.
   *
   * @return The current position (zero being the first octet)
   *
   * @see tell64()
   */
  virtual int tell () const = 0;

  /**
   * @brief Get an estimate of the number of octets available for reading.
   *
   * Throws NotImplemented if this function is not supported.
   * Implementations of this class may add more exceptions.
   *
   * @note There may be more octets available than reported by this
   *       function, but never less.  If there is at least one octet
   *       available for reading, the return value must be at least one.
   *       (That is, always returning zero is not possible.)
   *
   * @return The minimum number of octets available for reading.
   */
  virtual int avail () = 0;

  /**
   * @brief Seek to the specified 64-bit position within the file.
   *
   * Throws InvalidArgument if the position is invalid.
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   *
   * Note that it's possible to seek exactly to the end of the file.
   *
   * Implementations of this class may add more exceptions.
   *
   * The default implementation throws NotImplemented.
   */
  virtual void seek64 (spooc_int64_t aPos);

  /**
   * @brief Retrieve the current position as 64-bit integer.
   *
   * Throws NotImplemented if seeking is not supported by the underlying stream.
   *
   * Implementations of this class may add more exceptions.
   *
   * The default implementation throws NotImplemented.
   */
  virtual spooc_int64_t tell64 () const;
};

}}}

#endif
