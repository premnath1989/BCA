/*==============================================================*
 * SOFTPRO SignWare                                             *
 * ADSV System developer Toolkit                                *
 * Module: SPTablet.h                                           *
 * Created by: uko                                              *
 * Version: $Name: RST#SignWare#core#REL-3-0-1-2 $                                            *
 *                                                              *
 * @(#)SPTablet.h                              1.00 02/06/04    *
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
 * @file SPTablet.h
 * @author uko
 * @version $Name: RST#SignWare#core#REL-3-0-1-2 $
 * @brief SignWare Dynamic Development toolkit, tablet access
 *
 * This header includes all definitions for low-level tablet access
 * using the SPTablet object. SPTablet abstracts the tablet hardware,
 * it does not inteprete any tablet vectors e. g. to capture a
 * signature. Please see @ref SPGui.h for tablet access with
 * graphical representation.
 *
 * Acquiring a signature typically involves several steps:
 * -# Select driver with @ref SPTabletCreate
 * -# Register listeners with @ref SPTabletSetListeners
 * -# Connect to the tablet with @ref SPTabletConnect
 * -# Enter acquiry mode with @ref SPTabletAcquire
 * -# Process tablet vectors (samples) as they are sent to the listeners
 * -# Process the timestamp with @ref SPTabletGetTimeStamp
 * -# Exit acquiry mode when done by calling @ref SPTabletAcquireDone
 * -# Process the sample rate with @ref SPTabletGetSampleRate and the timestamp with @ref SPTabletGetTimeStamp
 * -# Disconnect from the tablet with @ref SPTabletDisconnect
 * -# Deallocate the SPTablet object with @ref SPTabletFree
 * .
 *
 * Some low-level drivers use windows messages to communicate
 * with the application. Wintab uses message ID's in the range
 * WM_USER + 0x7BF0 (0x7FF0) through WM_USER + 0xFBFF (0x7FFF),
 * the SOFTPRO drivers use message ID's in the range
 * WM_USER + 0xFBD0 (0x7FD0) through WM_USER + 0xFBDF (0x7FDF).
 *
 * Please assure that these message ID's do not conflict with message
 * ID's in your application.
 *
 * SPTablet normalizes the data passed from different tablets, applications
 * will not have to care about the attached device. The normalisation
 * covers:
 *      - pressure: all pressure levels are normalized to a range 0 ... 1023
 *      - coordinates: all coordinates are transformed according to the
 *        specified resolution [in DPI]
 *      - background images: images are scaled to fit the display device (if applicable)
 *      .
 * Tablet vectors are passed to registered listeners with normalized pressure
 * and coordinates.
 *
 *
 * @section sec_TabletStatusChanges Tablet Status Change Notifications
 *
 * Some tablet drivers cannot execute status changes synchronously but have to
 * dispatch the status request and perform the requested operation later. This 
 * applies e. g. to TabletPCs, which cannot directy enter acquiry state but 
 * post a message to the assigned native window handle and change the state 
 * when processing the message. 
 * <br> Errors and warnings can thus not be returned to the application directly,
 * the application will be informed via status change notification / callback.
 * 
 * The callback passes two parameters to describe the event: a major number and a
 * detail number. 
 * <br>These notifications are passed:
 * <br> Major reason for the event.
 *          - 1 An error occured
 *          - 2 A warning occured
 *          - 3 A information message
 *          - 0x400 a special event from eSignature Pad (Wacom SignPad)
 *          - 0x401 a special event from SOFTPRO TabletServer driver
 *          .
 * <br> Detail information for the event
 *      The value depends on the major event type:
 *          - 1 (Error):
 *              - @ref SP_NOPADERR The pad did not respond or was disconnected, application should terminate acquiry
 *              - @ref SP_CANCELERR aborted, only SPTabletServer driver, may be same as cancel button, application should camcel the operation
 *              - @ref SP_UNSUPPORTEDERR  unspecified internal error occured, only SPTabletServer driver, application should terminate acquiry
 *              - @ref SP_APPLERR  unexpected data is passed, only SPTabletServer driver, application should terminate acquiry
 *              - @ref SP_INVALIDERR  invalid configuration, only SPTabletServer driver, application should terminate acquiry
 *              .
 *          - 2 (Warning) currently not used
 *          - 3 (Information) currently not used
 *          - 0x400 (eSignature Pad, Wacom SignPad)
 *              - @ref SP_CRYPTERR Key negotiation failed, vector data is exchanged unencrypted
 *              - @ref SP_UNSUPPORTEDERR The tablet does not support encrypted data exchange
 *              - @ref SP_INTERR an internal error occured, unexpected tablet state, application should terminate acquiry
 *              - @ref SP_DIBERR wrong background image
 *              .
 *          - 0x401 (SPTabletServer)
 *              - @ref SP_DIBERR wrong background image
 *              - @ref SP_TIMEOUTERR  Timeout, no stroke after timeout mseconds, can be handled as OK button
 *              .
 *          .
 */

/**
 * @page page_CTabletCreation Tablet creation options
 * 
 * Signware offers three options to create a tablet
 *  - TabletCreate: The TabletCreate function passes a driver id as the only parameter. This is the
 *    easiest method to create a tablet object, which is typically used if exactly one tablet is 
 *    connected to the host, or the application will use any tablet which may be found first.
 *    <br> These driver ID's are defined in SignWare:
 *      - @ref SP_UNKNOWN_DRV   access any driver
 *      - @ref SP_WINTAB_DRV    access a Wintab driver
 *      - @ref SP_PADCOM_DRV    access a MobiNetix driver
 *      - @ref SP_NATIVE_DRV    access a SOFTPRO native driver
 *      - @ref SP_TCP_DRV       access a SOFTPRO TCP driver
 *      - @ref SP_REMOTETABLET_DRV   access a SOFTPRO remote driver
 *      - @ref SP_TABLETSERVER_DRV   access a SOFTPRO TabletServer driver
 *      .
 *     <br>
 *  - CreateTabletEx: The CreateTabletEx function passes two parameters, a TabletClass and a 
 *    TabletConfiguration string.
 *    <br> These tablet class names are supported:
 *      - SPTabletHidDrv    interface to the SOFTPRO HID driver to access TabletPCs
 *      - SPTabletInterlink interface to the SOFTPRO Interlink driver (SWILUniv)
 *      - SPTabletMobinetix interface to Mobinetix driver
 *      - SPTabletStepOver  interface to StepOver BlueM and BlueM-LCD tablets
 *      - SPTabletTopaz     interface to Topaz 1X5, 4X3 and 4X5 SE LCD tablets
 *      - SPTabletWSignPad  interface to Wacom SignPad tablets
 *      - SPTabletWacom     interface to Wacom Intuos, Graphire, etc. tablets
 *      - SPTabletWTablet   interface to SOFTPRO eInk driver to access TabletPCs
 *      - SPTabletVerifone  interface to SOFTPRO driver to access Verifone Mx 800 series tablets
 *      - SPTabletTabletServer interface to SOFTPRO driver to access tablets via SOFTPRO TabletServer
 *      .
 *    Under Linux, only SPTabletWSignPad is supported.
 *    <br> <br> 
 *    Optional configuration data may be passed in the TabletConfiguration parameter.
 *    Configuration data equals the options as described in tablet.ini, depending on the 
 *    detected tablet model:
 *      - SPTabletHidDrv    no configuration parameters
 *      - SPTabletInterlink no configuration parameters
 *      - SPTabletMobinetix no configuration parameters
 *      - SPTabletStepOver  pass the contents of the file tablet.ini, see @ref pg_PadInstallation
 *      - SPTabletTopaz     pass the contents of the file tablet.ini, see @ref pg_PadInstallation
 *      - SPTabletWSignPad  pass the contents of the file tablet.ini, see @ref pg_PadInstallation
 *      - SPTabletWacom     no configuration parameters
 *      - SPTabletWTablet   no configuration parameters
 *      - SPTabletVerifone  pass the contents of the file tablet.ini, see @ref pg_PadInstallation
 *      - SPTabletTabletServer pass the tablet device identifyer
 *      .
 *    See @ref pg_PadInstallation for detailed information on configuration options for supported 
 *    tablets.
 *    <br> TabletCreateEx may be used to address a specific tablet if more than one tablet is
 *    connected to the host.
 *    <br><br>
 *  - CreateTabletByAlias: The CreateTabletByAlias function passes a TabletAlias string.
 *    <br> The TabletAlias is used as a lookup the windows registry to read a unified resource
 *    location description, which includes the TabletClass and TabletOptions to create the tablet 
 *    using TabletCreateEx.
 *    <br>Under Windows the ULOC will be located in the registry folder HKLM\\SOFTWARE\\SOFTPRO\\tabletconfig\\AliasName.
 *    <br>Under Linux the ULOC will be located in a configuration file ~/.config/SOFTPRO/tabletconfig.config
 *    in section [AliasName].
 *    <br> The Key ULOC contains a resource locator which describes the tablet class and 
 *    further configuration properties.
 *    <br> ULOC format: 
 *    <br>    sptablet://class=ClassName[&connection={usb|tcpip|com}]&[connection_value=port_id]&options
 *    <br> where
 *      - class contains the name of the tablet class, see @ref SPTabletCreateEx for a list of valid tablet classes
 *      - connection contains the interface used to connect to the tablet
 *      - connection_value contains a interface identifyer, e. g. '-2' for second USB device, 
 *        or '2' for COM2, or '192.168.1.15:1002' to address a tcpip interface
 *      - options contains a '&' separated list of options as defined in the tablet.ini, see @ref pg_PadInstallation 
 *      .
 *    The ULOC string must be an url-encoded string (e. g. '&' must be converted to its ansi value '\%38',
 *    a space ' ' must be encoded to '\%32').
 *    <br> CreateTabletByAlias is a convenience function with the same capabilities as TabletCreateEx
 *    but the application uses an alias that will finally be converted to the actual tablet creation 
 *    parameters based on information that is loaded from the registry on the host where the 
 *    application is running, and the tablets are connected.
 *  .
 * 
 * @section sec_CTypicalTabletCreation Typical Creation of a tablet
 * 
 * Most applications may assume that only one tablet is connected. The simple tablet creation
 * should thus satisfy most requirements.
 * <br> An entry in the tablet.ini (see @ref pg_PadInstallation) may be required to use an
 * externally connected tablet on a tablet PC.
 * 
 * Applications that must address more than one tablet should setup the Alias in the registry of
 * the client and pass an Alias for the desired Tablet.
 * <br> Example: let's assume that the application will sign a document. Both, the customer
 * and the consultant, have to sign the document. Two tablets are connected to the host, one
 * located at the customer side, and one located at the consultant side.
 * <br> It is recommended to add a tag to each signature field which defines the Alias used and 
 * to create the tablet object based on the Alias.
 * 
 @code (C)
int CreateTablet(pSPTABLET_T *ppTablet, const char *pszAlias)
{
    int rc = 0;
    if(pszAlias && *pszAlias) {
        rc = SPTabletCreateByAlias(ppTablet, pszAlias);
        // if the alias cannot be resolved then use any tablet found in the system
        if(rc == SP_INVALIDERR)
            rc = SPTabletCreate(ppTablet, SP_UNKNOWN_DRV);
    } else {
        // if no alias passed then use any tablet found in the system
        rc = SPTabletCreate(ppTablet, SP_UNKNOWN_DRV);
    }
    return rc;
}
 @endcode
 */

