//
//  SSUtils.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "SSUtils.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation SSUtils

+ (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertController *alertController = objc_getAssociatedObject([self class], @selector(showAlertViewWithMessage:));
    if (alertController) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        objc_setAssociatedObject([self class], @selector(showAlertViewWithMessage:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    alertController = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        objc_setAssociatedObject([self class], @selector(showAlertViewWithMessage:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }]];
    objc_setAssociatedObject([self class], @selector(showAlertViewWithMessage:), alertController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
