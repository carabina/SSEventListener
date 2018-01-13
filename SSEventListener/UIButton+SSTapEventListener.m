//
//  UIButton+SSTapEventListener.m
//  SSEventListener
//
//  Created by Shengsheng on 13/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "UIButton+SSTapEventListener.h"
#import <objc/runtime.h>

static const void *SSTapButtonEventListenerKey = "SSTapButtonEventListenerKey";

@implementation UIButton (SSTapEventListener)

- (void)ss_addTapButtonEventListener:(SSTapButtonEventListener)listener {
    [self addTarget:self action:@selector(p_handleTapEvent:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, SSTapButtonEventListenerKey, listener, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ss_removeTapButtonEventListener {
    [self removeTarget:self action:@selector(p_handleTapEvent:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Tap Event Handler

- (void)p_handleTapEvent:(UIButton *)button {
    SSTapButtonEventListener listener = objc_getAssociatedObject(self, SSTapButtonEventListenerKey);
    if (listener) {
        listener();
    }
}

@end
