//
//  NSObject+SSApplicationEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SSApplicationEventListener)(NSNotificationName notificationName, UIApplication *application);

@interface NSObject (SSApplicationEventListener)

- (void)ss_setApplicationEventListener:(SSApplicationEventListener)listener;

- (SSApplicationEventListener)ss_getApplicationEventListener;

- (void)ss_removeApplicationEventListener;

@end
