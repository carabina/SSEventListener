//
//  NSObject+SSApplicationEventListener.m
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "NSObject+SSApplicationEventListener.h"
#import <objc/runtime.h>

static void *SSApplicationEventListenerKey = "SSApplicationEventListenerKey";
static NSMutableSet *listenerObjs = nil;
static NSObject *appNotificationReceiver = nil;

@implementation NSObject (SSApplicationEventListener)

+ (void)load {
    appNotificationReceiver = [NSObject new];
    listenerObjs = [NSMutableSet new];
    [self p_setupApplicationNotification];
}

#pragma mark - API

- (void)ss_setApplicationEventListener:(SSApplicationEventListener)listener {
    objc_setAssociatedObject(self, SSApplicationEventListenerKey, listener, OBJC_ASSOCIATION_COPY);
    __weak id weakSelf = self;
    id (^getWeakObjBlock)(void) = ^{ return weakSelf; };
    [listenerObjs addObject:getWeakObjBlock];
}

- (SSApplicationEventListener)ss_getApplicationEventListener {
    return objc_getAssociatedObject(self, SSApplicationEventListenerKey);
}

- (void)ss_removeApplicationEventListener {
    objc_setAssociatedObject(self, SSApplicationEventListenerKey, nil, OBJC_ASSOCIATION_COPY);
}

#pragma mark - Application Event Dispatcher

- (void)p_dispatchApplicationEvent:(NSNotificationName)notificationName application:(UIApplication *)application {
    [listenerObjs enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        id (^getWeakObjBlock)(void) = obj;
        id weakObj = getWeakObjBlock();
        if (weakObj) {
            SSApplicationEventListener listener = objc_getAssociatedObject(weakObj, SSApplicationEventListenerKey);
            if (listener) {
                listener(notificationName, application);
            }
        } else {
            [listenerObjs removeObject:obj];
        }
        
    }];
}

#pragma mark - Application Notification Receiver

+ (void)p_setupApplicationNotification {
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationWillTerminateNotification:) name:UIApplicationWillTerminateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationSignificantTimeChangeNotification:) name:UIApplicationSignificantTimeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationWillChangeStatusBarOrientationNotification:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationStatusBarOrientationUserInfoKey:) name:UIApplicationStatusBarOrientationUserInfoKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationWillChangeStatusBarFrameNotification:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationDidChangeStatusBarFrameNotification:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationStatusBarFrameUserInfoKey:) name:UIApplicationStatusBarFrameUserInfoKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationBackgroundRefreshStatusDidChangeNotification:) name:UIApplicationBackgroundRefreshStatusDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationProtectedDataWillBecomeUnavailable:) name:UIApplicationProtectedDataWillBecomeUnavailable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:appNotificationReceiver selector:@selector(p_receivedUIApplicationProtectedDataDidBecomeAvailable:) name:UIApplicationProtectedDataDidBecomeAvailable object:nil];
}

+ (void)p_removeApplicationNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:appNotificationReceiver];
}

- (void)p_receivedUIApplicationDidEnterBackgroundNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidEnterBackgroundNotification application:application];
}

- (void)p_receivedUIApplicationWillEnterForegroundNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationWillEnterForegroundNotification application:application];
}

- (void)p_receivedUIApplicationDidFinishLaunchingNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidFinishLaunchingNotification application:application];
}

- (void)p_receivedUIApplicationDidBecomeActiveNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidBecomeActiveNotification application:application];
}

- (void)p_receivedUIApplicationWillResignActiveNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationWillResignActiveNotification application:application];
}

- (void)p_receivedUIApplicationDidReceiveMemoryWarningNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidReceiveMemoryWarningNotification application:application];
}

- (void)p_receivedUIApplicationWillTerminateNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationWillTerminateNotification application:application];
}

- (void)p_receivedUIApplicationSignificantTimeChangeNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationSignificantTimeChangeNotification application:application];
}

- (void)p_receivedUIApplicationWillChangeStatusBarOrientationNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationWillChangeStatusBarOrientationNotification application:application];
}

- (void)p_receivedUIApplicationDidChangeStatusBarOrientationNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidChangeStatusBarOrientationNotification application:application];
}

- (void)p_receivedUIApplicationStatusBarOrientationUserInfoKey:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationStatusBarOrientationUserInfoKey application:application];
}

- (void)p_receivedUIApplicationWillChangeStatusBarFrameNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationWillChangeStatusBarFrameNotification application:application];
}

- (void)p_receivedUIApplicationDidChangeStatusBarFrameNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationDidChangeStatusBarFrameNotification application:application];
}

- (void)p_receivedUIApplicationStatusBarFrameUserInfoKey:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationStatusBarFrameUserInfoKey application:application];
}

- (void)p_receivedUIApplicationBackgroundRefreshStatusDidChangeNotification:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationBackgroundRefreshStatusDidChangeNotification application:application];
}

- (void)p_receivedUIApplicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationProtectedDataWillBecomeUnavailable application:application];
}

- (void)p_receivedUIApplicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    [self p_dispatchApplicationEvent:UIApplicationProtectedDataDidBecomeAvailable application:application];
}

@end
