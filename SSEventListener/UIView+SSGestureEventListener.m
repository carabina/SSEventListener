//
//  UIView+SSGestureEventListener.m
//  SSEventListener
//
//  Created by Shengsheng on 13/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "UIView+SSGestureEventListener.h"
#import <objc/runtime.h>

static const void *SSGestureEventListenerKey = "SSGestureEventListenerKey";

@implementation UIView (SSGestureEventListener)

#pragma mark - API

- (UIGestureRecognizer *)ss_addTapEventListener:(SSTapEventListener)listener numberOfTapsRequired:(NSUInteger)numberOfTapsRequired {
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleTapEvent:)];
    [recognizer setNumberOfTapsRequired:numberOfTapsRequired];

    // set fail to each existing recognizer who's numberOfTapsRequired is smaller than taps
    NSArray *recognizers = [self gestureRecognizers];
    [recognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITapGestureRecognizer *r = (UITapGestureRecognizer *)obj;
        if (r.numberOfTapsRequired < numberOfTapsRequired) {
            [r requireGestureRecognizerToFail:recognizer];
        }
    }];

    [self addGestureRecognizer:recognizer];
    objc_setAssociatedObject(recognizer, SSGestureEventListenerKey, listener, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return recognizer;
}

- (UILongPressGestureRecognizer *)ss_addLongPressEventListener:(SSLongPressEventListener)listener minimumPressDuration:(CFTimeInterval)minimumPressDuration {
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleTapEvent:)];
    recognizer.minimumPressDuration = minimumPressDuration;

    [self addGestureRecognizer:recognizer];
    objc_setAssociatedObject(recognizer, SSGestureEventListenerKey, listener, OBJC_ASSOCIATION_COPY_NONATOMIC);

    return recognizer;
}

#pragma mark - Tap Event Handler

- (void)p_handleTapEvent:(UITapGestureRecognizer *)recognizer {
    SSTapEventListener listener = objc_getAssociatedObject(recognizer, SSGestureEventListenerKey);
    if (listener) {
        listener(recognizer);
    }
}

@end
