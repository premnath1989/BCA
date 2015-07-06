/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/OutputStream.h                                 *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/OutputStream.h                                     *
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
 * @file OutputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: OutputStream.h,v 1.17 2012/03/22 14:06:30 ema Exp $
 * @brief Interface for an output stream.
 *
 */

#ifndef SPOOC_OUTPUTSTREAM_H__
#define SPOOC_OUTPUTSTREAM_H__

#include <spooc/Types.h>

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Interface for an output stream, inspired by Java's java.io.OutputStream.
 *
 * @see BigEndianDataOutputStream
 * @see DataOutputStream
 * @see InputStream
 */

class OutputStream
{
public:
  /**
   * @brief Constructor.
   */
  OutputStream ();

  /**
   * @brief Destructor.
   *
   * The destructor closes the stream by calling close(), which may
   * throw an exception on error.
   */
  virtual ~OutputStream ();

  /**
   * @brief Close the stream.
   *
   * This function forces any buffered data to be written and
   * closes the stream.
   *
   * You should not write to the stream after calling this function.
   *
   * Throws an exception on error.
   */
  virtual void close () = 0;

  /**
   * @brief Flush the stream.
   * This function forces any buffered data to be written.
   *
   * Throws an exception on error.
   */
  virtual void flush () = 0;

  /**
   * @brief Seek to the specified position.
   *
   * Throws InvalidArgument if the position is invalid.
   * Throws NotImplemented if seeking is not supported.
   *
   * @param[in] aPos  The position (the first octet is at position zero).
   *
   * @see seek64()
   */
  virtual void seek (int aPos) = 0;

  /**
   * @brief Retrieve the current position.
   *
   * Throws NotImplemented if seeking is not supported.
   * Throws Overflow if the position cannot be represented as non-negative
   * int.
   * Implementations of this class may add more exceptions.
   *
   * @return The current position (the first octet is at position zero)
   *
   * @see tell64()
   */
  virtual int tell () const = 0;

  /**
   * @brief Write octets to the stream.
   *
   * Throws an exception on error.
   *
   * @param[in] aSrc  Pointer to buffer to be written.
   * @param[in] aLen  Number of octets to write.
   */
  virtual void write (const void *aSrc, int aLen) = 0;

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
   *
   * @param[in] aPos  The position (the first octet is at position zero).
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
