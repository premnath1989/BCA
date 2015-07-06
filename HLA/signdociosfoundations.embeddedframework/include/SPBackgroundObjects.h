/*==============================================================*
 * SOFTPRO SignWare                                             *
 * ADSV System developer Toolkit                                *
 * Module: SPBackgroundObjects.h                                *
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
 * @file SPBackgroundObjects.h
 * @author uko
 * @version $Name: RST#SignWare#core#REL-3-0-1-2 $
 * @brief SignWare Dynamic Development toolkit, background descriptor container
 *
 * SPBackgroundObjects is a container of tablet background descriptors for multiple 
 * tablets, which are read from a xml string / file
 *
 * SPBackgroundObjects hold background descriptors for different tablets, 
 * the methods @ref  SPAcquireSetBackgroundObjects and @ref SPGuiAcquSetBackgroundObjects
 * will select and copy the descriptor that matches the active tablet.
 * <br> The matching algorithm differs between tablets with (external) LCD
 * and tablets without LCD:
 *      - Tablets with external LCD
 *          - Search tabletname_(LcdWidth)x(LcdHeight) equals descriptorname
 *          - Search tabletname equals descriptorname
 *          - Search 'LCD' equals descriptorname
 *          - Search 'Default' equals descriptorname
 *          .
 *      - Tablets without external LCD
 *          - Search tabletname equals descriptorname
 *          - Search 'NonLCD' equals descriptorname
 *          - Search 'Default' equals descriptorname
 *          .
 *      .
 * 
 * The tabletname is resolved from the tablet object, see @ref SPTabletGetDeviceStr. The
 * descriptorname is resolved from Attribute Device in the element SPSWDevice.
 *
 * Please see @ref sec_SignWareDTD for a full description of all background elements
 *
 * Example: typical BackgroundObjects-File
 * @code
<?xml version="1.0" encoding="UTF-8"?>
<SPSWDeviceFields>
  <!-- Description for Wacom Signpad STU-520 -->
  <SPSWDevice Device="Wacom SIGNPAD_800x480">
    <SPSWObjects>

      <!-- text line: sign here -->
      <SPSWTextFields>
        <SPSWText ALignment="0" DrawFlags="3" Group="TGN" Format="2" Caption="Sign here" Foreground="0x800000">
            <SPSWCoordinate Origin="Tablet" Left="150" Right="300" Top="780" Bottom="860"/>
            <SPSWFont Face="Helvetica" Size="0" Flags="1"/>
        </SPSWText>
      </SPSWTextFields>
    
      <!-- pass the background image -->
      <SPSWImageFields>
        <SPSWImage DrawFlags="3" Format="1"> eink_800x480.bmp
          <SPSWCoordinate Origin="tablet" Left="0" Top="0" Right="1000" Bottom="1000" />
        </SPSWImage>
      </SPSWImageFields>
    
      <!-- Overwrite OK button -->
      <SPSWVirtualButtonFields>
        <SPSWVirtualButton DrawFlags="3" Background="0xff00" id="1">
          <SPSWCoordinate Origin="tablet" Left="25" Top="900" Right="325" Bottom="980" />
            <SPSWText Caption="OK" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>
    
        <!-- Overwrite Erase button -->
        <SPSWVirtualButton DrawFlags="3" Background="0x808080" id="2">
          <SPSWCoordinate Origin="tablet" Left="350" Top="900" Right="650" Bottom="980" />
            <SPSWText Caption="Erase" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>
    
        <!-- Overwrite Cancel button -->
        <SPSWVirtualButton DrawFlags="3" Background="0xff0000" id="3">
          <SPSWCoordinate Origin="tablet" Left="675" Top="900" Right="975" Bottom="980" />
            <SPSWText Caption="Cancel" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>
      </SPSWVirtualButtonFields>
    
      <!-- Tablet options, STU-520 supports penwidth -->
      <SPSWTabletOption Screen="off" Tablet="on" Image="optimized" PenWidth="170">
        <SPSWCoordinate origin="Tablet" left="0" right="1000" top="0" bottom="890" />
      </SPSWTabletOption>
    </SPSWObjects>
  </SPSWDevice>

  <!-- Description for Wacom Signpad STU-500 -->
  <SPSWDevice Device="Wacom SIGNPAD_640x480">
    <SPSWObjects>

        <!-- Text line: sign here -->
      <SPSWTextFields>
        <SPSWText ALignment="0" DrawFlags="3" Group="TGN" Format="2" Caption="Sign here" >
            <SPSWCoordinate Origin="Tablet" Left="150" Right="300" Top="780" Bottom="860"/>
            <SPSWFont Face="Helvetica" Size="0" Flags="1"/>
        </SPSWText>
      </SPSWTextFields>

      <!-- pass the background image -->
      <SPSWImageFields>
        <SPSWImage DrawFlags="3" Format="1"> eink_640x480.bmp
          <SPSWCoordinate Origin="tablet" Left="0" Top="0" Right="1000" Bottom="1000" />
        </SPSWImage>
      </SPSWImageFields>

      <!-- Overwrite OK button -->
      <SPSWVirtualButtonFields>
        <SPSWVirtualButton DrawFlags="3" id="1">
          <SPSWCoordinate Origin="tablet" Left="25" Top="900" Right="325" Bottom="980" />
            <SPSWText Caption="OK" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>

        <!-- Overwrite Erase button -->
        <SPSWVirtualButton DrawFlags="3" id="2">
          <SPSWCoordinate Origin="tablet" Left="350" Top="900" Right="650" Bottom="980" />
            <SPSWText Caption="Erase" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>

        <!-- Overwrite Cancel button -->
        <SPSWVirtualButton DrawFlags="3" id="3">
          <SPSWCoordinate Origin="tablet" Left="675" Top="900" Right="975" Bottom="980" />
            <SPSWText Caption="Cancel" DrawFlags="3" Group="ButtonGroup">
            <SPSWFont Face="Helvetica" Size="0" />
          </SPSWText>
        </SPSWVirtualButton>
      </SPSWVirtualButtonFields>

    </SPSWObjects>
  </SPSWDevice>
</SPSWDeviceFields>
 * @endcode 
 */

