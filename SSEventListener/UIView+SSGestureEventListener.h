//
//  UIView+SSGestureEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 13/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Tap event listener typedef.
 *
 * @param recognizer A UITapGestureRecognizer instance associated with the listener.
 */
typedef void(^SSTapViewEventListener)(UITapGestureRecognizer *recognizer);

/**
 * Long press event listener typedef.
 *
 * @param recognizer A UILongPressGestureRecognizer instance associated with the listener.
 */
typedef void(^SSLongPressViewEventListener)(UILongPressGestureRecognizer *recognizer);

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
- (UIGestureRecognizer *)ss_addTapEventListener:(SSTapViewEventListener)listener numberOfTapsRequired:(NSUInteger)numberOfTapsRequired;

/**
 * Add a long press listener to self.
 *
 * @param listener Long press event listener block.
 * @param minimumPressDuration Minimum press duration for the long press event.
 *
 * @return A UILongPressGestureRecognizer instance generated for the listener.
 *  Save this returned recognizer if you want to remove the listener using [UIView removeGestureRecognizer:] later.
 */
- (UILongPressGestureRecognizer *)ss_addLongPressEventListener:(SSLongPressViewEventListener)listener minimumPressDuration:(CFTimeInterval)minimumPressDuration;

@end