/**
 * @page page_CTabletHardwareButtons Tablet Hardware button Assignment
 * 
 * Some Tablets integrate harware buttons. A callback function 
 * will be invoked when a hardware button is pressed. SignWare 
 * passes an identifyer for the hardware button that the 
 * application can respond appropriately. 
 * 
 * The hardware button identifyers are internally assigned:
 *   - StepOver blueM tablets:
 *       - 0: small button
 *       - 1: large button
 *   - Verifone MX 800 tablets:
 *       - 0: virtual button OK
 *       - 1: virtual button Cancel
 *       .
 *   - SPTabletServer devices:
 *       - 0: button OK
 *       - 1: button Cancel
 *       - 2: button Repeat
 *       - 3: button Shutter
 *   .
 * 
 * <br>
 * If the callback also passes a pressure value for the virtual button then the pressure 
 * will most likely equal the maximum pressure for the device (normalized maximum pressure: 1023).
 * 
 * Pressure values:
 *   - StepOver blueM tablets:
 *       - always 1023
 *   - Verifone MX 800 tablets:
 *       - always 1023
 *   - SPTabletServer tablets:
 *       - always maximum pressure level
 *       .
 *   .
 * 
 * <br>
 * Please note that you may have to explicitly register a listener for hardware button events.
 */

#ifndef SPTABLET_H__
#define SPTABLET_H__

#include "SPSignWare.h"

/*==============================================================*
 * Constant definitions                                         *
 *==============================================================*/
/**
 * @brief Flag for SPTabletSetFlags: return immediately from SPTabletAcquire.
 *
 * If this flag is set, @ref SPTabletAcquire will return immediately.
 * If this flag is not set, SPTabletAcquire will not return until
 * @ref SPTabletAcquireDone is called.
 *
 * SPTabletAcquireDone must be called in either case.
 *
 * @note Currently, this flag is assumed to be always set under Linux.
 *
 * @see SPTabletAcquire, SPTabletAcquireDone, SPTabletSetFlags
 *
 * @todo Implement for Linux
 */
#define SP_ACQUIRE_RETURN_IMMEDIATELY 2

/**
 * @brief Flag for SPTabletSetFlags: send all vectors having a pressure
 *        value of 0.
 *
 * If this flag is set, @ref SPTabletAcquire will send all vectors
 * (samples) that have a pressure value of 0.  If this flag is not
 * set, SPTabletAcquire will send only one vector having a pressure
 * value of 0 for a sequence of vectors having a pressure value of 0.
 *
 * @see SPTabletAcquire, SPTabletSetFlags
 */
#define SP_ACQUIRE_TRANSFER_0_VECTORS 8

/**
 * @brief Flag for SPTabletSetFlags: don't echo strokes on the tablet LCD.
 *
 * If this flag is set, strokes won't be echoed to the tablet LCD.
 * If this flag is not set, strokes will be echoed to the tablet LCD
 *
 * This flag is ignored for tablets that don't have an LCD.
 *
 * @see SPTabletAcquire, SPTabletSetFlags
 */
#define SP_DONT_ECHO_STROKES 0x10

/**
 * @brief Flag for SPTabletSetFlags: execute SPTabletStartAcquire synchronously.
 *
 * Some tablet drivers require windows messages posted to finally start
 * acquiry mode. The normal behaviour is to post the messages and return. Set
 * this flag if you want the SPTablet object to wait until the messages have
 * been processed (SPTablet will then process and dispatch windows messages).
 *
 * This flag is currently ignored under Linux.
 *
 * @see SPTabletAcquire, SPTabletSetFlags
 *
 * @todo Implement for Linux
 */
#define SP_SYNCHRONOUS_START_ACQUIRE 0x40

/**
 * @brief Tablet state: idle.
 *
 * @see SPTabletGetState
 */
#define SP_TABLET_STATE_IDLE 0

/**
 * @brief Tablet state: connected.
 *
 * @see SPTabletGetState, SPTabletConnect
 */
#define SP_TABLET_STATE_CONNECT 1

/**
 * @brief Tablet state: acquiring.
 *
 * @see SPTabletGetState, SPTabletAcquire
 */
#define SP_TABLET_STATE_ACQUIRE 2

/*==============================================================*
 * Structures and type definitions                              *
 *==============================================================*/

/**
 * @brief Callback function that is called when vectors are available.
 *
 * A pointer to a function that is called whenever a new set of
 * vectors (samples) is available from the tablet in acquiry mode.  The
 * function is called before the vectors of that set are sent to the
 * application.
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @return always @ref SP_NOERR, currently ignored.
 * @see SPTabletSetListeners, pSPLINETO_T , pSPENDNOTIFY_T
 */
typedef int (SPCALLBACK * pSPSTARTNOTIFY_T)(pSPTABLET_T pTablet);

/**
 * @brief Callback function that is called for each vector.
 *
 * A pointer to a function that is called for every significant vector
 * (sample) received from the tablet in acquiry mode.
 *
 * Use SPTabletSetFlags to define behaviour for vectors having a
 * pressure value of 0.
 *
 * Coordinates are sent in tablet coordinates. It is the
 * application's responsibility to convert coordinates into user
 * coordinate space. Tablet coordinates are by default normalized
 * to a resolution of 300 DPI.
 *
 * The coordinate origin is the top left corner of the display
 * window, or the lower left corner of the screen (converted to tablet
 * coordinates) when using an full screen LCD tablet.
 *
 * Coordinate space: 0, 0 equals top left corner. The bottom right
 * corner is calculated phys. height * resolution / 25.4, and phys
 * width * resolution / 25.5, where resolution equals the value returned by
 * SPTabletGetReolution.
 * <br> On Full screen devices the coordinate origin is set to the top
 * left corner of the screen. The application must subtract the offset
 * from top left screen coordinate to the top left acquisition window
 * coordinate (converted to tablet coordinates).
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @param iX [i]
 *      the X coordinate (in tablet coordinates) of the vector.
 * @param iY [i]
 *      the Y coordinate (in tablet coordinates) of the vector.
 * @param iPress [i]
 *      the pressure value of the vector, normalized to 0 through 1023.
 * @return always @ref SP_NOERR, currently ignored.
 * @see SPTabletGetLCD, SPTabletSetLCD, SPTabletSetListeners, SPTabletSetFlags, SP_ACQUIRE_TRANSFER_0_VECTORS, pSPSTARTNOTIFY_T , pSPENDNOTIFY_T
 */
typedef int (SPCALLBACK * pSPLINETO_T)(pSPTABLET_T pTablet, SPINT32 iX, SPINT32 iY, SPINT32 iPress);

/**
 * @brief Callback function that is called for each vector.
 *
 * A pointer to a function that is called for every significant vector
 * (sample) received from the tablet in acquiry mode.
 *
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @param iX [i]
 *      the X coordinate (in tablet coordinates) of the vector.
 * @param iY [i]
 *      the Y coordinate (in tablet coordinates) of the vector.
 * @param iPress [i]
 *      the pressure value of the vector, normalized to 0 through 1023.
 * @return always @ref SP_NOERR, currently ignored.
 * @see pSPLINETO_T, SPTabletSetListeners2
 */
typedef int (SPCALLBACK * pSPLINETO2_T)(pSPTABLET_T pTablet, SPINT32 iX, SPINT32 iY, SPINT32 iPress, int iTime);

/**
 * @brief Callback function that is called after sending one or more vectors.
 *
 * A pointer to a function that is called whenever all vectors
 * (samples) of a set of samples have been transferred in acquiry
 * mode.  This notification can be used for painting vectors when
 * no vectors are coming in.
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @return always @ref SP_NOERR, currently ignored.
 * @see SPTabletSetListeners, pSPSTARTNOTIFY_T, pSPLINETO_T
 */
typedef int (SPCALLBACK * pSPENDNOTIFY_T)(pSPTABLET_T pTablet);

/**
 * @brief Callback function that is called when a hardware button is pressed
 *        on the tablet.
 *
 * A pointer to a function that is called to notify the application
 * about a hardware button being pressed during acquiry mode.
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @param iButtonId [i]
 *      a value identifying the button that was pressed.
 *      The value depends on the tablet, see @ref page_CTabletHardwareButtons 
 * @param iPress [i] the pen pressure if available
 *      The value depends on the tablet, see @ref page_CTabletHardwareButtons
 * 
 * @return always @ref SP_NOERR, currently ignored.
 * @see SPTabletSetButtonListener
 */
typedef int (SPCALLBACK * pSPTABLETBUTTON_T)(pSPTABLET_T pTablet, SPINT32 iButtonId, SPINT32 iPress);

/**
 * @brief Callback function that is called when the status of a tablet changes,
 * please read @ref sec_TabletStatusChanges "tablet status change notifications" 
 * for more details.
 *
 * A pointer to a function that is called to notify the application
 * about a hardware events.
 *
 * @param pTablet [i]
 *      pointer to the SPTablet object that generated the event.
 * @param iMajor [i]
 *      a value identifying the major reason for the event.
 * @param iMinor [i] additional information for the event
 * 
 * @return always @ref SP_NOERR, currently ignored.
 * 
 * @see SPTabletSetStatusListener
 */
typedef int (SPCALLBACK * pSPTABLETSTATUS_T)(pSPTABLET_T pTablet, SPINT32 iMajor, SPINT32 iMinor);

