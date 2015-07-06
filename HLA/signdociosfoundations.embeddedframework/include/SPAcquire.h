/*==============================================================*
 * SOFTPRO SignWare                                             *
 * ADSV developer Toolkit                                       *
 * Module: SPAcquire.h                                          *
 * Created by: uko                                              *
 * Version: $Name: RST#SignWare#core#REL-3-0-1-2 $                                           *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
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
 * @file SPAcquire.h
 * @author uko
 * @version $Name: RST#SignWare#core#REL-3-0-1-2 $
 * @brief SignWare Dynamic Development toolkit, acquire signatures
 *
 * This header includes an object for capturing
 * signatures on a tablet without having a GUI on the computer screen.
 *
 * Signware also includes an object to capture signatures / references with 
 * native GUI, please read  @ref secGuiAcquVsAcquire for a comparison
 * of SPAcquire and SPGuiAcqu.
 * <br>
 * @section gui_spAcquire SPAcquire
 * The SPAcquire object captures one or more signatures from a tablet.
 * There is no visual feedback on the pc screen, however displays integrated
 * into the tablet will be updated.
 *
 * SPAcquire adds capabilities to define special
 * regions. These regions will be interpreted as clickable areas. When the
 * user clicks these regions then a callback function will be called.

 * The acquiry object creates a signature and a reference object. The signature
 * object will be filled during acquiry (as long as acquire mode is active). The
 * signature object will be appended to the reference object if
 * @ref SPAcquireAcquireDone is called with @ref SP_IDOK.
 * In any case, the signature object will not be accessable
 * after calling SPAcquireAcquireDone. The typical usage of the signature object is to
 * check for empty signatures and to deny accepting empty signatures. Always
 * use the created reference object as the result of an acquire operation.
 *
 * The application must differentiate different types of tablet hardware:
 *      - Standard tablets: these devices have no display, so there is no
 *          feedback for users when they hit any special regions. It is
 *          not recommended to define special regions on these devices.
 *      - Full-screen tablets: these devices include a screen that typically
 *          displays the entire workstation. 
 *          <br> SPAcquire does not support Full screen devices
 *      - Tablets with integrated screen: these devices integrate a screen that
 *          allows for direct feedback of the strokes. These devices also
 *          allow for a visual representation of special regions. It is recommended
 *          to register rectangles on these devices. 
 *          <br> Screen updates on these devices are typically relatively slow, it
 *          is not recommended to dynamically update the screen.
 *          <br>The tablet screen cannot be updated when acquiry mode is active.
 *      - Tablets which cannot send vectors in real time (SPTabletGetTybletType() 
 *          returns bit SP_TABLET_NO_REALTIME_VECTORS is set): a GUI should not
 *          display a OK-button unless the the user can see the tablet contents.
 *      - The application must evaluate hardware buttons for tablets that are 
 *          connected through SPTabletServer or tablets that set the flag
 *          SP_TABLET_HARDWARE_AS_VIRTUAL_BUTTONS.
 *      .
 *
 * You may define buttons that are clickable with the tablet. 
 * <br>These buttons are supported:
 *      - Virtual buttons, see @ref SPAcquireRegisterRect and @ref SPAcquireRegisterRect2
 *      .
 *
 * Please see the provided samples for correct use of the acquiry object.
 *
 * @note Some low-level tablet drivers use window messages to communicate with the application. 
 *      - Wintab uses message ID's in the range
 *        WM_USER + 0x7BF0 (0x7FF0) through WM_USER + 0xFBFF (0x7FFF),
 *      - SOFTPRO drivers use message ID's in the range
 *        WM_USER + 0x7BD0 (0x7FD0) through WM_USER + 0x7BDF (0x7FDF).
 *      - SPAcquire uses message ID's in the range
 *        WM_USER + 0x7BB0 (0x7FB0) through WM_USER + 0x7BBF (0x7FBF).
 *      .
 * Please assure that these message ID's do not conflict with message
 * ID's in your application.
 *
 * @section sec_Acquire_XML_Data Description of parameters passed as XML strings
 *
 * Please see sections  @ref sec_VirtualButtonDescriptionDTD for more information on virtual
 * button descriptors and background object descriptors.
 *
 * @note SPAcquire will ignore elements that are designated to the PC screen (screen=on)
 * and will draw elements designated to the tablet lcd (tablet=on).
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @section secGuiAcquVsAcquire Comparison SPAcquire versus SPGuiAcqu
 * 
 * Signware offers two objects to capture signatures or references from a tablet,
 * SPAcquire and SPGuiAcqu.
 * <br> The obvious difference is that SPGuiAcqu includes handling of a native
 * window to render the entered signature in real time.
 *
 * However more limitations apply to SPAcquire due to the missing GUI:
 *    - Full screen devices such as TabletPC or Wacom Cintiq are not supported 
 *    - Tablets without LCD screen are supported but there is no user feedback 
 *      where the application places virtual buttons
 *    - Native buttons are not supported
 *    - background xml-descriptors do not create a background image for 
 *      the PC screen
 *    - xml descriptors must not include coordinated with origin window or absscreen
 *    - a message loop must be processed under Windows
 *    - SPGuiAcqu is not yet implemented in Linux
 *    .
 * 
 * Most applications will thus use a SPGuiAcqu object to capture a signature / reference.
 * SPGuiAcqu can control all tablets which are supported by SignWare, and SPGuiAcqu
 * gives visual feedback on the PC screen, if the tablet has a LCD panel or not.
 * <br>A Tablet-Service application or an application that controls many Tablets, 
 * or an application that may want to run independent, not synchronized dialogs on 
 * tablet and screen may prefer to use a SPAcquire object.
 *
 * @section sec_SpAcquireProperties Supported properties
 * 
 * The table below lists all supported Properties.
 *
 * @htmlonly
 * <table border=1 width="95%") <tbody>
 *   <tr>
 *     <th width='150px'> Name </th> <th width='70px'> Default </th><th width='100px'> Range </th><th> Description </th>
 *   </tr>
 *   <tr> <td> "BackgroundColor" </td>  <td> 0xFFFFFF </td>  <td>  </td>          <td> Background color, format 0xrrggbb, rr: red, gg: green, bb: blue </td> </tr>
 *   <tr> <td> "ForegroundColor" </td>  <td> 0x000000 </td>  <td>  </td>          <td> Foreground color, format 0xrrggbb, rr: red, gg: green, bb: blue </td> </tr>
 *   <tr> <td> "PenThickness" </td>     <td> 127 </td>       <td> 1 ... 255 </td> <td> Pen thickness, see @ref SPTabletSetTabletOption for details </td> </tr>
 * </table>
 * @endhtmlonly
 */


