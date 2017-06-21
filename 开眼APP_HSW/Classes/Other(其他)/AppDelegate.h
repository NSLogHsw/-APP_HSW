//
//  AppDelegate.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATTabbarController.h"
@class MYScreenShotView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MYScreenShotView *screenShotView;

+ (AppDelegate* )shareAppDelegate;
@end



