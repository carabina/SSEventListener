//
//  UIViewController+SSShakeEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Shake event listener typedef.
 */
typedef void(^SSShakeEventListener)(void);

@interface UIViewController (SSShakeEventListener)

/**
 * Set shake event listener for self.
 * After calling this method, each time the device is shaken, the listener will get called.
 *
 * @param listener Shake event listener to handle device shake event.
 */
- (void)ss_setShakeEventListener:(SSShakeEventListener)listener;

/**
 * Remove shake event listener from self.
 */
- (void)ss_removeShakeEventListener;

@end
