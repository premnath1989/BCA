/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/NonCopyable.h                                  *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/NonCopyable.h                                      *
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
 * @file NonCopyable.h
 * @author ema
 * @version $Name:  $
 * $Id: NonCopyable.h,v 1.6 2012/03/22 14:06:30 ema Exp $
 * @brief Base class for classes which cannot be copied.
 *
 */

#ifndef SPOOC_NONCOPYABLE_H__
#define SPOOC_NONCOPYABLE_H__

namespace de { namespace softpro { namespace spooc {

/**
 * @brief Base class for classes which should not be copyable.
 */

class NonCopyable
{
public:
  /// Constructor.
  NonCopyable () { }
  /// Destructor.
  ~NonCopyable () { }

private:
  /// Disable copy constructor.
  NonCopyable (const NonCopyable &);

  /// Disable assignment.
  NonCopyable &operator = (const NonCopyable &);
};

}}}

#endif