/**
 */
#ifndef SPACQUIRE_H__
#define SPACQUIRE_H__
#include "SPSignWare.h"

/*==============================================================*
 * Constant definitions                                         *
 *==============================================================*/

/*==============================================================*
 * Structures and type definitions                              *
 *==============================================================*/

#ifdef SP_TARGET_LINUX
#ifndef SP_DEFINED_LONG
#define SP_DEFINED_LONG
typedef long LONG;
#endif
#ifndef SP_DEFINED_RECT
#define SP_DEFINED_RECT
typedef struct _RECT
{
  LONG left;
  LONG top;
  LONG right;
  LONG bottom;
} RECT, *PRECT, *LPRECT;
#endif
#endif

/*==============================================================*
 * Function declarations                                        *
 *==============================================================*/
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/**
 * @brief Callback function that is called when a timeout occurs.
 *
 * A pointer to a function that is called to notify the application
 * about a timeout condition during acquiry mode.
 *
 * @param ulOptParameter [i]
 *     the user-defined parameter that was passed when the callback function
 *     was registered.
 * @return 0 on success, else error code, error codes are not evaluated
 * @see SPAcquireAcquire, SPAcquireSetTimeout
 */
typedef int (SPCALLBACK * pSPACQUIRETIMEOUT_T)(SPVPTR ulOptParameter);

/**
 * @brief Callback function that is called when the tablet hardware status changes,
 * please read @ref sec_TabletStatusChanges "tablet status change notifications" 
 * for more details.
 *
 * A pointer to a function that is called to notify the application
 * about tablet hardware status changes.
 *
 * @param pSpAcquire [i]
 *     pointer to the associated SPAcquire object
 * @param iMajor [i]
 *     major event description
 * @param iDetail detail event description
 * @return 0 on success, else error code, error codes are not evaluated
 * @see SPAcquireSetStatusListener
 */
typedef int (SPCALLBACK * pSPACQUIRESTATUS_T)(pSPACQUIRE_T pSpAcquire, int iMajor, int iDetail);

/**
 * @brief Callback function that is called when a registered rectangle
 *        is 'clicked'.
 *
 * @param pSpAcquire [i] pointer to the associated pSPACQUIRE_T object
 * @param uId [i]
 *      the identifier of the rectangle that was clicked.
 * @return 0 on success, else error code, error codes are not evaluated
 * @see SPAcquireRegisterRect
 */
typedef int (SPCALLBACK *pSPACQUIRERECTLISTENER_T)(pSPACQUIRE_T pSpAcquire, SPUINT32 uId);

/**
 * @brief Callback function that is called when a hardware button on the
 *        tablet is pressed.
 *
 * A pointer to a function that is called to notify the application
 * about a hardware button being pressed during acquiry mode.
 *
 * @param pSpAcquire [i]
 *      pointer to the SPAcquire object for which the callback function
 *      has been registered.
 * @param iButtonId [i]
 *      a value identifying the button that was pressed.  The value depends
 *      on the tablet:
 *      - StepOver blueM tablets:
 *          - 0: small button
 *          - 1: large button
 *          .
 *      .
 * @param iPress [i] the value depends on the tablet.
 *      - Stepover tablets pass the max possible pressure value 1023
 *      .
 * @see SPAcquireSetButtonListener
 * @return 0 on success, else error code, error codes are not evaluated
 */
typedef int (SPCALLBACK * pSPACQUIREBUTTON_T)(pSPACQUIRE_T pSpAcquire, SPINT32 iButtonId, SPINT32 iPress);

/**
 * @brief Create an SPAcquire object.
 *
 * Under Windows an invisible message window will be created. 
 * You can query the handle of that window by calling SPAcquireGetHwnd.
 * If SP_GAWW_EVENTS is set in @a iFlags, SPAcquire sends messages
 * with ID's starting at WM_USER + 1000 to that message window.
 *
 * The creation of a tablet object will fail if the connected tablet is a 
 * full screen device such as TabletPC or Wacom Cintiqu.
 * 
 * Under Windows most tablets, especially tablet using a Wintab driver, send
 * vector notifications through as message events, which reqire message
 * loop. Therefore, SP_GAWW_EVENTS must be set under Windows.
 * 
 * Please see section @ref gui_spAcquire for more information about message
 * event IDs.
 *
 * @param ppSPAcquire [o]
 *      pointer to a variable that will be filled with a pointer to a new
 *      SPAcquire object.  The caller is responsible for deallocating the
 *      new object by calling @ref SPAcquireFree.
 * 
 * @param iFlags [i], a combination of:
 *  - @ref SP_GAWW_EVENTS      Use Windows messages (or X11 events).
 *        <br>If this flag is set,then a message loop (or event loop) is
 *        required during acquiry (see SPAcquireAcquireWait and
 *        SPAcquireAcquireProcessMessages).
 *        <br>If this flag is not set, an internal event queue will be used
 *        (see SPAcquireAcquireWait and SPAcquireAcquireProcessMessages).
 *        <br>This flag must be set under Windows.
 *        <br>Currently, this flag must not be set under Linux as X11 is
 *        not yet supported.
 *  .
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_MEMERR        out of memory
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireFree, SPAcquireGetHwnd, SPAcquireAcquireProcessMessages, SPAcquireAcquireWait
 * 
 * @todo Implement SP_GAWW_EVENTS for Linux
 */
SPEXTERN SPINT32 SPLINK SPAcquireCreate(pSPACQUIRE_T *ppSPAcquire, SPINT32 iFlags);

/**
 * @brief Free all resources used by an SPAcquire object.
 *
 * The SPAcquire object must have been created by @ref SPAcquireCreate
 *
 * It is an error to free an SPAcquire object while processing a
 * windows message for the window handle assigned to that SPAcquire
 * object.
 *
 * @param ppSPAcquire [io]
 *      pointer to a variable containing a pointer to an SPAcquire object.
 *      The variable will be set to NULL if this function succeeds.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireCreate
 */
SPEXTERN SPINT32 SPLINK SPAcquireFree(pSPACQUIRE_T *ppSPAcquire);

