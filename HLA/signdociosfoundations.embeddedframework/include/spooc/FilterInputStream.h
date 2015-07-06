/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/FilterInputStream.h                            *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/FilterInputStream.h                                *
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
 * @file FilterInputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: FilterInputStream.h,v 1.14 2013/02/04 13:54:55 ema Exp $
 * @brief A filtering input stream.
 *
 */

#ifndef SPOOC_FILTERINPUTSTREAM_H__
#define SPOOC_FILTERINPUTSTREAM_H__

#include <string>
#include <spooc/InputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * A filtering input stream,
 * inspired by Java's java.io.FilterInputStream, but see close().
 *
 * @see FilterOutputStream
 */

class FilterInputStream : public InputStream
{
public:

  /**
   * @brief Constructor.
   *
   * @param[in] aSource  The stream from which data is to be read.
   */
  FilterInputStream (InputStream &aSource) : mSource (aSource) { }

  /**
   * @brief Destructor.
   */
  virtual ~FilterInputStream () { }

  /**
   * @brief Read octets from source.
   *
   * Unless reimplemented, this function forwards the request to the
   * source stream.
   */
  virtual int read (void *aDst, int aLen) { return mSource.read (aDst, aLen); }

  /**
   * @brief Close the stream.
   *
   * @warning Unlike java.io.FilterInputStream.close(), this function
   * does @b not call close() on the source stream.
   */
  virtual void close () { }

  /**
   * @brief Seek to the specified position.
   *
   * Unless reimplemented, this function forwards the request to the
   * source stream.
   */
  virtual void seek (int aPos) { mSource.seek (aPos); }

  /**
   * @brief Retrieve the current position.
   *
   * Unless reimplemented, this function forwards the request to the
   * source stream.
   */
  virtual int tell () const { return mSource.tell (); }

  /**
   * @brief Seek to the specified position.
   *
   * Unless reimplemented, this function forwards the request to the
   * source stream.
   */
  virtual void seek64 (spooc_int64_t aPos) { mSource.seek64 (aPos); }

  /**
   * @brief Retrieve the current position.
   *
   * Unless reimplemented, this function forwards the request to the
   * source stream.
   */
  virtual spooc_int64_t tell64 () const { return mSource.tell64 (); }

  /**
   * @brief Get the source stream.
   */
  InputStream &getSource () const { return mSource; }

protected:
  /**
   * @brief The source stream.
   * @internal
   */
  InputStream &mSource;
};

}}}

#endif
