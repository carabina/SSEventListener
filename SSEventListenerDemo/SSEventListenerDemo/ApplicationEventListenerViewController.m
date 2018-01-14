//
//  ApplicationEventListenerViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "ApplicationEventListenerViewController.h"
#import <SSEventListener/SSEventListener.h>
#import "SSUtils.h"

@interface ApplicationEventListenerViewController ()

@end

@implementation ApplicationEventListenerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set application event listener
    [self ss_setApplicationEventListener:^(NSNotificationName notificationName, UIApplication *application) {
        NSLog(@"Detected application event: %@", notificationName);
        
        // check notificationName to see what application event happened
        if ([notificationName isEqualToString:UIApplicationDidBecomeActiveNotification]) {
            [SSUtils showAlertViewWithMessage:@"Application become active!"];
        } else if ([notificationName isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
            [SSUtils showAlertViewWithMessage:@"Application received memory warning!"];
        }
    }];
}

@end