/**
 * @brief Get the window handle of the message window associated with an
 *        SPAcquire object.
 *
 * This function returns the handle of the invisible message-only window created
 * by SPAcquireCreate.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pHwnd [o]
 *      pointer to a variable that will be filled with the window handle
 *      of the window associated with the SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireCreate
 *
 * @todo Implement for Linux
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetHwnd(pSPACQUIRE_T pSPAcquire, SPHWND *pHwnd);

/**
 * @brief Set the mode of an SPAcquire object.
 *
 * @note Do not set the draw mode once acquiry mode is turned on.
 *
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iDrawMode [i] drawing mode, a combination of:
 *  - @ref SP_VIRTUAL_BUTTON_MODE  don't draw any strokes neither on PC screen nor on tablet LCD screen
 *  - @ref SP_DRAW_MIRROR_TABLET Mirror the tablet along the horizontal axes
 *  - @ref SP_VIRTUAL_BUTTON_CLICK  set the virtual button click mode
 *  .
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SP_VIRTUAL_BUTTON_MODE, SP_DRAW_MIRROR_TABLET, SP_VIRTUAL_BUTTON_CLICK
 * @see SPAcquireGetDrawMode, SPAcquireGetTablet, SPAcquireGetHwnd, SPTabletAcquire, SPTabletAcquireDone
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetDrawMode(pSPACQUIRE_T pSpAcquire, SPINT32 iDrawMode);

/**
 * @brief Get the draw mode of an SPAcquire object.
 *
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param piDrawMode [o]
 *      pointer to a variable that will be filled with the draw mode.
 *      See @ref SPAcquireSetDrawMode for details.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireSetDrawMode
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetDrawMode(pSPACQUIRE_T pSpAcquire, SPINT32 *piDrawMode);

/**
 * @brief Set a property
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszName [i] Name of the property, see @ref sec_SpAcquireProperties "SPAcquire Properties"
 * @param iValue [i] the value of the property
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_UNSUPPORTEDERR    unsupported property, unknown property name
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetIntProperty(pSPACQUIRE_T pSPAcquire, const SPCHAR *pszName, SPINT32 iValue);

/**
 * @brief Set a property
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszName [i] Name of the property, see @ref sec_SpAcquireProperties "SPAcquire Properties"
 * @param piValue [i] pointer to avariable that will be filled with the value of the property
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_UNSUPPORTEDERR    unsupported property, unknown property name
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetIntProperty(pSPACQUIRE_T pSPAcquire, const SPCHAR *pszName, SPINT32 *piValue);

/**
 * @brief Set the background color.
 *
 * The background color is used to draw a pen stroke that has zero
 * pressure. It will also be used to erase the background if
 * @ref SP_ERASE_BACKGROUND is set.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iBackgroundColor [i]
 *      the new background color as integer 0xrrggbb with rr = red, 
 *      gg = green, bb = blue, each color being in the range 0 through 0xff.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetBackgroundColor, SPAcquireSetForegroundColor, SPTabletSetBackgroundColor
 */
INLINE SPINT32 SPAcquireSetBackgroundColor(pSPACQUIRE_T pSPAcquire, SPINT32 iBackgroundColor) { return SPAcquireSetIntProperty(pSPAcquire, "BackgroundColor", iBackgroundColor); }

/**
 * @brief Get the background color.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param piBackgroundColor [i]
 *      pointer to a variable that will be filled with the background color
 *      (see @ref SPAcquireSetBackgroundColor for details).
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetForegroundColor, SPAcquireSetBackgroundColor
 */
INLINE SPINT32 SPAcquireGetBackgroundColor(pSPACQUIRE_T pSPAcquire, SPINT32 *piBackgroundColor) { return SPAcquireGetIntProperty(pSPAcquire, "BackgroundColor", piBackgroundColor); }

/**
 * @brief Set the foreground color.
 *
 * The foreground color is used to draw a pen stroke that has maximum
 * pressure.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iForegroundColor [i]
 *      the new foreground color as integer 0xrrggbb with rr = red, 
 *      gg = green, bb = blue, each color being in the range 0 through 0xff.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       object was created by SPGuiAcquCreateWithoutWindow
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetForegroundColor, SPAcquireSetBackgroundColor, SPTabletSetForegroundColor
 */
INLINE SPINT32 SPAcquireSetForegroundColor(pSPACQUIRE_T pSPAcquire, SPINT32 iForegroundColor) { return SPAcquireSetIntProperty(pSPAcquire, "ForegroundColor", iForegroundColor); }

/**
 * @brief Get the foreground color.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param piForegroundColor [i]
 *      pointer to a variable that will be filled with the foreground color
 *      (see @ref SPAcquireSetForegroundColor for details).
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetBackgroundColor, SPAcquireSetForegroundColor
 */
INLINE SPINT32 SPAcquireGetForegroundColor(pSPACQUIRE_T pSPAcquire, SPINT32 *piForegroundColor) { return SPAcquireGetIntProperty(pSPAcquire, "ForegroundColor", piForegroundColor); }

/**
 * @brief Set the timeout of an acquiry of an SPAcquire object.
 *
 * The timeout handler will be called if there was no pen stroke for the duration of
 * @em iTimeout in milliseconds.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pTimeoutListener [i]
 *      function that will be called when the timeout expires.
 * @param ulOptParameter [i]
 *      user-defined parameter that will be passed to @a pTimeoutListener
 *      (not used by SignWare).
 * @param iTimeout [i]
 *      timeout (in milliseconds) or 0 to disable timeout checking.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetTimeout(pSPACQUIRE_T pSpAcquire, pSPACQUIRETIMEOUT_T pTimeoutListener, SPVPTR ulOptParameter, SPINT32 iTimeout);

/**
 * @brief Set a status listener of an SPAcquire object.
 *
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pNotifyStatus [i]
 *      function that is to be called when a hardware status of the tablet changes,
 *      or when the tablet driver reports errors.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @see SPTabletSetStatusListener 
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetStatusListener(pSPACQUIRE_T pSpAcquire, pSPACQUIRESTATUS_T pNotifyStatus);

/**
 * @brief Get the associated SPTablet object.
 *
 * @ref SP_PARAMERR will be returned if the tablet has not yet been
 * created. You should neither register any listeners in the returned
 * tablet nor set any properties. The object is available to query
 * tablet proerties such as tablet type, size etc. only.
 * 
 * @note The returned tablet object is not a copy. Do not free this object.
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param ppTablet [o]
 *      pointer to a variable that will receive a pointer to the SPTablet
 *      object of the SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * 
 * @see SPAcquireCreateTablet
 *
 * @par Example:
 * @code
 * int getTabletSize(pSPACQUIRE_T pGuiAcqu, SIZE *pSize)
 * {
 *     pSPTABLET_T pTablet = 0;
 *     int rc = SPAcquireGetTablet(pGuiAcqu, &pTablet);
 *     if(rc != SP_NOERR) return rc;
 *     int iWidth, iHeight;
 *     rc = SPTabletGetTabletSize(pTablet, &iWidth, &iHeight);
 *     if(rc != SP_NOERR) return rc;
 *     pSize->cx = iWidth;
 *     pSize->cy = iHeight;
 *     pTablet = 0;
 *     return SP_NOERR;
 * }
 * @endcode
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetTablet(pSPACQUIRE_T pSPAcquire, pSPTABLET_T *ppTablet);

/**
 * @brief Create the native tablet object that is required to connect to
 *        or acquire from the tablet hardware.
 *
 * This is a convenience function provided for applications that might
 * need to access the tablet driver before it is connected. The tablet
 * driver object will be created when it is internally required, the
 * application does not have to call this function.
 *
 * A typical use for this function would be to select an image
 * depending on the tablet device. Create the tablet driver object,
 * get the device ID, pass the device-specific image, and then
 * connect to the tablet.
 * 
 * The creation of a tablet object will fail if the connected tablet is a full screen device
 * such as TabletPC or Wacom Cintiqu. Full screen devices are not supported with SPAcquire
 * objects. Please read @ref secGuiAcquVsAcquire for more details.
 *
 * Please read @ref page_CTabletCreation for a list of supported drivers
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iDriver [i] the driver number, pass SP_UNKNOWN_DRV to use any driver.
 * 
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the device is used by another application
 *     - @ref SP_UNSUPPORTEDERR the tablet is not supported in this context
 *     - @ref SP_NOPADERR      no tablet found
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetTablet
 */
