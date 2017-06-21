//
//  AppDelegate.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "AppDelegate.h"
#import "ATTabbarController.h"
#import "MYScreenShotView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    
    self.window.rootViewController = [[ATTabbarController alloc] init];
    
    self.screenShotView = [[MYScreenShotView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    [self.window insertSubview:self.screenShotView atIndex:0];
    self.screenShotView.hidden = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