/*==============================================================*
 * Function declarations                                        *
 *==============================================================*/
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/**
 * @brief Create a new SPTablet object.
 *
 * This function checks if the requested driver can be loaded and if a
 * device for this driver can be found. All device-specific
 * information will be available, if a device is found.
 * Call @ref SPTabletGetDevice to get the identifier of the device that was
 * detected.
 *
 * Please read @ref page_CTabletCreation
 * 
 * @param ppTablet [o]
 *      pointer to a variable that will be filled with a pointer to
 *      a new SPTablet object.  The caller is responsible for
 *      deallocating the new object by calling @ref SPTabletFree.
 * @param iDriverId [i]
 *      identifier for the driver to use:
 *      - @ref SP_UNKNOWN_DRV   access any driver
 *      - @ref SP_WINTAB_DRV    access a Wintab driver
 *      - @ref SP_PADCOM_DRV    access a MobiNetix driver
 *      - @ref SP_NATIVE_DRV    access a SOFTPRO native driver
 *      - @ref SP_TCP_DRV       access a SOFTPRO TCP driver
 *      - @ref SP_REMOTETABLET_DRV access a SOFTPRO remote tablet driver
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   - @ref SP_BUSYERR       the device is used by another application
 *   - @ref SP_NOPADERR      the device is not accessible
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreateEx, SPTabletFree, SPTabletGetDevice
 */
SPEXTERN SPINT32 SPLINK SPTabletCreate(pSPTABLET_T *ppTablet, SPINT32 iDriverId);

/**
 * @brief Create a new SPTablet object.
 *
 * Please read @ref page_CTabletCreation for a list of supported options
 * 
 * @param ppTablet [o]
 *      pointer to a variable that will be filled with a pointer to
 *      a new SPTablet object.  The caller is responsible for
 *      deallocating the new object by calling @ref SPTabletFree.
 * @param pszTabletClass [i]
 *      class name of the SOFTPRO tablet access module. 
 *      Under Linux, only SPTabletWSignPad is supported.
 * @param pszConfig [i]
 *      optional configuration data can be passed through this parameter.
 *      Configuration data depends on the detected hardware driver
 *      (see @ref pg_PadInstallation)
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   - @ref SP_BUSYERR       the device is used by another application
 *   - @ref SP_NOPADERR      the device is not accessible
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletFree
 */
SPEXTERN SPINT32 SPLINK SPTabletCreateEx(pSPTABLET_T *ppTablet, const char *pszTabletClass, const char *pszConfig);

/**
 * @brief Create a new SPTablet object based on an Alias.
 * 
 * Please read @ref page_CTabletCreation for resolving the Alias
 * 
 * @param ppTablet [o]
 *      pointer to a variable that will be filled with a pointer to
 *      a new SPTablet object.  The caller is responsible for
 *      deallocating the new object by calling @ref SPTabletFree.
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
 *      Windows (Win32), Linux (i386), Linux (x86_64)
 * @see SPTabletCreate, SPtabletCreateEx, SPTabletFree
 * 
 */
SPEXTERN SPINT32 SPLINK SPTabletCreateByAlias(pSPTABLET_T *ppTablet, const char *pszAlias);

/**
 * @brief Deallocate an SPTablet object.
 *
 * The SPTablet object must have been allocated with @ref SPTabletCreate
 * or @ref SPTabletCreateEx.
 *
 * @param ppTablet [io]
 *      pointer to a variable containing a pointer to an SPTablet
 *      object.
 *      The variable will be set to NULL if this function succeeds.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletCreateEx, SPTabletCreateByAlias
 */
SPEXTERN SPINT32 SPLINK SPTabletFree(pSPTABLET_T *ppTablet);

/**
 * @brief Get the driver ID of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piDriver [o]
 *      pointer to a variable that will be filled with the
 *      driver ID used by the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32)
 * @see SPTabletCreate, SPTabletSetDriver
 */
SPEXTERN SPINT32 SPLINK SPTabletGetDriver(pSPTABLET_T pTablet, SPINT32 *piDriver);

/**
 * @brief Set the driver ID of an SPTablet object.
 *
 * The driver ID is set during initialization and should not be
 * overwritten unless you know what you do.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @param iDriver [i] new driver identifier.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32)
 * @see SPTabletCreate, SPTabletGetDevice, SPTabletGetDriverStr
 */
SPEXTERN SPINT32 SPLINK SPTabletSetDriver(pSPTABLET_T pTablet, SPINT32 iDriver);

/**
 * @brief Get the device ID of an SPTablet object.
 *
 * Wacom drivers do not pass information about the connected devices, the
 * detected device may differ from the physically connected tablet. SPTablet
 * uses the size of the device to identify the connected model.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piDevice [o]
 *      pointer to a variable that will be filled with the tablet device ID
 *      from the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetDeviceStr, SPTabletGetDriver, SPTabletSetDevice
 */
SPEXTERN SPINT32 SPLINK SPTabletGetDevice(pSPTABLET_T pTablet, SPINT32 *piDevice);

/**
 * @brief Set the device ID of an SPTablet object.
 *
 * The device ID is set during initialization and should not be
 * overwritten unless you know what you do.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @param iDevice [i] new device identifier.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetDevice
 */
SPEXTERN SPINT32 SPLINK SPTabletSetDevice(pSPTABLET_T pTablet, SPINT32 iDevice);

/**
 * @brief Get the hardware file name of an SPTablet object.
 *
 * The hardware file name equals the name that was used to connect
 * to the device. Serial Connections use "\\.\COMi" (i equals the COM port number),
 * USB file names are composed of the device id, manufacturer id like
 * "\\?\hid#vid_056a&pid_00a1#6&37604930&0&0000#{4d1e55b2-f16f-11cf-88cb-001111000030}".
 * <br> Normally SPTabletGetHardwareName is not needed, but if the application must repeatedly 
 * address a specific device then you may want to check the hardware name,
 * see @ref pg_PadInstallation.
 * @note Hardware file names are supported by Wacom SignPad devices.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pszHardwareName [io]
 *      pointer to a buffer that will be filled with the hardware file name
 *      from the SPTablet object, the buffer size should be at least 256 bytes.
 * @param iHardwareNameLen [i] size of the buffer [bytes]
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR  invalid parameter
 *   - @ref SP_MEMERR    buffer is too small
 *   - @ref SP_UNSUPPORTEDERR  hardware name is not supported by the device
 *   .
 * @par Operating Systems:
 *      Windows (Win32)
 * @since SignWare V 2.5
 * @see SPTabletCreate
 * @todo Implement for Linux
 */
SPEXTERN SPINT32 SPLINK SPTabletGetHardwareName(pSPTABLET_T pTablet, SPCHAR *pszHardwareName, SPINT32 iHardwareNameLen);

/**
 * @brief Get the resolution of an SPTablet object.
 *
 * By default, the resolution is set to 300 DPI.
 *
 * Tablets have a resolution defined by the physical resolution in the
 * tablet hardware. The SPTablet implementation 'resamples' the vectors and
 * transforms each vector to the given resolution. The absolute position
 * of the pen is calculated by the tablet coordinate * 25.4 / iResolution.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piResolution [o]
 *      pointer to a variable that will be filled with the
 *      resolution (in DPI) of the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletSetResolution, SPSignatureGetResolution
 */
SPEXTERN SPINT32 SPLINK SPTabletGetResolution(pSPTABLET_T pTablet, SPINT32 *piResolution);

/**
 * @brief Set the resolution of an SPTablet object.
 *
 * The resolution is set during initialization and should not be
 * overwritten unless you know what you do.
 *
 * Tablets have a resolution defined by the physical resolution in the
 * tablet hardware. The SPTablet implementation 'resamples' the vectors and
 * transforms each vector to the given resolution. The absolute position
 * of the pen is calculated by the tablet coordinate * 25.4 / iResolution.
 *
 * @param pTablet [i]     pointer to an SPTablet object.
 * @param iResolution [i] new resolution (in DPI).
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetResolution, SPSignatureSetResolution
 */
SPEXTERN SPINT32 SPLINK SPTabletSetResolution(pSPTABLET_T pTablet, SPINT32 iResolution);

/**
 * @brief Get the sample rate of an SPTablet object.
 *
 * Wacom tablets always return a sample rate of 100 Hz though the real
 * sample rate may differ. @ref SPTabletAcquireDone attempts to
 * compute the real sample rate; this function will return the computed
 * sample rate after SPTabletAcquireDone has been called.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piSampleRate [o]
 *      pointer to a variable that will be filled with the
 *      sample rate (in Hz) of the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetSampleRate, SPTabletAcquireDone, SPSignatureGetSampleRate, SPSignatureSetSampleRate
 */
SPEXTERN SPINT32 SPLINK SPTabletGetSampleRate(pSPTABLET_T pTablet, SPINT32 *piSampleRate);

/**
 * @brief Set the sample rate of an SPTablet object.
 *
 * The sample rate is set during initialization and should not be
 * overwritten unless you know what you do.
 *
 * @note Most tablet drivers ignore the sample rate parameter.<br>
 *       Solution: Wait for a driver update that supports sample
 *       rate adjustment.
 *
 * @param pTablet [i]     pointer to an SPTablet object.
 * @param iSampleRate [i] the new sample rate (in Hz).
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetSampleRate, SPSignatureSetSampleRate
 */
SPEXTERN SPINT32 SPLINK SPTabletSetSampleRate(pSPTABLET_T pTablet, SPINT32 iSampleRate);

/**
 * @brief Get the pressure range of an SPTablet object.
 *
 * The maximum pressure value is read from the capabilities of the tablet
 * used by the SPTablet object. The pressure values of the signature data
 * are normalized to the range 0 through 1023.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piMaxPressure [o]
 *      pointer to a variable that will be filled with the maximum pressure
 *      value of the tablet used by the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetMaxPressure, SPSignatureGetMaxPressure
 */
SPEXTERN SPINT32 SPLINK SPTabletGetMaxPressure(pSPTABLET_T pTablet, SPINT32 *piMaxPressure);

/**
 * @brief Set the pressure range of an SPTablet object.
 *
 * The maximum pressure value is set during initialization and
 * should not be overwritten unless you know what you do.
 *
 * @param pTablet [i]      pointer to an SPTablet object.
 * @param iMaxPressure [i] new maximum pressure value.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetMaxPressure, SPSignatureSetMaxPressure
 */