SPEXTERN SPINT32 SPLINK SPAcquireCreateTablet(pSPACQUIRE_T pSPAcquire, SPINT32 iDriver);

/**
 * @brief Create a native tablet object specified by class name.
 *
 * This function will not reinstantiate the tablet driver if a driver
 * already exists.
 *
 * This is a convenience function provided for applications that might
 * need to access the tablet driver before it is connected. In most
 * other cases the tablet driver object will be created when it is
 * internally required, the application does not have to call this
 * function.
 *
 * A typical application of this function would be to select an image
 * depending on the tablet device. Create the tablet driver object,
 * get the device ID, pass the device specific image, and then
 * connect to the tablet.
 * 
 * The creation of a tablet object will fail if the connected tablet is a full screen device
 * such as TabletPC or Wacom Cintiqu. Full screen devices are not supported with SPAcquire
 * objects. Please read @ref secGuiAcquVsAcquire for more details.
 *
 * Please read @ref page_CTabletCreation for a list of supported options
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszTabletClass [i]
 *      class name of the SOFTPRO tablet access module. 
 * @param pszConfig [i]
 *      pass optional configuration data. Configuration data depends
 *      on the detected hardware driver (see @ref pg_PadInstallation):
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the device is used by another application
 *     - @ref SP_UNSUPPORTEDERR the tablet is not supported in this context
 *     - @ref SP_NOPADERR      no tablet found
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireConnectEx, SPAcquireDisconnect, SPAcquireAcquire, SPAcquireAcquireDone, SPTabletCreateEx
 */
SPEXTERN SPINT32 SPLINK SPAcquireCreateTabletEx(pSPACQUIRE_T pSPAcquire, const char *pszTabletClass, const char *pszConfig);

/**
 * @brief Create a new SPTablet object based on an Alias.
 * 
 * Please read @ref page_CTabletCreation for resolving the Alias
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszAlias [i] the alias name of the tablet
 * 
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter, e. g.pszAlias is NULL or empty
 *   - @ref SP_MEMERR        out of memory
 *   - @ref SP_BUSYERR       the device is used by another application
 *   - @ref SP_NOPADERR      the device is not accessible
 *   - @ref SP_INVALIDERR    alias not resolveable
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreateByAlias, SPAcquireCreateTablet, SPAcquireCreateTabletEx, SPAcquireConnectByAlias
 */
SPEXTERN SPINT32 SPLINK SPAcquireCreateTabletByAlias(pSPACQUIRE_T pSPAcquire, const char *pszAlias);

/**
 * @brief Clear all internal signature data of any acquiries of an
 *        SPAcquire object.
 *
 * This function will clear the SPReference object that is embedded in this
 * object; this means that all signatures that were entered so far will be deleted.
 * This function may be required to reenter a signature / reference
 * when the prior entry was not accepted, e.g., because the reference
 * did not satisfy the quality criteria.
 *
 * @param pSpAcquire [i] pointer to an SPAcquire object.
 * @param iFlags [i] reserved parameter, should be 0.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireClearEntries(pSPACQUIRE_T pSpAcquire, int iFlags);

/**
 * @brief Connect to a tablet specified by driver number.
 * 
 * The creation of a tablet object will fail if the connected tablet is a full screen device
 * such as TabletPC or Wacom Cintiqu. Full screen devices are not supported with SPAcquire
 * objects. Please read @ref secGuiAcquVsAcquire for more details.
 *
 * Please read @ref page_CTabletCreation for a list of supported drivers
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iDriver [i] the driver number, pass SP_UNKNOWN_DRV to use any driver.
 * 
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the tablet is in use by another application
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireCreate, SPAcquireFree
 * @see SP_UNKNOWN_DRV, SP_WINTAB_DRV, SP_PADCOM_DRV, SP_NATIVE_DRV, SP_TCP_DRV
 * @see SPAcquireConnectEx, SPAcquireCreateTablet, SPTabletConnect, SPTabletDisconnect
 */
SPEXTERN SPINT32 SPLINK SPAcquireConnect(pSPACQUIRE_T pSPAcquire, SPINT32 iDriver);

/**
 * @brief Connect to a tablet specified by class name.
 * 
 * The creation of a tablet object will fail if the connected tablet is a full screen device
 * such as TabletPC or Wacom Cintiqu. Full screen devices are not supported with SPAcquire
 * objects. Please read @ref secGuiAcquVsAcquire for more details.
 *
 * Please read @ref page_CTabletCreation for a list of supported options
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszTabletClass [i]
 *      the class name of SOFTPRO tablet access module. 
 * @param pszConfig [i]
 *      pass optional configuration data. Configuration data depends
 *      on the detected hardware driver (see @ref pg_PadInstallation):
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the tablet is in use by another application
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireConnect, SPAcquireCreate, SPAcquireFree
 * @see SP_UNKNOWN_DRV, SP_WINTAB_DRV, SP_PADCOM_DRV, SP_NATIVE_DRV, SP_TCP_DRV
 * @see SPAcquireCreateTabletEx, SPTabletConnect, SPTabletDisconnect, SPTabletCreateEx
 */
SPEXTERN SPINT32 SPLINK SPAcquireConnectEx(pSPACQUIRE_T pSPAcquire, const char *pszTabletClass, const char *pszConfig);

