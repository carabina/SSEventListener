//
//  ShakeEventListenerViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "ShakeEventListenerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SSEventListener/SSEventListener.h>
#import "SSUtils.h"

@interface ShakeEventListenerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (assign, nonatomic) BOOL shakeEventListenerSet;

@end

@implementation ShakeEventListenerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shakeEventListenerSet = NO;
}

- (IBAction)switchButtonTapped:(id)sender {
    _shakeEventListenerSet = !_shakeEventListenerSet;
    if (_shakeEventListenerSet) {
        // set shake event listener for the view controller (self)
        [self ss_setShakeEventListener:^{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); // vibrate
            [SSUtils showAlertViewWithMessage:@"Shake event detected!"];
        }];
        
        [_switchButton setTitle:@"Remove Shake Event Listener" forState:UIControlStateNormal];
        _statusLabel.text = @"Shake event listener set, please shake your device!";
    } else {
        // remove shake event listener
        [self ss_removeShakeEventListener];
        
        [_switchButton setTitle:@"Set Shake Event Listener" forState:UIControlStateNormal];
        _statusLabel.text = @"Shake event listener not set.";
    }
}

@end