SPEXTERN SPINT32 SPLINK SPTabletSetMaxPressure(pSPTABLET_T pTablet, SPINT32 iMaxPressure);

/**
 * @brief Get the tablet serial ID of an SPTablet object.
 *
 * The size of a tablet serial ID is limited to 20 bytes within the
 * SignWare data structures, more limitations may apply depending on the tablet.
 *
 * Tablets that support serial ID's:
 *   - Wacom Signpad series (STU-300, STU-500): The serial ID is limited to a
 *     4 digit hex number, the parameter pbPadSerial is passed as a 8-digit hex string, 
 *     range '0' ... 'FFFFFFFF'. Note that leading zero's are truncated.
 *     <br> Tablets are delivered with a serial number is set to '0', the application may 
 *     pass a serial number (see @ref SPTabletSetPadSerial).
 *   .
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pbPadSerial [o]
 *      pointer to an array of bytes that will be filled with the serial
 *      ID of the tablet used to capture the signature contained in the
 *      SPSignature object.
 * @param piPadSerialLength [io]
 *      pointer to a variable that contains the size (in bytes) of the
 *      buffer pointed to by @a pbPadSerial. That variable will be filled
 *      with the number of bytes written to the buffer.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetPadSerial, SPSignatureGetPadSerial
 * 
 */
SPEXTERN SPINT32 SPLINK SPTabletGetPadSerial(pSPTABLET_T pTablet, SPUCHAR *pbPadSerial, SPINT32 *piPadSerialLength);

/**
 * @brief Set the tablet serial ID of an SPTablet object.
 *
 * The size of a tablet serial ID is limited to 20 bytes within the
 * SignWare data structures, more limitations may apply depending on the tablet.
 * 
 * Tablets that support serial ID's:
 *   - Wacom Signpad series (STU-300, STU-500): The serial ID is limited to a
 *     4 digit hex number, the parameter pbPadSerial is passed as a 8-digit hex string, 
 *     range '0' ... 'FFFFFFFF'. Note that leading zero's are truncated.
 *     <br> Tablets are delivered with a serial number is set to '0', the application may 
 *     pass a serial number.
 *   .
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pbPadSerial [i]
 *      pointer to an array of bytes that contains the tablet serial ID.
 * @param iPadSerialLength [i]
 *      the size (in bytes) of the tablet serial ID pointed to by
 *      @a pbPadSerial.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetPadSerial, SPSignatureSetPadSerial
 */
SPEXTERN SPINT32 SPLINK SPTabletSetPadSerial(pSPTABLET_T pTablet, const SPUCHAR *pbPadSerial, SPINT32 iPadSerialLength);

/**
 * @brief Get the tablet size of an SPTablet object.

 * To convert from tablet coordinates to mm, use this formula:
 * @code
 * tablet_size_mm = tablet_coordinate / (SPTabletGetResolution(pTablet) * 25.4)
 * @endcode
 *
 * @note @ref SPTabletGetTabletSize returns the size of the tablet in tablet coordinates, @ref SPTabletGetPhysicalSize
 * returns the size of the tablet in mm.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piWidth [o]
 *      pointer to a variable that will be filled with the
 *      width (in tablet coordinates) of the tablet used by the
 *      SPTablet object.
 * @param piHeight [o]
 *      pointer to a variable that will be filled with the
 *      height (in tablet coordinates) of the tablet used by the
 *      SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetTabletSize, SPTabletGetPhysicalSize
 */
SPEXTERN SPINT32 SPLINK SPTabletGetTabletSize(pSPTABLET_T pTablet, SPINT32 *piWidth, SPINT32 *piHeight);

/**
 * @brief Get the tablet size of an SPTablet object.
 *
 * @note @ref SPTabletGetTabletSize returns the size of the tablet in tablet coordinates, @ref SPTabletGetPhysicalSize
 * returns the size of the tablet in mm.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piWidth [o]
 *      pointer to a variable that will be filled with the
 *      width (in mm) of the tablet used by the SPTablet object.
 * @param piHeight [o]
 *      pointer to a variable that will be filled with the
 *      height (in mm) of the tablet used by the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetTabletSize
 */
SPEXTERN SPINT32 SPLINK SPTabletGetPhysicalSize(pSPTABLET_T pTablet, SPINT32 *piWidth, SPINT32 *piHeight);

/**
 * @brief Set the tablet size of an SPTablet object.
 *
 * The tablet size is set during initialization and should not be
 * overwritten unless you know what you do.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @param iWidth [i]  new tablet width (in tablet coordinates).
 * @param iHeight [i] new tablet height (in tablet coordinates).
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate SPTabletGetTabletSize
 */
SPEXTERN SPINT32 SPLINK SPTabletSetTabletSize(pSPTABLET_T pTablet, SPINT32 iWidth, SPINT32 iHeight);

/**
 * @brief Query the tablet type
 *
 * The tablet size is set during initialization and cannot be overwritten.
 * 
 * The tablet type defines some special behaviour of e. g. standalone tablets.
 * 
 * The application should display a wait indicator instead of the realtime 
 * signature strokes, if @ref SP_TABLET_NO_REALTIME_VECTORS is set.
 * 
 * The application should register a hardware button listener to process
 * virtual buttons, if @ref SP_TABLET_HARDWARE_AS_VIRTUAL_BUTTONS is set,
 * see @ref pSPTABLETBUTTON_T.
 * 
 * @param pTablet [i] pointer to an SPTablet object.
 * @param piType [o] pointer to an integer that will be set to the tablet type
 * 
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_NOPADERR      no tablet assigned to this object
 *   .
 * 
 * @par Operating Systems:
 *      Windows (Win32)
 * 
 * @see SP_TABLET_NO_REALTIME_VECTORS, SP_TABLET_HARDWARE_AS_VIRTUAL_BUTTONS, pSPTABLETBUTTON_T
 * 
 * @since SignWare V 2.6.2
 */
SPEXTERN SPINT32 SPLINK SPTabletGetTabletType(pSPTABLET_T pTablet, SPINT32 *piType);

/**
 * @brief Get the timestamp of the signature. most recently acquired by
 *        an SPTablet object.
 *
 * The timestamp can be retrieved after calling @ref SPTabletAcquire
 * until @ref SPTabletDisconnect is called.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param puTimeStamp [o]
 *      pointer to a variable  that will be filled with the timestamp
 *      (seconds since 1970-01-01 00:00:00 UTC) of the
 *      signature most recently acquired by the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletAcquire, SPTabletCreate, SPTabletDisconnect
 */
SPEXTERN SPINT32 SPLINK SPTabletGetTimeStamp(pSPTABLET_T pTablet, SPUINT32 *puTimeStamp);

/**
 * @brief Set listeners of an SPTablet object.
 *
 *
 * The SPTablet object calls the listener that was registered last. Call
 * SPTabletSetListener(0, 0, 0) to deregister any listeners.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pStartNotify [i]
 *      function to be called before calling @a pLineTo for the first
 *      vector of a set of vectors. NULL if no notification is needed.
 * @param pLineTo [i]
 *      function to be called for each tablet vector (sample). The function pointer
 *      may be NULL to deregister the event listeners
 * @param pEndNotify [i]
 *      function to be called after calling @a pLineTo for the last
 *      vector of a set of vectors (at the time the function is called,
 *      the tablet is not sending vectors). NULL if no notification is needed.
 *
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetListeners(pSPTABLET_T pTablet, pSPSTARTNOTIFY_T pStartNotify, pSPLINETO_T pLineTo, pSPENDNOTIFY_T pEndNotify);

/**
 * @brief Set listeners of an SPTablet object.
 *
 *
 * The SPTablet object calls the listener that was registered last. Call
 * SPTabletSetListener(0, 0, 0) to deregister any listeners.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pStartNotify [i]
 *      function to be called before calling @a pLineTo for the first
 *      vector of a set of vectors. NULL if no notification is needed.
 * @param pLineTo [i]
 *      function to be called for each tablet vector (sample). The function pointer
 *      may be NULL to deregister the event listeners
 * @param pEndNotify [i]
 *      function to be called after calling @a pLineTo for the last
 *      vector of a set of vectors (at the time the function is called,
 *      the tablet is not sending vectors). NULL if no notification is needed.
 *
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetListeners2(pSPTABLET_T pTablet, pSPSTARTNOTIFY_T pStartNotify, pSPLINETO2_T pLineTo, pSPENDNOTIFY_T pEndNotify);

/**
 * @brief Set the hardware button listener of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pNotifyButton [i]
 *      function that is to be called when a hardware button of the tablet
 *      is pressed. The function pointer may be NULL to deregister all button event listeners.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetButtonListener(pSPTABLET_T pTablet, pSPTABLETBUTTON_T pNotifyButton);

/**
 * @brief Set the hardware status listener of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pNotifyStatus [i]
 *      function that is to be called when a hardware status of the tablet changes. the function
 *      pointer may be NULL to deregister all status event listeners.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see pSPTABLETSTATUS_T 
 */
SPEXTERN SPINT32 SPLINK SPTabletSetStatusListener(pSPTABLET_T pTablet, pSPTABLETSTATUS_T pNotifyStatus);

/**
 * @brief Set the tablet flags for acquiry mode of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iFlags [i]
 *      a bitwise combination of these flags:
 *      - @ref SP_ACQUIRE_TRANSFER_0_VECTORS
 *      - @ref SP_ACQUIRE_RETURN_IMMEDIATELY
 *      - @ref SP_DONT_ECHO_STROKES
 *      - @ref SP_SYNCHRONOUS_START_ACQUIRE
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_NOPADERR      no tablet assigned
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetListeners
 */
SPEXTERN SPINT32 SPLINK SPTabletSetFlags(pSPTABLET_T pTablet, SPINT32 iFlags);

/**
 * @brief Get the tablet flags for acquiry mode of an SPTablet object.
 *
 * By default, the flags are set to SP_ACQUIRE_RETURN_IMMEDIATELY, that is:
 *      - do not transfer 0 pressure vectors
 *      - SPTabletAcquire returns immediately
 *      - strokes are echoed
 *      - SPTabletAcquire does not wait until the tablet enters acquire state
 *      .
 *
 * @note SP_ACQUIRE_RETURN_IMMEDIATELY is set internally.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piFlags [i]
 *      pointer to a variable that will be filled with the current set
 *      of flags (see @ref SPTabletSetFlags):
 *      - @ref SP_ACQUIRE_TRANSFER_0_VECTORS
 *      - @ref SP_ACQUIRE_RETURN_IMMEDIATELY, always set
 *      - @ref SP_DONT_ECHO_STROKES
 *      - @ref SP_SYNCHRONOUS_START_ACQUIRE
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_NOPADERR      no tablet assigned
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetFlags
 */