/**
 * @brief Connect to a tablet specified by an alias name.
 * 
 * Please read @ref page_CTabletCreation for resolving the Alias
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszTabletAlias [i] the alias name of the tablet
 * 
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter, e. g.pszAlias is NULL or empty
 *   - @ref SP_MEMERR        out of memory
 *   - @ref SP_BUSYERR       the device is used by another application
 *   - @ref SP_NOPADERR      the device is not accessible
 *   - @ref SP_INVALIDERR    alias not resolveable
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreateByAlias, SPAcquireConnect, SPAcquireConnectEx, SPAcquireCreateTabletByAlias
 */
SPEXTERN SPINT32 SPLINK SPAcquireConnectByAlias(pSPACQUIRE_T pSPAcquire, const char *pszTabletAlias);

/**
 * @brief Disconnect from a tablet.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPReferenceCreateFromGuiAcqu, SPTabletConnect, SPTabletDisconnect
 */
SPEXTERN SPINT32 SPLINK SPAcquireDisconnect(pSPACQUIRE_T pSPAcquire);

/**
 * @brief Start tablet acquiry mode.
 *
 * Switch the tablet into acquiry mode.
 * 
 * SPTablet switches the tablet from pointer mode to pen entry mode
 * during acquiry. Any registered rectangles will be notified in pen
 * entry mode when the pen is pressed on a rectangle.
 *
 * Pen entry mode is exclusive and will not send any pointer move
 * notifications to any application.
 *
 * This function enables aquiry mode and returns immediately.  The actual 
 * state change of the tablet is signaled by callback functions, see
 * @ref SPAcquireSetStatusListener.
 * 
 * Further callbacks are called during aquiry mode, see
 * @ref SPAcquireSetTimeout, @ref SPAcquireRegisterRect, @ref SPAcquireRegisterRect2,
 * @ref SPAcquireSetButtonListener.
 *
 * Events resulting in callbacks being called are stored in a queue.
 * If SP_GAWW_EVENTS was set in @a iFlags of SPAcquireCreate, the
 * system's queue will be used, that is, either the Windows message
 * queue (for Windows) or the X11 event queue (for X11, not yet implemented).
 * If SP_GAWW_EVENTS was not set in @a iFlags of SPAcquireCreate,
 * an event queue internal to SignWare will be used.
 *
 * In all cases, the queue must be read.  This is done by
 * - using a message loop under Windows (SP_GAWW_EVENTS was set)
 * - or using an X11 event loop under Linux (SP_GAWW_EVENTS was set, not yet
 *   implemented)
 * - or calling SPAcquireAcquireWait
 * - or calling SPAcquireAcquireProcessMessages in a loop.
 * .
 *
 * SPAcquireAcquireWait processes events and waits until
 * SPAcquireAcquireDone is called, e. g. in response to a virtual
 * button click notification.
 *
 * @note Acquire mode will not be activated directly but may be delayed due to 
 * limitations caused by some drivers. This means that errors
 * that occur while processing the state switch may not be passed to the application.
 * <br> The application may set a timer to check the state of the tablet object, the state will be
 * SP_TABLET_STATE_ACQUIRE on success. Some drivers notify the application
 * if errors are detected while switching to acquiry mode by calling the
 * registered status callback, see @ref SPAcquireSetStatusListener.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the device is used by another application
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquireWait, SPTabletAcquire, SPTabletAcquireDone
 */
SPEXTERN SPINT32 SPLINK SPAcquireAcquire(pSPACQUIRE_T pSPAcquire);

/**
 * @brief Terminate tablet acquiry mode.
 *
 * Turn off tablet aquiry mode.
 * 
 * This function makes SPAcquireAcquireWait return.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iResult [i]
 *      command; either @ref SP_IDOK (add signature to reference)
 *      or @ref SP_IDCANCEL (ignore signature)
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetReference, SPAcquireAcquireWait, SPAcquireGetSignature, SPTabletAcquire, SPTabletAcquireDone
 * @see SP_IDOK, SP_IDCANCEL
 */
SPEXTERN SPINT32 SPLINK SPAcquireAcquireDone(pSPACQUIRE_T pSPAcquire, SPINT32 iResult);

/**
 * @brief Wait until tablet acquiry mode is terminated.
 *
 * This function processes messages (or events) and waits until
 * SPAcquireAcquireDone is called in acquiry mode.
 *
 * Applications that do not run a message loop must call either
 * SPAcquireAcquireWait or periodically call
 * SPAcquireAcquireProcessMessages to dispatch the messages for this
 * object.
 * 
 * This function runs a message loop under Windows. Under Linux it waits for 
 * signature capture completion. Signature capture completion is signalled
 * by @ref SPAcquireAcquireDone.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the device is used by another application
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPAcquireAcquireDone, SPAcquireCreate
 */
SPEXTERN SPINT32 SPLINK SPAcquireAcquireWait(pSPACQUIRE_T pSPAcquire);

/**
 * @brief Process pending messages if the tablet is in acquiry mode.
 *
 * This function processes messages (or events) while in acquiry mode.
 * SPAcquireAcquireProcessMessages returns as soon as all pending
 * messages (or events) for this object have been processed whereas
 * SPAcquireAcquireWait does not return until SPAcquireAcquireDone is called.
 *
 * This function runs a message loop under Windows.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_BUSYERR       the device is used by another application
 *     .
 * @par Operating Systems:
 *      Windows (Win32)
 * @see SPAcquireAcquire, SPAcquireAcquireDone, SPAcquireCreate
 */
SPEXTERN SPINT32 SPLINK SPAcquireAcquireProcessMessages(pSPACQUIRE_T pSPAcquire);

