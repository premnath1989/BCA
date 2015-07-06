/*==============================================================*
 * SOFTPRO SignDoc Mobile SDK                                   *
 *                                                              *
 * @(#)SDSignatureCaptureController.h                           *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
 * Wilhelmstrasse 34, D-71034 Boeblingen                        *
 * All rights reserved.                                         *
 *                                                              *
 * This software is the confidential and proprietary            *
 * information of SOFTPRO ("Confidential Information"). You     *
 * shall not disclose such Confidential Information and shall   *
 * use it only in accordance with the terms of the license      *
 * agreement you entered into with SOFTPRO.                     *
 *==============================================================*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SDSignatureHandler.h"

/**
 * @brief Displays the signature capture dialog
 */
@interface SDSignatureCaptureController : NSObject {
    id impl;
}

/**
 * @brief Initializes the signature capture dialog
 * @param parent parent view controller
 * @param delegate callback object, notified about the success of the capture process
 * @return initialized object
 * @warning nested parent views cause severe side effects as of iOS 4.3.5. It is recommended to use the topmost UIViewController (e.g. navigation controller) as parent
 */
- (id) initWithParent: (UIViewController *) parent withDelegate: (NSObject<SDSignatureHandler> *) delegate;

/**
 * @brief Sets the title of the signature capture dialog
 * @param title dialog title
 **/
- (void) setTitle: (NSString *) title;

/**
 * @brief Frees memory associated with this object
 */
- (void) release;

/**
 * @brief Display capture dialog.
 */
- (void) captureSignature;

/**
 * @brief Clears the signature
 */
- (void) clearSignature;

/**
 * @brief Closes the dialog
 */
- (void) abortSignatureCapture;

/**
 * @brief Returns the signature as an UIImage
 * @return rendered image. Autoreleased.
 */
- (UIImage *) signatureAsUIImage;

/**
 * @brief Returns the signature in an internal representation suitable for SignDocWeb
 * @returns signature data. Autoreleased.
 */
- (NSData *) signatureAsBlob;

/**
 * @brief Returns the signature as SVG
 * @returns signature as SVG string. Autoreleased.
 */
- (NSString *) signatureAsSVG;

/**
 * @brief Returns the signature as serialized ISO 19794-Simple object
 * @return signature blob
 */
- (NSData *) signatureAsISO19794Simple;

@end