SPEXTERN SPINT32 SPLINK SPTabletGetFlags(pSPTABLET_T pTablet, SPINT32 *piFlags);

/**
 * @brief Query the display type of the tablet used by this SPTablet object
 *
 * SPTablet differentiates 3 types of tablet displays
 *      - SP_TABLET_NO_DISPLAY: tablets without a screen (such as Wacom Intuos)
 *      - SP_TABLET_LCD_DISPLAY: tablets with an integrated LCD screen (such as Wacom Signpad)
 *      - SP_TABLET_PC_DISPLAY: PCs with integrated tablet functionality (such as TabletPC)
 *      .
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piDisplayType [o]
 *      pointer to a variable that will be filled with the display type of the tablet
 *          - @ref SP_TABLET_NO_DISPLAY
 *          - @ref SP_TABLET_LCD_DISPLAY
 *          - @ref SP_TABLET_PC_DISPLAY
 *          .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_NOPADERR      no tablet assigned
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @since SignWare V 2.5
 * @see SPTabletSetDisplayType
 */
SPEXTERN SPINT32 SPLINK SPTabletGetDisplayType(pSPTABLET_T pTablet, SPINT32 *piDisplayType);

/**
 * @brief Set the display type of the tablet used by this SPTablet object
 *
 * SPTablet differentiates 3 types of tablet displays
 *      - SP_TABLET_NO_DISPLAY: tablets without a screen (such as Wacom Intuos)
 *      - SP_TABLET_LCD_DISPLAY: tablets with an integrated LCD screen (such as Wacom Signpad)
 *      - SP_TABLET_PC_DISPLAY: PCs with integrated tablet functionality (such as TabletPC)
 *      .
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iDisplayType [i]
 *      the display type of the tablet
 *          - @ref SP_TABLET_NO_DISPLAY
 *          - @ref SP_TABLET_LCD_DISPLAY
 *          - @ref SP_TABLET_PC_DISPLAY
 *          .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_NOPADERR      no tablet assigned
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @since SignWare V 2.5
 * @see SPTabletGetDisplayType
 */
SPEXTERN SPINT32 SPLINK SPTabletSetDisplayType(pSPTABLET_T pTablet, SPINT32 iDisplayType);

/**
 * @brief Get the size of the LCD of the tablet used by an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piWidth [io]
 *      pointer to a variable that will be filled with the
 *      width (in pixels) of the LCD.
 * @param piHeight [io]
 *      pointer to a variable that will be filled with the
 *      height (in pixels) of the LCD.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetLCD, SPTabletSetBackgroundImage
 */
SPEXTERN SPINT32 SPLINK SPTabletGetLCDSize(pSPTABLET_T pTablet, SPINT32 *piWidth, SPINT32 *piHeight);

/**
 * @brief Get the offset of the LCD of the tablet used by an SPTablet object.
 *
 * The offset is typically 0, however full screeen devices may be operated in multi monitor 
 * configurations, that may result in a screen offset.
 * <br> The operating system handles all monitors as one virtual display, each monitor might be offset
 * within the virtual display, see MSDN 'Multiple Display Monitors'.
 *
 * @note The sensitive monitor must be the primary monitor or must be configured as a separate display (dual view),
 * else the tablet will not be usable.
 * <br> The tablet vectors are transformed to match the virtual screen coordinates, but the tablet size equals
 * the physical dimension of the sensitive monitor!
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piOffsetX [io]
 *      pointer to a variable that will be filled with the
 *      x-offset (in pixels) of the LCD.
 * @param piOffsetY [io]
 *      pointer to a variable that will be filled with the
 *      y-offset (in pixels) of the LCD.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetLCDSize
 */
SPEXTERN SPINT32 SPLINK SPTabletGetLCDOffset(pSPTABLET_T pTablet, SPINT32 *piOffsetX, SPINT32 *piOffsetY);

/**
 * @brief Get the bit depth of the LCD of the tablet
 * 
 * The currently supported tabletts with external LCD have 1 bit per pixel,
 * black/white screens.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piBitsPerPixel [io]
 *      pointer to a variable that will be filled with the
 *      bits per pixel of the LCD.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletGetLCDBitsPerPixel(pSPTABLET_T pTablet, SPINT32 *piBitsPerPixel);

/**
 * @brief Set a tablet parameter
 * 
 * Options can only be passed to the tablet when the tablet is in state @ref SP_TABLET_STATE_CONNECT.
 * 
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pszName [i] the name / identifier of the option to set, must be one of the following:
 *     - "BackgroundColor" the background color of the tablet display. The color format
 *        is 0xrrggbb where rr equals the red color component, gg equals the green color component
 *        and bb equals the blue color component, each component in the range 0 .. 255.
 *        <br> Currently only supported on Signpad STU-520
 *     - "ForegroundColor" the foreground color of the tablet display, pen strokes are drawn in
 *        foreground color. The color format
 *        is 0xrrggbb where rr equals the red color component, gg equals the green color component
 *        and bb equals the blue color component, each component in the range 0 .. 255.
 *        <br> Currently only supported on Signpad STU-520
 *     - "PenThickness" Pen thickness is used to render strokes on the tablet LCD. The pen thickness
 *        has a range 1 .. 255, where 1 produces a thin stroke and 255 produces a bold line.
 *        The number of steps is limited by the tablet hardware.
 *        <br> Currently only supported on Signpad STU-520. STU-520 supports 3 stroke types,
 *        thin (1 ... 85), middle (86 ... 170) and bold (171 .. 255).
 *     - "IdleTimeout" the entered signature will be accepted when iValue [msecs] have passed 
 *        after the last stroke.
 *        <br> Currently only supported on Verifone MX 800 series
 *     .
 * @param iValue [i] Value of the addressed option
 *
 * @return @ref SP_NOERR on success, else error code:
 *     - @ref SP_PARAMERR      invalid parameter
 *     - @ref SP_UNSUPPORTEDERR  unsupported for the device
 *     .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetTabletOption(pSPTABLET_T pTablet, const SPCHAR *pszName, SPINT32 iValue);

/**
 * @brief Set the clipping rectangle for the tablet display
 * 
 * Strokes outside the clipping rectangle will not be drawn on the tablet screen.
 * <br> Currently only supported on Signpad STU-520.
 * 
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iLeft [i] left coordinate of the signature entry region, in ppm (1/1000, thousands)
 * @param iTop [i] top coordinate of the signature entry region, in ppm (1/1000, thousands)
 * @param iRight [i] right coordinate of the signature entry region, in ppm (1/1000, thousands)
 * @param iBottom [i] bottom coordinate of the signature entry region, in ppm (1/1000, thousands)
 *
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_UNSUPPORTEDERR  unsupported for the device
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetClipRectangle(pSPTABLET_T pTablet, SPINT32 iLeft, SPINT32 iTop, SPINT32 iRight, SPINT32 iBottom);

/**
 * @brief Get the optional user parameter of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param plUserLong [o]
 *      pointer to a variable that will be filled with the user parameter
 *      of the SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletSetUserLong
 */
SPEXTERN SPINT32 SPLINK SPTabletGetUserLong(pSPTABLET_T pTablet, SPVPTR *plUserLong);

/**
 * @brief Set the optional user parameter of an SPTablet object.
 *
 * The optional user parameter is not used inside SignWare, you may
 * add one additional void pointer parameter for application purposes.
 *
 * @param pTablet [i]   pointer to an SPTablet object.
 * @param lUserLong [i] application-specific parameter.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetUserLong
 */
SPEXTERN SPINT32 SPLINK SPTabletSetUserLong(pSPTABLET_T pTablet, SPVPTR lUserLong);

/**
 * @brief Put an SPTablet object into acquiry mode.
 *
 * This function enables acquiry mode and sends all vectors (samples) from
 * the tablet to the registered listener.
 * <br>Tablet PC and Cintiq devices will be exclusively locked for any other SignWare processes
 * until acquiry mode will be terminated (see @ref SPTabletAcquireDone).
 *
 * If @ref SP_ACQUIRE_TRANSFER_0_VECTORS is set, all vectors having a pressure
 * value of 0 will be sent; if SP_ACQUIRE_TRANSFER_0_VECTORS is not set,
 * only one vector having a pressure value of 0 will be sent for a sequence
 * of vectors having a pressure level of 0.
 *
 * This function will return immediately if @ref SP_ACQUIRE_RETURN_IMMEDIATELY
 * is set. If SP_ACQUIRE_RETURN_IMMEDIATELY is not set, this function will
 * block until @ref SPTabletAcquireDone is called.
 *
 * @note Acquire mode may be dispatched and activated within the message processing thread (this
 * restriction is required by some tablet drivers, e. g. MS TabletPC). This means that errors
 * that occur while processing the state switch may not be passed to the application.
 * <br> The application may set a timer to check the state of theis object, the state will be
 * SP_TABLET_STATE_ACQUIRE on success.
 *
 * @param pTablet [i]    pointer to an SPTablet object.
 * @param hwndParent [i] parent window handle or NULL.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR           invalid parameter
 *   - @ref SP_UNSUPPORTEDERR     tablet not accessible
 *   - @ref SP_BUSYERR            the device is used by another application
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletAcquireDone, SPTabletCreate, SPTabletSetFlags
 */
SPEXTERN SPINT32 SPLINK SPTabletAcquire(pSPTABLET_T pTablet, SPHWND hwndParent);

/**
 * @brief Terminate acquiry mode of an SPTablet object.
 *
 * This function terminates acquiry mode, the device state changes to the
 * connect state (see @ref SPTabletGetState).
 * <br> TabletPC and Wacom PL-400 / Cintiq devics release the device lock.
 * <br>Wacom tablets always return a sample rate of 100 Hz though the real
 * sample rate may differ. This function attempts to
 * compute the real sample rate, the computed sample rate can be retrieved
 * with @ref SPTabletGetSampleRate. You should set the sample rate of the
 * signature to the computed sample rate.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletAcquire, SPTabletGetSampleRate, SPGuiAcquAcquireDone, SPSignatureSetSampleRate
 */
