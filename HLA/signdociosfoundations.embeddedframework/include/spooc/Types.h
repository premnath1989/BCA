/*============================================= -*- C++ -*- ====*
 * SOFTPRO spooclib                                             *
 * Module: spooc/Types.h                                        *
 * Created by: ema                                              *
 * Version: $Name:  $                                           *
 *                                                              *
 * @(#)spooc/Types.h                                            *
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
 * @file Types.h
 * @author ema
 * @version $Name:  $
 * $Id: Types.h,v 1.3 2012/03/23 12:35:50 ema Exp $
 * @brief Basic types.
 *
 */

#ifndef SPOOC_TYPES_H__
#define SPOOC_TYPES_H__

#if defined (__GNUC__)

#include <stdint.h>

typedef int32_t spooc_int32_t;
typedef int64_t spooc_int64_t;
typedef uint64_t spooc_uint64_t;

#elif defined (_MSC_VER)

typedef int spooc_int32_t;
typedef __int64 spooc_int64_t;
typedef unsigned __int64 spooc_uint64_t;

#endif

#endif
