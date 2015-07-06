/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/FilterOutputStream.h                           *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/FilterOutputStream.h                               *
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
 * @file FilterOutputStream.h
 * @author ema
 * @version $Name:  $
 * $Id: FilterOutputStream.h,v 1.12 2013/02/04 13:54:55 ema Exp $
 * @brief Interface for filtering output stream.
 *
 */

#ifndef SPOOC_FILTEROUTPUTSTREAM_H__
#define SPOOC_FILTEROUTPUTSTREAM_H__

#include <string>
#include <spooc/OutputStream.h>

namespace de { namespace softpro { namespace spooc {

/**
 * Interface for filtering output stream,
 * inspired by Java's java.io.FilterOutputStream, but see close().
 *
 * @see FilterInputStream
 */

class FilterOutputStream : public OutputStream
{
public:
  /**
   * @brief Constructor.
   *
   * @param[in] aSink  The stream to be written to.
   */
  FilterOutputStream (OutputStream &aSink) : mSink (aSink) { }

  /**
   * @brief Destructor.
   */
  virtual ~FilterOutputStream () { }

  /**
   * @brief Close the stream.
   *
   * Unless reimplemented, this function calls flush().
   *
   * @warning Unlike java.io.FilterOutputStream.close(), this function
   * does @b not call close() on the sink stream.
   */
  virtual void close () { flush (); }

  /**
   * @brief Flush the stream.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual void flush () { mSink.flush (); }

  /**
   * @brief Seek to the specified position.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual void seek (int aPos) { mSink.seek (aPos); }

  /**
   * @brief Retrieve the current position.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual int tell () const { return mSink.tell (); }

  /**
   * @brief Seek to the specified position.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual void seek64 (spooc_int64_t aPos) { mSink.seek64 (aPos); }

  /**
   * @brief Retrieve the current position.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual spooc_int64_t tell64 () const { return mSink.tell64 (); }

  /**
   * @brief Write octets to the stream.
   *
   * Unless reimplemented, this function forwards the request to the
   * sink stream.
   */
  virtual void write (const void *aSrc, int aLen) { mSink.write (aSrc, aLen); }

  /**
   * @brief Get the sink stream.
   */
  OutputStream &getSink () const { return mSink; }

protected:
  /**
   * @brief The sink stream.
   * @internal
   */
  OutputStream &mSink;
};

}}}

#endif