/**
 * @brief Get the reference after a signature or reference acquiry.
 *
 * The returned reference may contain a single signature (in this case
 * a signature was captured), or multiple signatures (when a true
 * reference was captured). It is the responsability of the
 * application to convert the reference to a signature if the returned
 * object includes a single signature.
 *
 * This is a convenience function which behaves exactly like
 * @ref SPReferenceCreateFromAcquire.
 * 
 * The captured signature will be added to the the reference object during
 * processing of SPAcquireDone.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param ppReference [o]
 *      pointer to a variable that will be filled with a pointer to
 *      an SPReference object containing the reference.  The caller is
 *      responsible for destroying the new object with @ref SPReferenceFree.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_MEMERR        out of memory
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquireDone, SPAcquireGetSignature, SPReferenceCreateFromGuiAcqu, SPReferenceFree
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetReference(pSPACQUIRE_T pSPAcquire, pSPREFERENCE_T *ppReference);

/**
 * @brief Get the signature during acquiry mode.
 *
 * The returned SPSignature object may not contain all vectors captured
 * so far. This function is provided to check for empty signatures
 * @em before accepting the signature (see @ref SPAcquireAcquireDone).
 * Modifying the SPSignature object won't have an effect on the
 * signature being captured.
 *
 * This is a convenience function which behaves exactly like
 * @ref SPSignatureCreateFromAcquire.
 *
 * No signature object will be returned unless the SPAcquire object
 * is in acquiry mode.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param ppSignature [o]
 *      pointer to a variable that will be filled with a pointer to
 *      an SPSignature object containing the current signature.  The caller is
 *      responsible for destroying the new object with @ref SPSignatureFree.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_MEMERR        out of memory
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPAcquireGetReference, SPSignatureCreateFromGuiAcqu, SPSignatureFree
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetSignature(pSPACQUIRE_T pSPAcquire, pSPSIGNATURE_T *ppSignature);

/**
 * @brief Register a rectangle (virtual button) in acquiry mode.
 *
 *
 * This function is a simplified version of @ref SPAcquireRegisterRect2,
 * the call is actually dispatched to SPAcquireRegisterRect2 with a
 * properly formatted XML description string.
 *
 * Any registered rectangles will be notified in acquiry mode when
 * the pen is pressed on a rectangle.
 *
 * You must assure that the rectangles will be updated whenever the
 * coordinates change, such as resizing or moving a component unless
 * you specify the flag @ref SP_TABLET_COORDINATE.
 *
 * Rectangles can only be drawn to an optional LCD screen on the
 * tablet if they are registered before the tablet enters acquiry mode.
 *
 * The SPAcquire object should not be deleted within the registered
 * listener. You may, e.g., post a message and delete the object in
 * the windows procedure handling that message.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pId [io]
 *      pointer to a variable containing the identifier for the rectangle
 *      to be registered or 0 to let this function create the ID.
 *      The variable will be filled with the created ID, see @ref SPAcquireRegisterRect2.
 * @param rcl [i]
 *      pointer to the rectangle to be registered, all coordinates are
 *      absolute screen coordinates, ie, point 0, 0 is the upper left corner
 *      of the PC screen.
 * @param iFlags [i]
 *      drawing flags, a bitwise combination of the following:
 *      - SP_TABLET_COORDINATE  the rectangle is passed in ppt of the tablet size, or the
 *          entry window size when using a full-screen tablet, will always be set
 *      - SP_DRAW_ON_EXT_LCD    the rectangle will be drawn on an external LCD
 *      - SP_ONLY_FOR_EXT_LCD   ignore this rectangle if the tablet does not have an LCD
 *      .
 * @param pszName [i]
 *      string that should be displayed if the draw flags cause the rectangle
 *      to be drawn.
 *      NULL and "" are legal values, the string length is limited to
 *      160 characters. The string is expected in UTF-8 encoding, use
 *      @ref SPUnicodeToUtf8 to convert from Unicode.
 * @param pRectListener [i]
 *      callback function that will be called when the rectangle is 'clicked'. The global 
 *      virtual button listener (see @ref SPGuiAcquSetButtonListener) will be called if 
 *      this parameter is NULL.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot register a virtual button in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPAcquireSetButtonListener, SPTabletHasProximity, SPTabletSetDrawMode SP_VIRTUAL_BUTTON_CLICK
 */
SPEXTERN SPINT32 SPLINK SPAcquireRegisterRect(pSPACQUIRE_T pSPAcquire, SPUINT32 *pId, pSPRECT_T rcl, SPINT32 iFlags, const SPCHAR *pszName, pSPACQUIRERECTLISTENER_T pRectListener);

/**
 * @brief Register a rectangle (virtual button) in acquiry mode.
 *
 * Any registered rectangles will be notified in acquiry mode when
 * the pen is pressed on a rectangle.
 *
 * Rectangles can only be drawn to an optional LCD screen on the
 * tablet if they are registered before the tablet enters acquiry mode.
 *
 * TextFields will be positioned within the rectangle (centered,
 * excluding optional image space) if no valid coordinate is
 * specified.  Images will be positioned within the rectangle (left
 * aligned) if no valid coordinate is specified.
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pId [io] pointer to a variable theat will be filled with the identifier of the virtual button.
 *      The descriptor of the virtual button must include an id. The button will be updated if the id 
 *      in the descriptor alreaady exists, or created if it does not exist.
 *      <br> The Id is used to identify the virtuel button in virtual button callbacks.
 * @param pszVirtualButtonDescription [i]
 *      description of the rectangle position, size, text, font etc.
 *      Please see element SPSWVirtualButton in @ref sec_VirtualButtonDescriptionDTD for details.
 * @param pRectListener [i]
 *      callback function that will be called when the rectangle is 'clicked'. The global 
 *      virtual button listener (see @ref SPGuiAcquSetButtonListener) will be called if 
 *      this parameter is NULL.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot register a virtual button in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPTabletHasProximity, SPTabletSetDrawMode, SP_VIRTUAL_BUTTON_CLICK
 * @ref gui_spGuiAcqu "SPGuiAcqu"
 * 
 */
SPEXTERN SPINT32 SPLINK SPAcquireRegisterRect2(pSPACQUIRE_T pSPAcquire, SPUINT32 *pId, const SPCHAR*pszVirtualButtonDescription, pSPACQUIRERECTLISTENER_T pRectListener);

/**
 * @brief Unregister a rectangle (virtual button) in acquiry mode.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @param uId [i]        identifier of the rectangle to be unregistered.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot unregister a virtual button in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPAcquireRegisterRect, SPAcquireRegisterRect2, SPAcquireUnregisterAllRects
 */
SPEXTERN SPINT32 SPLINK SPAcquireUnregisterRect(pSPACQUIRE_T pSPAcquire, SPUINT32 uId);

/**
 * @brief Unregister all rectangles (virtual buttons) in acquiry mode.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot unregister virtual buttons in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAcquire, SPAcquireRegisterRect, SPAcquireRegisterRect2, SPAcquireUnregisterRect
 */
SPEXTERN SPINT32 SPLINK SPAcquireUnregisterAllRects(pSPACQUIRE_T pSPAcquire);

