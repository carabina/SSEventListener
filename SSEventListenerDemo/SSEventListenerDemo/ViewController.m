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

@property (weak, nonatomic) IBOutlet UIButton *switchButton;

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
}

- (IBAction)switchButtonTapped:(id)sender {
    if ([self ss_getShakeEventListener]) { // check if shake event listener is set
        // remove shake event listener
        [self ss_removeShakeEventListener];
        [_switchButton setTitle:@"Set Shake Event Listener" forState:UIControlStateNormal];
    } else {
        // set shake event listener for the view controller
        __weak typeof(self) weakSelf = self;
        [self ss_setShakeEventListener:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf showAlertViewWithMessage:@"Shake event detected!"];
        }];
        [_switchButton setTitle:@"Remove Shake Event Listener" forState:UIControlStateNormal];
    }
}

- (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end

