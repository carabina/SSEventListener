//
//  UIViewController+SSShakeEventListener.m
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "UIViewController+SSShakeEventListener.h"
#import <objc/runtime.h>

static const void *SSShakeEventListenerKey = "SSShakeEventListenerKey";

typedef id _Nullable (*IMP_type)(id _Nonnull, SEL _Nonnull, ...);
static IMP savedMotionEndedWithEventIMP = nil; // saved IMP for method motionEnded:withEvent: of the UIViewController class

@implementation UIViewController (SSShakeEventListener)

+ (void)load {
    [self p_enableShakeEventListener];
}

#pragma mark - API

- (void)ss_setShakeEventListener:(SSShakeEventListener)listener {
    objc_setAssociatedObject(self, SSShakeEventListenerKey, listener, OBJC_ASSOCIATION_COPY);
}

- (void)ss_removeShakeEventListener {
    objc_setAssociatedObject(self, SSShakeEventListenerKey, nil, OBJC_ASSOCIATION_COPY);
}

- (SSShakeEventListener)ss_getShakeEventListener {
    return objc_getAssociatedObject(self, SSShakeEventListenerKey);
}

#pragma mark - Shake Event

void p_motionEndedWithEvent(id self, SEL _cmd, UIEventSubtype motion, UIEvent *event) {
    if (UIEventSubtypeMotionShake == event.subtype) {
        SSShakeEventListener listener = objc_getAssociatedObject(self, SSShakeEventListenerKey);
        if (listener) {
            listener();
        }
    }
    
    if (savedMotionEndedWithEventIMP) {
        IMP_type _imp = (IMP_type)savedMotionEndedWithEventIMP;
        _imp(self, _cmd, motion, event);
    }
}

+ (void)p_enableShakeEventListener {
    savedMotionEndedWithEventIMP = class_replaceMethod([UIViewController class], @selector(motionEnded:withEvent:), (IMP)p_motionEndedWithEvent, "v@:u@");
}

+ (void)p_disableShakeEventListener {
    class_replaceMethod([UIViewController class], @selector(motionEnded:withEvent:), savedMotionEndedWithEventIMP, "v@:u@");
    savedMotionEndedWithEventIMP = nil;
}

@end
