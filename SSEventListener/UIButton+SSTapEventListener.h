//
//  UIButton+SSTapEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 13/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Tap event listener typedef.
 *
 */
typedef void(^SSTapButtonEventListener)(void);

@interface UIButton (SSTapEventListener)

/**
 * Add a tap event listener to self to listen for button UIControlEventTouchUpInside event.
 *
 * @param listener Tap event listener block.
 */
- (void)ss_addTapButtonEventListener:(SSTapButtonEventListener)listener;

/**
 * Remove tap event listener.
 */
- (void)ss_removeTapButtonEventListener;

@end