SPEXTERN SPINT32 SPLINK SPTabletAcquireDone(pSPTABLET_T pTablet);

/**
 * @brief Connect an SPTablet object to a tablet.
 *
 * This function establishes a connection to a tablet. The state changes from idle to connect (see @ref SPTabletGetState)
 * <br>The device will be exclusively locked for any other SignWare processes until the device
 * will be disconnected, unless it is a TabletPC or a Wacom PL-400 / Cintiq device.
 *
 * This is a license-restricted function. Please pass a charged ticket
 * when using the ticket license model.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR          invalid parameter
 *   - @ref SP_UNSUPPORTEDERR    tablet not accessible
 *   - @ref SP_BUSYERR           the device is used by another application
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate , SPTabletDisconnect, SPTabletSetTicket, SPSignwareSetTicket
 */
SPEXTERN SPINT32 SPLINK SPTabletConnect(pSPTABLET_T pTablet);

/**
 * @brief Disconnect a tablet from an SPTablet object.
 *
 * This function terminates a connection to a tablet. The state changes from connect to idle (see @ref SPTabletGetState)
 * <br> the device lock will be released (TabletPC and Wacom PL-400 / Cintiq
 * devics free the lock in APTabletAcquireDone).
 * <br> The idle image will be loaded on devices that support idle images (see @ref SPTabletSetBackgroundImage2).
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_UNSUPPORTEDERR     tablet not accessible
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletConnect, SPTabletSetBackgroundImage2
 */
SPEXTERN SPINT32 SPLINK SPTabletDisconnect(pSPTABLET_T pTablet);

/**
 * @brief Get the proximity capability of an SPTablet object.
 *
 * Devices that do not support proximity don't send the current pen position
 * as long as the pen is up. Special care must therefore be taken when drawing
 * the first vector (sample) having a non-zero pressure value.
 * The SPTablet object will insert a vector having a pressure value of 0
 * and the coordinates of the first vector having a non-zero pressure value
 * to inform all listeners on the current pen position for these devices.
 *
 * These tablets support proximity:
 *      - @ref SP_INTUOS_DEV
 *      - @ref SP_GRAPHIRE_DEV
 *      - @ref SP_PENPARTNER_DEV
 *      - @ref SP_PL400_DEV
 *      - @ref SP_SIGNPAD_DEV
 *      - @ref SP_BAMBOO_DEV
 *      - @ref SP_TABLETPC_DEV
 *      .
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piProximity [o]
 *      pointer to a variable that will be filled with the proximity
 *      capability of the tablet used by the SPTablet object:
 *      - 0: the tablet sends vectors only while the pen touches the tablet
 *      - 1: the tablet sends vectors when the pen is raised (up to 5 mm)
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletHasProximity(pSPTABLET_T pTablet, SPINT32 *piProximity);

/**
 * @cond LINUX
 */
/**
 * @brief Get the number of XInputDevices when using the X Window System.
 *
 * This function gives you the number of properly configured
 * XInputDevices in the XFree configuration file (normaly
 * /etc/X11/XF86Config).
 *
 * @param piCount [o]
 *      pointer to a variable that will be filled with the number of
 *      available XInputDevices.
 *
 * @return @ref SP_NOERR on success, else error code
 * @par Operating Systems:
 *      Linux (i386), Linux (x86_64)
 * @see SPTabletGetXInputDeviceName
 * @todo Fix and document return values.
 */
SPEXTERN SPINT32 SPLINK SPTabletGetXInputDeviceCount(SPINT32* piCount);

/**
 * @brief Get the name of an XInputDevice when using the X Window System.
 *
 * @param iIndex [i]
 *      index specifying the XInputDevice
 * @param ppszName [o]
 *      pointer to a variable that will be filled with a pointer to a
 *      null-terminated string containing the name of the device
 *      selected by @a iIndex. Do @em not modify and do @em not deallocate
 *      that string.
 * @return @ref SP_NOERR on success, else error code
 * @par Operating Systems:
 *      Linux (i386), Linux (x86_64)
 * @see SPTabletGetXInputDeviceCount
 * @todo Fix and document return values.
 */
SPEXTERN SPINT32 SPLINK SPTabletGetXInputDeviceName(SPINT32 iIndex, SPCHAR** ppszName);
/**
 * @endcond LINUX
 */

/**
 * @brief Set the background image of an SPTablet object.
 *
 * The tablet used by the SPTablet object must have an LCD.
 *
 * The image will be converted to the format required by the
 * tablet. This includes size and color-depth conversions, however the
 * conversion may be lossy. It is therefore recommended to create the
 * image using the size and color depth of the tablet LCD and in a format
 * that is directly supported by the device.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pbImageData [i]
 *      pointer to the image. Most standard image formats such as
 *      BMP, TIF, JPG, GIF, and CCITT4 are supported.
 * @param iImageDataLen [i]
 *      length (in bytes) of the buffer pointed to by @a pbImageData.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter or the image could not be decoded
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @ref SPTabletHasExternalLCD
 */
SPEXTERN SPINT32 SPLINK SPTabletSetBackgroundImage(pSPTABLET_T pTablet, const SPUCHAR *pbImageData, SPINT32 iImageDataLen);

/**
 * @brief Set the background image of an SPTablet object.
 *
 * The tablet used by the SPTablet object must have an LCD.
 *
 * The image will be converted to the format required by the
 * tablet. This includes size and color-depth conversions, however the
 * conversion may be lossy. It is therefore recommended to create the
 * image using the size and color depth of the tablet LCD and in a format
 * that is directly supported by the device.
 *
 * Not all tablets support displaying idle images; currently only Wacom
 * SignPad tablets support a background image that will be displayed
 * in idle mode (more precise whenever the application disconnects the device
 * (SPTabletDisconnect)).
 * <br>Not all tablets support displaying immediate images; currently only Wacom
 * SignPad tablets support immediate images that will be displayed immediately.
 *
 * @note Immediate images cannot be displayed in acquiry mode.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iImFlags [i]
 *      image destination:
 *      - @ref SP_ACTIVE_IMAGE      image displayed in acquiry mode
 *      - @ref SP_IDLE_IMAGE        image displayed in idle mode
 *      - @ref SP_IMMEDIATE_IMAGE   image displayed immediately
 *      .
 * @param pbImageData [i]
 *      pointer to the image. Most standard image formats such as
 *      BMP, TIF, JPG, GIF, and CCITT4 are supported.
 * @param iImageDataLen [i]
 *      length (in bytes) of the buffer pointed to by @a pbImageData.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter or the image could not be decoded
 *      - @ref SP_APPLERR            wrong state, the image cannot be transferred
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetBackgroundImage2(pSPTABLET_T pTablet, SPINT32 iImFlags, const SPUCHAR *pbImageData, SPINT32 iImageDataLen);

/**
 * @brief Clear the background image of an SPTablet object.
 *
 * The tablet used by the SPTablet object must have an LCD.
 *
 * Not all tablets support displaying idle images; currently only Wacom
 * SignPad tablets support a background image that will be displayed
 * in idle mode (more precise whenever the application disconnects the device
 * (SPTabletDisconnect)).
 * <br>Not all tablets support displaying immediate images; currently only Wacom
 * SignPad tablets support immediate images that will be displayed immediately.
 *
 * @note Immediate images cannot be displayed in acquiry mode.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iImFlags [i]
 *      image destination:
 *      - @ref SP_ACTIVE_IMAGE      image displayed in acquiry mode
 *      - @ref SP_IDLE_IMAGE        image displayed in idle mode
 *      - @ref SP_IMMEDIATE_IMAGE   image displayed immediately
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_UNSUPPORTEDERR     the tablet does not support images
 *      - @ref SP_PARAMERR           invalid parameter or the image could not be decoded
 *      - @ref SP_APPLERR            wrong state, the image cannot be transferred
 *      - @ref SP_LINKLIBRARYERR     external modules could not be loaded
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletClearBackgroundImage(pSPTABLET_T pTablet, SPINT32 iImFlags);

/**
 * @brief Pass a license ticket for the next signature capture(s).
 *
 * When using the ticket license model, you must pass the ticket
 * before you connect with the tablet.
 * This function copies the SPTicket object.
 *
 * The ticket must be charged for usage @ref SP_TICKET_CAPTURE.
 *
 * @param pTablet [i] pointer to an SPTablet object.
 * @param pTicket [i] pointer to a charged SPTicket object.
 *
 * @return @ref SP_NOERR on success, else error code
 * @deprecated Replaced by @ref SPSignwareSetTicket.
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTicketCharge
 */
SPEXTERN SPINT32 SPLINK SPTabletSetTicket(pSPTABLET_T pTablet, pSPTICKET_T pTicket);

/**
 * @brief Reset all tablet drivers.
 *
 * This will unload all tablet drivers and reset the internal states
 * to "unconnected".
 * The next request for a tablet operation will reload the drivers.
 *
 * @note Normally, you should not call this function unless there is a
 *      special condition that requires a full reset such as reconnecting
 *      a device to a different port.
 *
 * @param bReset [i] must be true
 * @return @ref SP_NOERR on success, else error code
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletReset(SPBOOL bReset);

/**
 * @brief Get the name of a tablet driver.
 *
 * The buffer should have a size of at least 256 bytes.
 * <br> The required buffer size will be returned when SPTabletGetDriverStr is called with parameter
 * pszName set to NULL.
 *
 * @param iDriverId [i]
 *      driver identification as returned by @ref SPTabletGetDriver.
 * @param pszName [io]
 *      pointer to a buffer that will be filled with the name of the driver.
 * @param iNameLen [i]
 *      length (in bytes) of the buffer pointed to by @a pszName.
 * @return the required buffer size if pszName is NULL, or @ref SP_NOERR on success, else error code:
 *      - @ref SP_PARAMERR           invalid parameter, buffer too small
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetDeviceStr, SPTabletGetDriver
 * @todo Don't return "Wintab" under Linux
 *
 * @par Example:
@code
// Query the driver name (dynamically allocated buffer)
char *QueryTabletDriverName(int iDriver)
{
    char *pszName = 0;
    // Query the size of the required buffer
    int rc = SPTabletGetDriverStr(iDriver, NULL, 0);
    pszName = malloc(rc);
    rc = SPTabletGetDriverStr(iDriver, pszName, rc);
    if(rc == SP_NOERR) return pszName;
    return NULL;
}
@endcode
 *
 */
