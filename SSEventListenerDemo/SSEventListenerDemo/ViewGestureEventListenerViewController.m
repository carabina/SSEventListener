//
//  ViewGestureEventListenerViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "ViewGestureEventListenerViewController.h"
#import <SSEventListener/SSEventListener.h>
#import "SSUtils.h"

@interface ViewGestureEventListenerViewController ()

@property (weak, nonatomic) IBOutlet UIView *gestureView;
@property (strong, nonatomic) UIGestureRecognizer *tripleTapRecognizer;

@end

@implementation ViewGestureEventListenerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set single tap event listener
    [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        [SSUtils showAlertViewWithMessage:@"Single tapped!"];
    } numberOfTapsRequired:1];
    
    // set double tap event listener
    [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        [SSUtils showAlertViewWithMessage:@"Double tapped!"];
    } numberOfTapsRequired:2];
    
    [self setupTripleTapEventListener];
    
    // set long press event listener
    [_gestureView ss_addLongPressViewEventListener:^(UILongPressGestureRecognizer *recognizer) {
        if (recognizer.state == UIGestureRecognizerStateBegan) {
            [SSUtils showAlertViewWithMessage:@"Long pressed!"];
        }
    } minimumPressDuration:2];  // 2 seconds
}

- (void)setupTripleTapEventListener {
    _tripleTapRecognizer = [_gestureView ss_addTapViewEventListener:^(UITapGestureRecognizer *recognizer) {
        [SSUtils showAlertViewWithMessage:@"Triple tapped!"];
    } numberOfTapsRequired:3];
}

- (IBAction)enableTripleTapSwitchTapped:(UISwitch *)sender {
    if (sender.on) {
        [self setupTripleTapEventListener];
    } else {
        // remove triple tap event listener
        [_gestureView removeGestureRecognizer:_tripleTapRecognizer];
    }
}

@end
