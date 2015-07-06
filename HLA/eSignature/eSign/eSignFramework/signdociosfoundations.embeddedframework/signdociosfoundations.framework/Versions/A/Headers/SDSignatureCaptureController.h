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
 * @brief Initializes the signature capture dialog
 * @param parent parent view controller
 * @param delegate callback object, notified about the success of the capture process
 * @param backgroundImage background image of the signature dialog
 * @param dialogXibs array, containing the xibs that should be searched for
 * @param languages array, containing the languages of the xib that should be loaded. For greather flexibility, this value should be nil
 * @return initialized object
 * @warning nested parent views cause severe side effects as of iOS 4.3.5. It is recommended to use the topmost UIViewController (e.g. navigation controller) as parent
 */
- (id) initWithParent: (UIViewController *) parent withDelegate: (NSObject<SDSignatureHandler> *) delegate backgroundImage:(UIImage* )backgroundImage dialogXibs:(NSArray *)dialogXibs languages:(NSArray *)languages;

/**
 * @brief Sets the dialog position
 * @param dialogPosition takes the following values:1 for center, 2 for top and 3 for bottom. The default dialog position is center
 */
- (void) setDialogPosition: (NSInteger) dialogPosition;

/**
 * @brief Sets the pen properties
 * @param penProperties dictionary with the following description: the pen size can be set as a NSNumber for the @"penSize" key and the pen color can be set as an UIColor for the @"color" key
 */
- (void) setPenProperties: (NSDictionary *) penProperties;

/**
 * @brief Sets the title of the signature capture dialog
 * @param title dialog title
 **/
- (void) setTitle: (NSString *) title;

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
 * @returns rendered image. Autoreleased.
 */
- (UIImage *) signatureAsUIImage;

/**
 * @brief Returns the signature in an internal representation suitable for SignDocWeb
 * @returns signature data, or nil if signature is not valid. Autoreleased.
 */
- (NSData *) signatureAsBlob;

/**
 * @brief Returns the signature as SVG
 * @returns signature as SVG string, or nil if signature is not valid. Autoreleased.
 */
- (NSString *) signatureAsSVG;

/**
 * @brief Returns the signature as serialized ISO 19794-Simple object
 * @returns signature blob, or nil if signature is not valid
 */
- (NSData *) signatureAsISO19794Simple;

@end