/**
 * @brief Set the optional user parameter of an SPAcquire object.
 *
 * The optional user parameter is not used inside SignWare, you may
 * add one additional SPVPTR parameter for application purposes.
 *
 * @param pSPAcquire [i] pointer to an SPAcquire object.
 * @param lUser [i] application-specific parameter.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireGetUserLong
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetUserLong(pSPACQUIRE_T pSPAcquire, SPVPTR lUser);

/**
 * @brief Get the optional user parameter of an SPAcquire object.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param plUser [o]
 *      pointer to a variable that will be filled with the user parameter
 *      of the SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireSetUserLong
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetUserLong(pSPACQUIRE_T pSPAcquire, SPVPTR *plUser);

/**
 * @brief Set the tablet button listener.
 *
 * This listener will be called when a real button on the tablet was
 * pressed, but not for virtual buttons.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pRectListener [i]
 *      Callback function that will be called when a virtual button is pressed.If a 
 *      rectangle is pressed then the registered listener for the rectangle will be 
 *      called, see @ref SPGuiAcquRegisterRect, @ref SPGuiAcquRegisterRect2 or this 
 *      listener will be called if no listener was registered with the virtual button 
 *      (the listener is NULL).
 * @param pButtonListener [i]
 *      Callback function that will be called when a tablet button is pressed.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetButtonListener(pSPACQUIRE_T pSPAcquire, pSPACQUIRERECTLISTENER_T pRectListener, pSPACQUIREBUTTON_T pButtonListener);

/**
 * @brief Set the background image of a tablet that includes an LCD display.
 *
 * The tablet image is composed of all background images, text and rectangles 
 * (virtual buttons). The tablet image will be calculated before the tablet enters
 * acquiry mode, that is within the method SPAcquireAcquire.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pbImage [i]
 *      pointer to the image data. Most standard image formats such as
 *      BMP, TIF, JPG, GIF, and CCITT4 are supported
 * @param iImageLen [i]
 *      size of the image data (in bytes) pointed to by @a pbImage.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter or the image could not be decoded
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      - @ref SP_APPLERR            cannot change background in acquiry mode
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetBackgroundImage(pSPACQUIRE_T pSPAcquire, const SPUCHAR *pbImage, SPINT32 iImageLen);

/**
 * @brief Get the background image as it is displayed on the tablet.
 *
 * The image will @em not contain any partial or fully entered
 * signature strokes.
 *
 * This function returns SP_NOERR and *@a ppImage = NULL if no background
 * image was passed.
 *
 * This function is provided for audit purposes. The resulting image
 * contains a gray-scale image with up to 256 gray levels or a color image.
 *
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iSource [i]
 *      select the source of the image:
 *      - 2 Tablet LCD
 *      .
 * @param ppImage [o]
 *      pointer to a variable that will be filled with a pointer to an SPImage
 *      object. The caller is responsible for deallocating the new object
 *      by calling @ref SPImageFree.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPImageFree
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetBackgroundImage(pSPACQUIRE_T pSPAcquire, SPINT32 iSource, pSPIMAGE_T *ppImage);

/**
 * @cond INTERNAL
 */
/**
 * @brief Get the background text as it is displayed on the tablet.
 *
 * This function returns SP_NOERR and *@a ppText = NULL if no background
 * text was passed.
 *
 * This function is provided for audit purposes. The resulting text
 * contains all text elements that is diplayed on the tablet.
 *  
 * @note This function does not analyse images for text contexts. 
 *  
 * @param pSPAcquire [i]
 *      pointer to an SPAcquire object.
 * @param iSource [i]
 *      select the source of the image:
 *      - 2 Tablet LCD
 *      .
 * @param ppszText [o]
 *      pointer to a char pointer that will be filled with the displayed
 *      text.
 *      The caller is responsible for deallocating the new object
 *      by calling @ref SPFreeString.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPFreeString
 */
SPEXTERN SPINT32 SPLINK SPAcquireGetBackgroundText(pSPACQUIRE_T pSPAcquire, SPINT32 iWhat, SPCHAR **ppText);
/**
 * @endcond
 */

/**
 * @brief Activate / deactivate the acquire window.
 *
 * The acquire window is normally active until SPAcquireAcquireDone is called.
 * There may be situations where the application might want to deactivate
 * acquire mode, e.g. in multi page dialogs.
 *
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param bActive [i]
 *      non-zero to activate acquiry mode, zero to deactive acquiry mode.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetActive(pSPACQUIRE_T pSpAcquire, SPBOOL bActive);

/**
 * @brief Add some text to the tablet LCD screen.
 *
 * The XML string is described in @ref sec_TextDescriptionDTD, element
 * SPSWTextFields must be used.
 *
 * The Objects will be displayed on an (optional) LCD screen when the application 
 * calls SPAcquireAcquire
 * 
 * @note The element attribute screen is ignored in SPAcquire objects. Elements with
 * the attribute tablet=on will be drawn on the tablet LCD, if appplicable
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszXMLTextDescription [i]
 *      a description of the text, position and font to be included.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAddBackgroundObject, SPAcquireAddBackgroundImage, SPAcquireRemoveBackgroundObjects
 */
SPEXTERN SPINT32 SPLINK SPAcquireAddBackgroundText(pSPACQUIRE_T pSpAcquire, const SPCHAR *pszXMLTextDescription);

/**
 * @brief Add images to the tablet LCD screen.
 *
 * The XML string is described in @ref sec_ImageDescriptionDTD,
 * element SPSWImageFields must be used.
 *
 * The Objects will be displayed on an (optional) LCD screen when the application 
 * calls SPAcquireAcquire
 * 
 * @note The element attribute screen is ignored in SPAcquire objects. Elements with
 * the attribute tablet=on will be drawn on the tablet LCD, if appplicable
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszXMLImageDescription [i]
 *      string containing the XML description of the images.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAddBackgroundObject, SPAcquireAddBackgroundText, SPAcquireRemoveBackgroundObjects
 */
SPEXTERN SPINT32 SPLINK SPAcquireAddBackgroundImage(pSPACQUIRE_T pSpAcquire, const SPCHAR *pszXMLImageDescription);

/**
 * @brief Add documents to the tablet LCD screen.
 *
 * The XML string is described in @ref sec_DocumentDescriptionDTD,
 * element SPSWDocumentFields must be used.
 *
 * The Objects will be displayed on an (optional) LCD screen when the application 
 * calls SPAcquireAcquire
 * 
 * @note The element attribute screen is ignored in SPAcquire objects. Elements with
 * the attribute tablet=on will be drawn on the tablet LCD, if appplicable
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszXMLDocumentDescription [i]
 *      string containing the XML description of the documents.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32)
 * @see SPAcquireAddBackgroundObject, SPAcquireAddBackgroundText, SPAcquireAddBackgroundImage, SPAcquireRemoveBackgroundObjects
 */
SPEXTERN SPINT32 SPLINK SPAcquireAddBackgroundDocument(pSPACQUIRE_T pSpAcquire, const SPCHAR *pszXMLDocumentDescription);

