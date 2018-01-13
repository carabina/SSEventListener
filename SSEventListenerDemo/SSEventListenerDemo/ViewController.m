//
//  ViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "ViewController.h"
#import <SSEventListener/SSEventListener.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shakeSwitchButton;
@property (weak, nonatomic) IBOutlet UIView *gestureView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set application event listener
    __weak typeof(self) weakSelf = self;
    [self ss_setApplicationEventListener:^(NSNotificationName notificationName, UIApplication *application) {
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"Detected application event: %@", notificationName);
        
        // check notificationName to see what application event happened
        if ([notificationName isEqualToString:UIApplicationDidBecomeActiveNotification]) {
            [strongSelf showAlertViewWithMessage:@"Application become active!"];
        } else if ([notificationName isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
            [strongSelf showAlertViewWithMessage:@"Application received memory warning!"];
        }
    }];

    // set tap event listener for tapView
    [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf showAlertViewWithMessage:@"Single tapped!"];
    }                   numberOfTapsRequired:1];

    [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf showAlertViewWithMessage:@"Double tapped!"];
    }                   numberOfTapsRequired:2];

    UIGestureRecognizer *tripleTapRecognizer = [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf showAlertViewWithMessage:@"Triple tapped!"];
    }                                                              numberOfTapsRequired:3];

    // remove listener for triple tap after 5 seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_gestureView removeGestureRecognizer:tripleTapRecognizer];
        [self showAlertViewWithMessage:@"Triple tap listener removed!"];
    });

    // set long press event listener for tapView
    [_gestureView ss_addLongPressViewEventListener:^(UILongPressGestureRecognizer *recognizer) {
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf showAlertViewWithMessage:@"Long pressed!"];
        }
    }                         minimumPressDuration:2];

    // set tap event listener for shakeSwitchButton
    [_shakeSwitchButton ss_addTapButtonEventListener:^{
        static BOOL willSetShakeEventListener = YES;
        if (willSetShakeEventListener) {
            // set shake event listener for the view controller
            [self ss_setShakeEventListener:^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf showAlertViewWithMessage:@"Shake event detected!"];
            }];
            [_shakeSwitchButton setTitle:@"Remove Shake Event Listener" forState:UIControlStateNormal];
        } else {
            // remove shake event listener
            [self ss_removeShakeEventListener];
            [_shakeSwitchButton setTitle:@"Set Shake Event Listener" forState:UIControlStateNormal];
        }
        willSetShakeEventListener = !willSetShakeEventListener;
    }];
}

- (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