SPEXTERN SPINT32 SPLINK SPTabletGetDriverStr(SPINT32 iDriverId, SPCHAR *pszName, SPINT32 iNameLen);

/**
 * @brief Get the name of the tablet device.
 *
 * The buffer should have a size of at least 256 bytes.
 * <br> The required buffer size will be returned when SPTabletGetDeviceStr is called with parameter
 * pszName set to NULL.
 *
 * @param iDeviceId [i]
 *      device identification as returned by @ref SPTabletGetDevice.
 * @param pszName [io]
 *      pointer to a buffer that will be filled with the name of the device.
 * @param iNameLen [i]
 *      length (in bytes) of the buffer pointed to by @a pszName.
 * @return the required buffer size if pszName is NULL, or @ref SP_NOERR on success, else error code:
 *      - @ref SP_PARAMERR           invalid parameter, buffer too small
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @par Example:
@code
// Query the device name (dynamically allocated buffer)
char *QueryTabletDeviceName(int iDevice)
{
    char *pszName = 0;
    // Query the size of the required buffer
    int rc = SPTabletGetDeviceStr(iDevice, NULL, 0);
    pszName = malloc(rc);
    rc = SPTabletGetDeviceStr(iDevice, pszName, rc);
    if(rc == SP_NOERR) return pszName;
    return NULL;
}
@endcode
 */
SPEXTERN SPINT32 SPLINK SPTabletGetDeviceStr(SPINT32 iDeviceId, SPCHAR *pszName, SPINT32 iNameLen);

/**
 * @brief Get the state of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piState [o]
 *      pointer to a variable that will be filled with the state:
 *      - @ref SP_TABLET_STATE_IDLE
 *      - @ref SP_TABLET_STATE_CONNECT
 *      - @ref SP_TABLET_STATE_ACQUIRE
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_PARAMERR           invalid parameter
 *      - @ref SP_NOPADERR no tablet assigned to the object
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletGetState(pSPTABLET_T pTablet, SPINT32 *piState);

/**
 * @brief Reload the tablet characteristics
 *
 * Tablet characteristics are typically bound to the hardware and do
 * not change, except for TabletPCs where the screen resolution or screen
 * orientation might change. Both screen resolution and orientation must
 * be considered to calculate the physical tablet width / height and tablet LCD
 * width and height.
 *
 * Applications that support display resolution or orientation changes
 * while acquiring a signature should call SPTabletReloadParameters
 * while or after processing the WM_DISPLAYCHANGE message, see example below.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @return @ref SP_NOERR on success, else error code:
 *      - @ref SP_NOPADERR no tablet assigned to the object
 *      - @ref SP_APPLERR wrong state, SPTabletReloadParameters cannot be
 *          called while acquiring a signature.
 *      .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 *
 * @par Example:
 * @code
void OnDisplayChanged()
{
    SPINT32 iLcd = 0;
    SPTabletGetLCD(pTablet, &iLcd);
    // Display changes only effect TabletPC and Wacom PL / Cintiq devices
    if(!iLcd) return;

    SPINT32 iState = SP_TABLET_STATE_IDLE;
    SPTabletGetState(pTablet, &iState);
    if(iState == SP_TABLET_STATE_ACQUIRE)
        SPTabletAcquireDone(pTablet);
    SPTabletReloadParameters(pTablet);
    // .. update the application specific data that refers to display
    // size and orientation ...

    // finally recover the tablet state
    if(iState == SP_TABLET_STATE_ACQUIRE)
        SPTabletAcquire(pTablet, mHwnd);
}
 * @endcode
 */
SPEXTERN SPINT32 SPLINK SPTabletReloadParameters(pSPTABLET_T pTablet);

/**
 * @brief Check if the tablet used by an SPTablet object is a full-screen
 *        tablet.
 *
 * This function checks for tablets which are integrated into the PC screen.
 *
 * Tablets identified by these tablet ID's are full-screen tablets:
 *      - @ref SP_TABLETPC_DEV
 *      - @ref SP_PL400_DEV
 *      .
 *
 * SPTablet differentiates 3 types of tablets
 *      - tablets without an LCD screen (such as Wacom Intuos), SPTabletGetLCD and SPTabletHasExternalLCD return 0
 *      - tablets with an integrated LCD screen (such as Wacom Signpad), SPTabletGetLCD returns 0, SPTabletHasExternalLCD returns 1
 *      - PCs with integrated tablet functionality (such as TabletPC), SPTabletGetLCD returns 1, SPTabletHasExternalLCD returns 0
 *      .
 *
 * @note The result of this function can be overridden by @ref SPTabletSetLCD.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piLCD [o]
 *      pointer to a variable that will be filled with a value telling
 *      whether the tablet used by the SPTablet object is a full-screen tablet:
 *      - 0: the tablet is not a full-screen tablet (ie, it does not have
 *           an LCD or the tablet's LCD is identical to the PC screen)
 *      - 1: the tablet is a full-screen tablet (ie, the capture device is
 *           integrated into the PC screen)
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @deprecated This function is replaced by @ref SPTabletGetDisplayType
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @since SignWare V 2.5
 * @see SPTabletHasExternalLCD, SPTabletSetLCD
 */
SPEXTERN SPINT32 SPLINK SPTabletGetLCD(pSPTABLET_T pTablet, SPINT32 *piLCD);

/**
 * @brief Change an SPTablet object's notion of the presence of a full-screen
 *        tablet.
 *
 * The tablet's LCD capability is determined during
 * initialization and should not be overwritten unless you know what
 * you do.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iLCD [i]
 *      desired notion of presence of a full-screen tablet:
 *      - 0: the tablet is not a full-screen tablet and it does not
 *           have a built-in LCD (both @ref SPTabletGetLCD
 *           and @ref SPTabletHasExternalLCD will give back 0)
 *      - 1: the tablet is a full-screen tablet (@ref SPTabletGetLCD will
 *           give back 1, @ref SPTabletHasExternalLCD will give back 0)
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 * @deprecated This function is replaced by @ref SPTabletSetDisplayType
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletCreate, SPTabletGetLCD, SPTabletHasExternalLCD
 */
SPEXTERN SPINT32 SPLINK SPTabletSetLCD(pSPTABLET_T pTablet, SPINT32 iLCD);

/**
 * @brief Check if the tablet used by an SPTablet object has an integrated LCD.
 *
 * This function checks for tablets with a built-in LCD.  Full-screen
 * tablets (capture devices integrated into the PC screen) are not
 * considered to be tablets having an integrated LCD.
 *
 * Tablets identified by these tablet ID's have an integrated LCD:
 *      - @ref SP_EINK_DEV
 *      - @ref SP_EINK2_DEV
 *      - @ref SP_EPADLS_DEV
 *      - @ref SP_MTLCD_DEV
 *      - @ref SP_BLUEMLCD_DEV
 *      - @ref SP_MOBINETIX_DEV
 *      - @ref SP_TZSE_DEV
 *      - @ref SP_SIGNPAD_DEV
 *      .
 *
 * SPTablet differentiates 3 types of tablets
 *      - tablets without an LCD screen (such as Wacom Intuos), SPTabletGetLCD and SPTabletHasExternalLCD return 0
 *      - tablets with an integrated LCD screen (such as Wacom Signpad), SPTabletGetLCD returns 0, SPTabletHasExternalLCD returns 1
 *      - PCs with integrated tablet functionality (such as TabletPC), SPTabletGetLCD returns 1, SPTabletHasExternalLCD returns 0
 *      .
 * @note The result of this function can be overridden by @ref SPTabletSetLCD.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param piExtLCD [o]
 *      pointer to a variable that will be filled with the LCD capability
 *      of the tablet used by the SPTablet object:
 *      - 0: the tablet does not have a built-in LCD or the tablet is a
 *           full-screen tablet (integrated into the PC screen)
 *      - 1: the tablet has an LCD integrated (and is not a full-screen
 *           tablet)
 *      .
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @deprecated This function is replaced by @ref SPTabletGetDisplayType
 *
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * @see SPTabletGetLCD, SPTabletSetLCD
 */
SPEXTERN SPINT32 SPLINK SPTabletHasExternalLCD(pSPTABLET_T pTablet, SPINT32 *piExtLCD);

/**
 * @cond INTERNAL
 */