/**
 * @brief Set the content of a document
 * 
 * Use SPAcquireAddBackgroundDocument or SPAcquireAddBackgroundObject or SPAcquireSetBackgroundObjects
 * to define the layout of a document view. SPAcquireSetDocumentContent may the be used to dynamically
 * set the document content.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param aId [i] 
 *      the unique identifyer of the document
 * @param pContent [i]
 *      pointer to the document contents, may be the document data, or a file name
 * @param iContent [i]
 *      the size of the document content in bytes
 * @param aFormat [i]
 *      format specifyer of the document content:
 *      - 1: local file, pContent is the UTF-8 encoded FQN of the document 
 *      - 2: document data is passed as an image, pContent is the document data in memory
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_MEMERR        out of memory
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * 
 * @par Operating Systems:
 *      Windows (Win32)
 * @see SPAcquireAddBackgroundObject, SPAcquireAddBackgroundDocument, SPAcquireRemoveBackgroundObjects
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetDocumentContent(pSPACQUIRE_T pSpAcquire, SPINT32 aId, const SPCHAR *pContent, SPINT32 iContent, SPINT32 aFormat);

/**
 * @brief Add images, text fields or rectangles to the tablet LCD screen
 *
 * The XML string is described in @ref sec_ObjectDescriptionDTD.
 * Element SPSWObjects must be the root element, SPSWImageFileds, SPSWImage,
 * SPSWRect, SPSWRectFields, SPSWTextFields and SPSWText elements will be displayed.
 * 
 * @note SPSWRect and SPSWRectFields will be displayed but cannot be clicked, use 
 * SPAcquireRegisterRect or SPAcquireRegisterRect2 to define virtual buttons.
 * 
 * The Objects will be displayed on an (optional) LCD screen when the application 
 * calls SPAcquireAcquire
 *
 * @note The element attribute screen is ignored in SPAcquire objects. Elements with
 * the attribute tablet=on will be drawn on the tablet LCD, if appplicable
 *
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pszXMLDescription [i]
 *      string containing the XML description of the images and texts.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAddBackgroundText, SPAcquireAddBackgroundImage, SPAcquireRemoveBackgroundObjects
 */
SPEXTERN SPINT32 SPLINK SPAcquireAddBackgroundObject(pSPACQUIRE_T pSpAcquire, const SPCHAR *pszXMLDescription);

/**
 * @brief Set images, text fields or rectangles to the tablet LCD screen
 * 
 * Use @ref SPBackgroundObjectsCreateFromFile or @ref SPBackgroundObjectsCreateFromXML to create 
 * the background objects container. The proper objects will be selected based on the created
 * tablet type, and all elements of the selected  objects will be copied to the background
 * 
 * @note The element attribute screen is ignored in SPAcquire objects. Elements with
 * the attribute tablet=on will be drawn on the tablet LCD, if appplicable
 * <br> This object must have a vald tablet object, see @ref SPAcquireCreateTablet, 
 * @ref SPAcquireConnect and must not be in aquiry state.
 * <br> All existing background objects will be deleted and the new objects will be added,
 * see @ref SPAcquireRemoveBackgroundObjects
 * 
 * @note Any coordinates with origin window or absscreen may result in undefined behaviour.
 * 
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @param pSpBackgroundObjects [i]
 *      pointer to an SPBackgroundObjects object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode or no tablet instantiated
 *     .
 * 
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPAcquireSetBackgroundObjects(pSPACQUIRE_T pSpAcquire, pSPBACKGROUNDOBJECTS_T pSpBackgroundObjects);

/**
 * @brief Remove images, text and rectangle fields from the tablet LCD screen.
 *
 * The Background Objects will be updated on an (optional) LCD screen when the application 
 * calls SPAcquireAcquire
 *
 * @param pSpAcquire [i]
 *      pointer to an SPAcquire object.
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_APPLERR       cannot change background in acquiry mode
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPAcquireAddBackgroundText, SPAcquireAddBackgroundImage, SPAcquireAddBackgroundObject
 */
SPEXTERN SPINT32 SPLINK SPAcquireRemoveBackgroundObjects(pSPACQUIRE_T pSpAcquire);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* SPGUIACQU_H__ */

 /*
  * $Log: SPAcquire.h,v $
  * Revision 1.20.2.1  2012/10/11 09:40:54  uko
  * Internal method SPGuiAcquGetText, SPAcquireGetText
  *
  * Revision 1.20  2012/02/15 08:09:14  uko
  * C3-546, Document view
  *
  * Revision 1.19  2011/06/10 09:22:34  uko
  * Docu
  *
  * Revision 1.18  2011/06/06 07:01:09  uko
  * Document TabletServer
  *
  * Revision 1.17  2011/04/21 07:44:49  uko
  * Create Tablet by Alias
  * Support Verifone Mx
  *
  * Revision 1.16  2011/03/29 12:37:12  ema
  * Documentation: Linux (x86_64).
  *
  * Revision 1.15  2010/11/09 11:06:31  uko
  * SPAcquire: document undefined behaviour when ccoordinate origin is window or absscreen
  *
  * Revision 1.14  2010/09/24 09:22:07  uko
  * Documentation
  *
  * Revision 1.13  2010/09/08 11:09:33  uko
  * Added SPGuiAcqSetBackgroundObjects SPAcquireSetBackgroundObjects
  *
  * Revision 1.12  2010/08/30 13:40:12  ema
  * Always use event queue under Linux and always require
  * SPAcquireAcquireWait() (or SPGuiAcquAcquireWait()) or
  * SPAcquireProcessMessages() (or SPGuiAcquAcquireProcessMessages())
  * to be called by application.
  *
  * Revision 1.11  2010/08/17 15:53:54  ema
  * Improve documentation.
  *
  * Revision 1.10  2010/08/12 09:24:12  uko
  * RegisterRect / RegisterRect2 update docu
  * Posix call global Listener
  *
  * Revision 1.9  2010/07/28 09:29:45  uko
  * Use SPSWVirtualButton
  *
  * Revision 1.8  2010/07/27 09:51:25  uko
  * Docu
  * (APAcquire|SPGuiAcqu)SetButtonListener registers RectListener und ButtonListener
  *
  * Revision 1.7  2010/07/24 19:15:31  uko
  * Docu
  *
  * Revision 1.6  2010/07/24 18:56:57  uko
  * Added SetIntProperty / GetIntProperty in all GUI components
  *
  * Revision 1.5  2010/07/23 18:59:39  uko
  * Feature-complete support STU-520
  *
  * Revision 1.4  2010/07/21 18:38:39  uko
  * Docu
  *
  * Revision 1.3  2010/07/20 13:59:07  uko
  * Docu
  *
  * Revision 1.2  2010/07/20 07:20:18  uko
  * Docu
  *
  * Revision 1.1  2010/07/19 09:31:48  uko
  * SPAcquire: Signature Capture without GUI
  *
  *
  */

