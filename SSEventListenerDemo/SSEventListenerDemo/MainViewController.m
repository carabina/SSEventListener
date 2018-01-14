//
//  MainViewController.m
//  SSEventListenerDemo
//
//  Created by Shengsheng on 14/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import "MainViewController.h"
#import "ShakeEventListenerViewController.h"
#import "ApplicationEventListenerViewController.h"
#import "ViewGestureEventListenerViewController.h"
#import "ButtonTapEventListenerViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
}

#pragma mark - Table View Delegate and Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"Shake Event Listener Demo";
            break;
        }
        case 1: {
            cell.textLabel.text = @"Application Event Listener Demo";
            break;
        }
        case 2: {
            cell.textLabel.text = @"UIView Gesture Event Listener Demo";
            break;
        }
        case 3: {
            cell.textLabel.text = @"UIButton Tap Event Listener Demo";
            break;
        }
        default: {

        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: {
            vc = [sb instantiateViewControllerWithIdentifier:@"ShakeEventListenerViewController"];
            break;
        }
        case 1: {
            vc = [sb instantiateViewControllerWithIdentifier:@"ApplicationEventListenerViewController"];
            break;
        }
        case 2: {
            vc = [sb instantiateViewControllerWithIdentifier:@"ViewGestureEventListenerViewController"];
            break;
        }
        case 3: {
            vc = [sb instantiateViewControllerWithIdentifier:@"ButtonTapEventListenerViewController"];
            break;
        }
        default: {

        }
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