/**
 * @brief Set the virtual button listener of an SPTablet object.
 *
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param pNotifyButton [i]
 *      function that is to be called when a virtual button of the tablet
 *      is pressed. The function pointer may be NULL to deregister all virtual button event listeners.
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPLINK SPTabletSetVirtualButtonListener(pSPTABLET_T pTablet, pSPTABLETBUTTON_T pVirtualButton);

/**
 * @brief Register a vvirtual button
 * 
 * @param pTablet [i]
 *      pointer to an SPTablet object.
 * @param iId [i] the id of the virtual button
 * @param rcl [i] the coordinates of the virtual button in thousands of the tablet surface
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   .
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 */
SPEXTERN SPINT32 SPTabletAddVirtualButton(pSPTABLET_T pTablet, int iId, const SPRECT_T rcl);
/**
 * @endcond INTERNAL
 */

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* SPTABLET_H__ */

 /*
  * $Log: SPTablet.h,v $
  * Revision 1.23  2012/07/04 16:22:15  uko
  * Fixed Memory leak if Object creation fails
  *
  * Revision 1.22  2012/04/17 10:36:02  uko
  * Document view: Coordinate transformation on TabletPC
  *
  * Revision 1.21  2012/03/19 10:17:50  ema
  * Remove SPLONG.
  *
  * Revision 1.20  2011/08/31 14:02:16  uko
  * Added time in tablet vectors
  *
  * Revision 1.19  2011/07/26 13:51:25  uko
  * Use Timeout callback
  *
  * Revision 1.18  2011/07/15 08:45:19  uko
  * Document TabletServer SP_INVALIDERR
  *
  * Revision 1.17  2011/07/06 07:54:20  uko
  * Documentation
  *
  * Revision 1.16  2011/06/10 09:22:34  uko
  * Docu
  *
  * Revision 1.15  2011/06/06 07:01:09  uko
  * Document TabletServer
  *
  * Revision 1.14  2011/06/04 10:54:07  uko
  * TabletServer
  *
  * Revision 1.13  2011/06/03 15:15:43  uko
  * Basic TabletServer support
  *
  * Revision 1.12  2011/04/21 07:44:49  uko
  * Create Tablet by Alias
  * Support Verifone Mx
  *
  * Revision 1.11  2011/04/07 14:51:39  uko
  * #10891, Added display animated images
  *
  * Revision 1.10  2011/03/29 12:37:12  ema
  * Documentation: Linux (x86_64).
  *
  * Revision 1.9  2010/09/20 08:03:27  uko
  * Config
  *
  * Revision 1.8  2010/08/17 15:53:54  ema
  * Improve documentation.
  *
  * Revision 1.7  2010/07/24 18:56:57  uko
  * Added SetIntProperty / GetIntProperty in all GUI components
  *
  * Revision 1.6  2010/07/23 18:59:39  uko
  * Feature-complete support STU-520
  *
  * Revision 1.5  2010/07/21 18:38:39  uko
  * Docu
  *
  * Revision 1.4  2010/06/07 12:12:53  ema
  * Use old-style comments.
  *
  * Revision 1.3  2010/04/26 08:47:30  uko
  * Docu
  *
  * Revision 1.2  2010/04/22 08:28:05  uko
  * Docu: PadSerial
  *
  * Revision 1.1.1.1  2010/04/19 08:53:48  uko
  * Reimport in flat file structure
  *
  * Revision 1.78  2010/04/08 12:40:56  uko
  * Set SPGuiAcqu, SPImage: Fore/Back-ground color for SPSWText and SPSWRect objects
  *
  * Revision 1.77  2009/08/05 13:37:51  ema
  * Update Linux restrictions.
  *
  * Revision 1.76  2009/08/04 14:52:30  ema
  * Improve documentation.
  *
  * Revision 1.75  2009/08/04 14:46:24  ema
  * Implement some functions under Linux.
  *
  * Revision 1.74  2009/08/04 12:35:21  ema
  * Fix type of SPTabletGetXInputDeviceName's ppszName parameter.
  *
  * Revision 1.73  2009/07/28 09:34:31  uko
  * *** empty log message ***
  *
  * Revision 1.72  2009/07/28 09:32:41  uko
  * Docs
  *
  * Revision 1.71  2009/07/27 17:21:04  uko
  * Notify the application on tablet status / error events
  *
  * Revision 1.70  2009/07/26 09:54:51  uko
  * Allow Create Connect Disconnect Acquire AcquireDone from different threads
  *
  * Revision 1.69  2009/07/24 15:17:28  uko
  * Document threading restrictions for tablet access
  *
  * Revision 1.68  2009/07/09 14:05:38  ema
  * Document which functions are not yet implemented for Linux.
  *
  * Revision 1.67  2009/02/20 15:22:08  uko
  * Renamed ClearBackgroundObjects to RemoveBackgroundObjects
  * Documentation
  *
  * Revision 1.66  2009/01/16 17:31:12  uko
  * Support Multiple Monitor Display with Cintiqu Devices
  *
  * Revision 1.65  2008/10/31 19:34:54  uko
  * AddBackgroundObject: added Option iUpdate
  *
  * Revision 1.64  2008/10/27 10:59:12  uko
  * Use Win64 compatible pointer arguments
  *
  * Revision 1.63  2008/08/07 10:05:58  uko
  * *** empty log message ***
  *
  * Revision 1.62  2008/08/06 17:15:23  uko
  * Cleanup
  *
  * Revision 1.61  2008/08/06 16:51:55  uko
  * More documentation
  *
  * Revision 1.60  2008/08/05 12:34:43  uko
  * New Functions SPTabletGetDisplayType, SPTabletSetDisplayType
  *
  * Revision 1.59  2008/08/04 15:25:45  uko
  * Documentation
  *
  * Revision 1.58  2008/08/04 09:20:51  uko
  * Added new entry point SPTabletReloadParameters, support TabletPC orientation changes
  *
  * Revision 1.57  2008/07/10 15:06:33  uko
  * Added GetHardwareName
  *
  * Revision 1.56  2008/03/17 18:24:52  uko
  * Save and reuse Sival Parameters
  *
  * Revision 1.55  2008/02/08 14:51:33  ema
  * Add SPGetCurrentTime(), SPSignware.getCurrentTime(), and
  * SPNifInterface.getCurrentTime() (#5525).
  *
  * Revision 1.54  2008/01/14 00:48:08  ema
  * Improve documentation.
  *
  * Revision 1.53  2008/01/14 00:05:43  ema
  * Improve documentation.
  *
  * Revision 1.52  2008/01/10 16:06:36  ema
  * Improve documentation.
  *
  * Revision 1.51  2008/01/08 15:22:15  ema
  * Improve documentation.
  *
  * Revision 1.50  2008/01/08 09:56:19  ema
  * Improve documentation.
  *
  * Revision 1.49  2008/01/07 10:13:54  ema
  * Improve documentation.
  *
  * Revision 1.48  2008/01/04 16:27:37  ema
  * Improve documentation.
  *
  * Revision 1.47  2007/12/14 08:56:29  uko
  * Spelling error SPTabletWSignPad
  *
  * Revision 1.46  2007/09/20 19:53:00  uko
  * Corrected handling of empty images
  *
  * Revision 1.45  2007/08/07 17:46:15  uko
  * *** empty log message ***
  *
  * Revision 1.44  2007/07/09 08:58:08  uko
  * Capture and render license tickest are passed once (during initialisation)
  *
  * Revision 1.43  2007/05/14 08:36:22  uko
  * BugZilla 4444
  *
  * Revision 1.42  2007/03/26 08:34:58  uko
  * Externalize TabletState
  * Add note in Read.me MinJava Version
  *
  * Revision 1.41  2007/03/13 17:49:40  uko
  * SPTicket includes Usage, Count and SessionId
  *
  * Revision 1.40  2007/03/06 08:47:19  uko
  * Image Cleaning
  *
  * Revision 1.39  2007/02/12 08:42:47  uko
  * Added SPTabletGetMode
  * Added class SPPropertyMap, SPCleanParameter
  *
  * Revision 1.38  2006/11/21 13:34:26  uko
  * Pass Configuration data to low level tablet drivers
  *
  * Revision 1.37  2006/11/13 12:46:28  uko
  * SignWare Rel 2.3.10 basic implementation
  * SPTablet C++ implementation
  * SPImage C++ implementation
  *
  * Revision 1.36  2006/10/23 06:47:29  uko
  * Error message when tablet is in use
  *
  * Revision 1.35  2006/03/13 08:43:12  uko
  * Corrected zip code: D 71034
  *
  * Revision 1.34  2006/01/23 10:30:53  uko
  * New Tablet mode: don't display strokes, process virtual buttons
  *
  * Revision 1.33  2006/01/03 14:11:14  uko
  * Changed company name to SOFTPRO GmbH
  *
  * Revision 1.32  2005/12/12 08:39:47  uko
  * Support get/set Tablet serial #
  * Bugzilla #2349
  * Set versions in Ship.cmd
  * Use ant to build tapi.war
  *
  * Revision 1.31  2005/10/24 08:15:35  uko
  * Check the size of virtual buttons
  *
  * Revision 1.30  2005/08/10 08:59:30  uko
  * Append Version number to SDK library
  *
  * Revision 1.29  2005/08/09 08:35:35  uko
  * Support Topaz 4X5SE, new methods SPTabletGetLCDSize
  *
  * Revision 1.28  2005/07/04 07:55:42  uko
  * Added comments
  *
  * Revision 1.27  2005/06/19 07:42:45  uko
  * Support Stepobver blueM
  *
  * Revision 1.26  2005/05/17 06:45:49  uko
  * New license action Render
  *
  * Revision 1.25  2005/03/21 07:35:45  uko
  * More description on Tickets
  *
  * Revision 1.24  2005/02/01 18:00:34  ema
  * Ticket licenses (continued).
  *
  * Revision 1.23  2004/11/22 09:39:12  uko
  * New Object SPTicket
  *
  * Revision 1.22  2004/10/19 11:01:20  uko
  * Added Support for Background images
  *
  * Revision 1.21  2004/10/18 07:15:55  uko
  * New Java sample, add registered rectangles
  *
  * Revision 1.20  2004/07/27 08:58:12  xfk
  * - partial port of the sdk to to linux
  * - jni wrapper for some sdk objects
  *
  * Revision 1.19  2004/04/05 08:41:38  uko
  * *** empty log message ***
  *
  * Revision 1.18  2003/12/22 10:48:07  uko
  * Use dynamic signature Format incl Timestamp
  * Updated documentation
  *
  * Revision 1.17  2003/09/22 06:57:01  uko
  * Docs added [i] / [o] / [io]
  *
  * Revision 1.16  2003/05/14 08:05:45  uko
  * Processed docu
  *
  * Revision 1.15  2003/03/24 17:37:41  uko
  * Added Personalisation via Secure
  *
  * Revision 1.14  2003/01/07 15:58:29  uko
  * Addded new Object SPBitmap, Added Interlink native driver
  *
  * Revision 1.13  2002/11/11 07:46:10  uko
  * Focus handling: release acquiry mode when focus lost
  * Documentation
  *
  * Revision 1.12  2002/10/29 11:36:45  uko
  * Docu corrections
  *
  * Revision 1.11  2002/10/28 19:04:18  uko
  * *** empty log message ***
  *
  * Revision 1.10  2002/09/25 07:41:25  uko
  * Added: SPTabletQueryProximity
  * Bugfix: Non-Proximity Pads draw first vector
  *
  * Revision 1.9  2002/09/24 19:01:28  uko
  * Added: comments, docu
  *
  * Revision 1.8  2002/07/08 18:38:32  uko
  * *** empty log message ***
  *
  * Revision 1.7  2002/07/01 18:11:55  uko
  * Added: Sample rate normalization
  *
  * Revision 1.6  2002/07/01 06:40:03  uko
  * *** empty log message ***
  *
  * Revision 1.5  2002/06/24 09:24:35  uko
  * Further dev-work
  *
  * Revision 1.4  2002/06/18 15:28:17  uko
  * *** empty log message ***
  *
  * Revision 1.3  2002/06/17 09:27:22  uko
  * *** empty log message ***
  *
  * Revision 1.2  2002/06/11 14:30:49  uko
  * *** empty log message ***
  *
  * Revision 1.1  2002/06/10 13:27:40  uko
  * New Module group SignWare
  *
  */

