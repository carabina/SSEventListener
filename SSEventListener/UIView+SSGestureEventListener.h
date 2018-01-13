//
//  UIView+SSGestureEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 13/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

// listener block typedefs
typedef void(^SSTapEventListener)(UITapGestureRecognizer *recognizer);
typedef void(^SSLongPressEventListener)(UILongPressGestureRecognizer *recognizer);

@interface UIView (SSGestureEventListener)

/**
 * Add a tap event listener to self.
 *
 * @param listener Tap event listener block.
 * @param numberOfTapsRequired Number of taps required.
 *
 * @return A UIGestureRecognizer instance generated for the listener.
 *  Save this returned recognizer if you want to remove the listener using [UIView removeGestureRecognizer:] later.
 */
- (UIGestureRecognizer *)ss_addTapEventListener:(SSTapEventListener)listener numberOfTapsRequired:(NSUInteger)numberOfTapsRequired;

/**
 * Add a long press listener to self.
 *
 * @param listener Long press event listener block.
 * @param minimumPressDuration Minimum press duration for the long press event.
 *
 * @return A UILongPressGestureRecognizer instance generated for the listener.
 *  Save this returned recognizer if you want to remove the listener using [UIView removeGestureRecognizer:] later.
 */
- (UILongPressGestureRecognizer *)ss_addLongPressEventListener:(SSLongPressEventListener)listener minimumPressDuration:(CFTimeInterval)minimumPressDuration;

@end
