//
//  UIViewController+SSShakeEventListener.h
//  SSEventListener
//
//  Created by Shengsheng on 12/1/18.
//  Copyright © 2018 Shengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SSShakeEventListener)(void);

@interface UIViewController (SSShakeEventListener)

- (void)ss_setShakeEventListener:(SSShakeEventListener)listener;

- (void)ss_removeShakeEventListener;

- (SSShakeEventListener)ss_getShakeEventListener;

@end