#ifndef SPBACKGROUNDOBJECTS_H__
#define SPBACKGROUNDOBJECTS_H__

#include "SPSignWare.h"

/*==============================================================*
 * Constant definitions                                         *
 *==============================================================*/

/*==============================================================*
 * Structures and type definitions                              *
 *==============================================================*/

/*==============================================================*
 * Function declarations                                        *
 *==============================================================*/
#ifdef __cplusplus
extern "C" {
#endif  /* __cplusplus */

/**
 * @brief Create a background descriptor container from a file
 * 
 * @note The file must contain a valid xml description for the tablet background, the
 * root element must be SPSWDeviceFields, see @ref sec_SignWareDTD
 * <br>
 * The filename will be composed of pszFile + _ + pszLanguage if parameter pszLanguage 
 * contains a valid language specifier. If the language file is not found then 
 * the file pszFile will be read.
 * <br>
 * Example: 
 * @code
 *     pSPBACKGROUNDOBJECTS_T pBackgroundObjects = 0;
 *     SPBackgroundObjectsCreateFromFile(&pBackgroundObjects, "SignwareBackground.xml", "de");
 * @endcode
 * will locate SignwareBackground_de.xml in all locations, and read the first
 * file found. If no file is found then it will locate the file SignwareBackground.xml
 * and return an error if the file is not found, else read the file found.
 * 
 * @param ppBackgroundObjects [io] pointer to a variable that will be filled with 
 * an instance of the container
 * @param pszFile [i] name of the file to read. If the filename is a fully 
 * qualified path then this path will be read. Else under Windows the file will 
 * be located in:
 *      - \%USERPROFILE\%\\SOFTPRO
 *      - \%USERPROFILE\%
 *      - \%HOMEPATH\%\\SOFTPRO
 *      - \%HOMEPATH\%
 *      - \%ALLUSERSPROFILE\%\\SOFTPRO
 *      - \%ALLUSERSPROFILE\% 
 *      - \%APPDATA\%\\SOFTPRO 
 *      - \%APPDATA\%
 *      - \%PATH\%
 *      - SystemDirectory, only Windows
 *      - WindowsDirectory, only Windows
 *      .
 * @param pszLanguage [i] language specifier, two char language code, may be NULL
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - SP_OPENERR            the file is not accessible or does not exist
 *   - SP_FILEERR            the file cannot be read
 *   - @ref SP_MEMERR        out of memory
 *   .
 * 
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * 
 * @see SPBackgroundObjectsFree, SPAcquireSetBackgroundDescriptor, SPGuiAcquSetBackgroundDescriptor
 */
SPEXTERN SPINT32 SPLINK SPBackgroundObjectsCreateFromFile(pSPBACKGROUNDOBJECTS_T *ppBackgroundObjects, const SPCHAR* pszFile, const SPCHAR* pszLanguage);

/**
 * @brief Create a background descriptor container from a xml-string
 * 
 * @note the XML string must contain a valid xml description for the tablet background, the
 * root element must be SPSWDeviceFields, see @ref sec_SignWareDTD
 * 
 * @param ppBackgroundObjects [io] pointer to a variable that will be filled with 
 * an instance of the container
 * @param pszXML [i] the xml string
 * @return @ref SP_NOERR on success, else error code:
 *   - @ref SP_PARAMERR      invalid parameter
 *   - @ref SP_MEMERR        out of memory
 *   .
 * 
 * @par Operating Systems:
 *      Windows (Win32), Linux (i386), Linux (x86_64), Linux (ARM)
 * 
 * @see SPBackgroundObjectsFree, SPAcquireSetBackgroundDescriptor, SPGuiAcquSetBackgroundDescriptor
 */
SPEXTERN SPINT32 SPLINK SPBackgroundObjectsCreateFromXML(pSPBACKGROUNDOBJECTS_T *ppBackgroundObjects, const SPCHAR* pszXML);

/**
 * @brief Free the resources used by the container
 */
SPEXTERN SPINT32 SPLINK SPBackgroundObjectsFree(pSPBACKGROUNDOBJECTS_T *ppBackgroundObjects);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif  /* SPBACKGROUNDOBJECTS_H__ */

 /*
  * $Log: SPBackgroundObjects.h,v $
  * Revision 1.6  2011/03/29 12:37:47  ema
  * Doc fix.
  *
  * Revision 1.5  2011/03/29 12:37:12  ema
  * Documentation: Linux (x86_64).
  *
  * Revision 1.4  2010/11/19 12:48:37  uko
  * Spelling
  *
  * Revision 1.3  2010/09/27 12:26:48  uko
  * Added language to BackgroudObjects-File
  *
  * Revision 1.2  2010/09/24 09:22:07  uko
  * Documentation
  *
  * Revision 1.1  2010/09/08 11:09:33  uko
  * Added SPGuiAcqSetBackgroundObjects SPAcquireSetBackgroundObjects
  *
  * 
  */

