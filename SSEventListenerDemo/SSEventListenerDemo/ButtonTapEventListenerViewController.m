//
//  ButtonTapEventListenerViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "ButtonTapEventListenerViewController.h"
#import <SSEventListener/SSEventListener.h>
#import "SSUtils.h"

@interface ButtonTapEventListenerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@end

@implementation ButtonTapEventListenerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTapButtonEventListener];
}

- (void)setupTapButtonEventListener {
    [_tapButton ss_setTapButtonEventListener:^{
        [SSUtils showAlertViewWithMessage:@"Button tapped!"];
    }];
}

- (IBAction)switchTapped:(UISwitch *)sender {
    if (sender.on) {
        [self setupTapButtonEventListener];
    } else {
        // remove tap listener
        [_tapButton ss_removeTapButtonEventListener];
    }
}

@end
