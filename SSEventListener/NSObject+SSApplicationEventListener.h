//
//  NSObject+SSApplicationEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Application event listener block typedef.
 *
 * @param notificationName Application notification name.
 * @param application Global application instance.
 */
typedef void(^SSApplicationEventListener)(NSNotificationName notificationName, UIApplication *application);

@interface NSObject (SSApplicationEventListener)

/**
 * Set application event listener for self.
 * Application events are standard notifications from global UIApplication instance.
 *
 * @param listener Handler block for application events.
 */
- (void)ss_setApplicationEventListener:(SSApplicationEventListener)listener;

/**
 * Remove application event from self.
 */
- (void)ss_removeApplicationEventListener;

@end
