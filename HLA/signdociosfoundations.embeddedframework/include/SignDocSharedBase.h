/*=============================================== -*- C++ -*- ==*
 * SOFTPRO SignDoc                                              *
 *                                                              *
 * @(#)SignDocSharedBase.h                                      *
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
 * @file SignDocSharedBase.h
 * @author ema
 * @version $Id$ $Name$
 *
 * @brief Some definitions for SignDocShared.
 */

#ifndef SIGNDOCSHAREDBASE_H__
#define SIGNDOCSHAREDBASE_H__

#if defined (_MSC_VER) && defined (SPSD_EXPORT)
#define SPSDEXPORT1 __declspec(dllexport)
#else
#define SPSDEXPORT1
#endif

namespace de { namespace softpro{ namespace spooc {
class UnicodeString;
}}}

namespace de { namespace softpro{ namespace doc {

/**
 * @brief Encoding of strings.
 */
enum Encoding
{
  enc_native,      ///< Windows "ANSI" for Windows, LC_CTYPE for Linux
  enc_utf_8,       ///< UTF-8
  enc_latin_1      ///< ISO 8859-1
};

/**
 * @brief A point (page coordinates or canvas coordinates).
 */
class SPSDEXPORT1 Point
{
public:
  /**
   * @brief Constructor.
   *
   * All coordinates will be 0.
   */
  Point (): m_x (0), m_y (0) { }

  /**
   * @brief Constructor.
   *
   * @param[in] aX  The X coordinate.
   * @param[in] aY  The Y coordinate.
   */
  Point (double aX, double aY): m_x (aX), m_y (aY) { }

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSrc The object to be copied.
   */
  Point (const Point &aSrc)
    : m_x (aSrc.m_x), m_y (aSrc.m_y) { }

  /**
   * @brief Destructor.
   */
  ~Point () { }

  /**
   * @brief Assignment operator.
   *
   * @param[in]  aRHS  The value to be assigned.
   *
   * @return A reference to this object.
   */
  Point &operator= (const Point &aRHS)
  {
    m_x = aRHS.m_x; m_y = aRHS.m_y;
    return *this;
  }

  /**
   * @brief Set the coordinates of the point.
   *
   * @param[in] aX  The X coordinate.
   * @param[in] aY  The Y coordinate.
   */
  void set (double aX, double aY)
  { m_x = aX; m_y = aY; }

public:
  /**
   * @brief The X coordinate.
   */
  double m_x;

  /**
   * @brief The Y coordinate.
   */
  double m_y;
};

/**
 * @brief A rectangle (page coordinates).
 *
 * If coordinates are given in pixels (this is true for TIFF documents),
 * the right and top coordinates are exclusive.
 */
class SPSDEXPORT1 Rect
{
public:
  /**
   * @brief Constructor.
   *
   * All coordinates will be 0.
   */
  Rect ()
    : m_x1 (0), m_y1 (0), m_x2 (0), m_y2 (0) { }

  /**
   * @brief Constructor.
   *
   * @param[in] aX1  The first X coordinate.
   * @param[in] aY1  The first Y coordinate.
   * @param[in] aX2  The second X coordinate.
   * @param[in] aY2  The second Y coordinate.
   */
  Rect (double aX1, double aY1, double aX2, double aY2)
    : m_x1 (aX1), m_y1 (aY1), m_x2 (aX2), m_y2 (aY2) { }

  /**
   * @brief Copy constructor.
   *
   * @param[in] aSrc The object to be copied.
   */
  Rect (const Rect &aSrc)
    : m_x1 (aSrc.m_x1), m_y1 (aSrc.m_y1), m_x2 (aSrc.m_x2), m_y2 (aSrc.m_y2) { }

  /**
   * @brief Destructor.
   */
  ~Rect () { }

  /**
   * @brief Get the coordinates of the rectangle.
   *
   * @param[out] aX1  The first X coordinate.
   * @param[out] aY1  The first Y coordinate.
   * @param[out] aX2  The second X coordinate.
   * @param[out] aY2  The second Y coordinate.
   */
  void get (double &aX1, double &aY1, double &aX2, double &aY2) const
  { aX1 = m_x1; aY1 = m_y1; aX2 = m_x2; aY2 = m_y2; }

  /**
   * @brief Set the coordinates of the rectangle.
   *
   * @param[in] aX1  The first X coordinate.
   * @param[in] aY1  The first Y coordinate.
   * @param[in] aX2  The second X coordinate.
   * @param[in] aY2  The second Y coordinate.
   */
  void set (double aX1, double aY1, double aX2, double aY2)
  { m_x1 = aX1; m_y1 = aY1; m_x2 = aX2; m_y2 = aY2; }

  /**
   * @brief Get the width of the rectangle.
   *
   * @return The width of the rectangle.
   */
  double getWidth () const;

  /**
   * @brief Get the height of the rectangle.
   *
   * @return The height of the rectangle.
   */
  double getHeight () const;

  /**
   * @brief Normalizes the rectangle.
   *
   * Normalizes the rectangle to the one with lower-left and
   * upper-right corners assuming that the origin is in the
   * lower-left corner of the page.
   */
  void normalize ();

  /**
   * @brief Scale the rectangle.
   *
   * @param[in] aFactor   The factor by which the rectangle is to be scaled.
   */
  void scale (double aFactor);

  /**
   * @brief Scale the rectangle.
   *
   * @param[in] aFactorX   The factor by which the rectangle is to be scaled
   *                       horizontally.
   * @param[in] aFactorY   The factor by which the rectangle is to be scaled
   *                       vertically.
   */
  void scale (double aFactorX, double aFactorY);

  /**
   * @brief Get the first X coordinate.
   * @internal
   *
   * @return The first X coordinate
   */
  double getX1 () const { return m_x1; }

  /**
   * @brief Get the first Y coordinate.
   * @internal
   *
   * @return The first Y coordinate.
   */
  double getY1 () const { return m_y1; }

  /**
   * @brief Get the second X coordinate.
   * @internal
   *
   * @return The second X coordinate.
   */
  double getX2 () const { return m_x2; }

  /**
   * @brief Get the second Y coordinate.
   * @internal
   *
   * @return The second Y coordinate.
   */
  double getY2 () const { return m_y2; }

    /**
     * @brief Assignment operator.
     *
     * @param[in]  aRHS  The value to be assigned.
     *
     * @return A reference to this object.
     */
    Rect &operator= (const Rect &aRHS)
    {
      m_x1 = aRHS.m_x1; m_y1 = aRHS.m_y1; m_x2 = aRHS.m_x2; m_y2 = aRHS.m_y2;
      return *this;
    }

public:
  /**
   * @brief The first X coordinate.
   */
  double m_x1;

  /**
   * @brief The first Y coordinate.
   */
  double m_y1;

  /**
   * @brief The second X coordinate.
   */
  double m_x2;

  /**
   * @brief The second Y coordinate.
   */
  double m_y2;
};

/**
 * @brief Compare two Rect objects for equality.
 *
 * @param[in] aLHS  First rectangle.
 * @param[in] aRHS  Second rectangle.
 *
 * @return true if the 4 coordinates of @a aLHS are equal to the 4 coordinates
 *         of @a aRHS.
 */
bool operator== (const Rect &aLHS, const Rect &aRHS);

}}}

#endif
