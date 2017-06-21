//
//  ATNavigationController.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ATNavigationController.h"
#import "ATBaseViewControl.h"
#import "MYScreenShotView.h"
#import "AppDelegate.h"





#define DISTANCE_TO_POP 10

@interface ATNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) MYScreenShotView *screenShotView;

@end

@implementation ATNavigationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.arrayScreenshot = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /// 屏蔽系统的手势
    self.interactivePopGestureRecognizer.enabled = NO;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.view addGestureRecognizer:self.panGesture];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self.view) {
        CGPoint translate = [gestureRecognizer translationInView:self.view];
        BOOL possible = translate.x != 0 && fabs(translate.y) == 0;
        if (possible)
            return YES;
        else
            return NO;
        return YES;
    }
    return NO;
}

/// 此方法可以解决滑动的冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")]|| [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPagingSwipeGestureRecognizer")]) {
        
        UIView *aView = otherGestureRecognizer.view;
        if ([aView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (UIScrollView *)aView;
            if (sv.contentOffset.x==0) {
                return YES;
            }
        }
        return NO;
    }
    return YES;
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    UIViewController *presentedViewController = rootViewController.presentedViewController;
    if (self.viewControllers.count == 1) {
        return;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        appDelegate.screenShotView.hidden = NO;
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point_inView = [panGesture translationInView:self.view];
        
        if (point_inView.x >= 10) {
            rootViewController.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
            presentedViewController.view.transform = CGAffineTransformMakeTranslation(point_inView.x - 10, 0);
        }
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x >= DISTANCE_TO_POP) {
            [UIView animateWithDuration:0.3 animations:^{
                rootViewController.view.transform = CGAffineTransformMakeTranslation(320, 0);
                presentedViewController.view.transform = CGAffineTransformMakeTranslation(320, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootViewController.view.transform = CGAffineTransformIdentity;
                presentedViewController.view.transform = CGAffineTransformIdentity;
                appDelegate.screenShotView.hidden = YES;
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                rootViewController.view.transform = CGAffineTransformIdentity;
                presentedViewController.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                appDelegate.screenShotView.hidden = YES;
            }];
        }
    }
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *array = [super popToViewController:viewController animated:animated];
    
    if (self.arrayScreenshot.count > array.count) {
        for (int i = 0; i < array.count; i++) {
            [self.arrayScreenshot removeLastObject];
        }
    }
    return array;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 0){
        return [super pushViewController:viewController animated:animated];
    } else if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appDelegate.window.frame.size.width, appDelegate.window.frame.size.height), YES, 0);
    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.arrayScreenshot addObject:viewImage];
    appDelegate.screenShotView.screenShotImageView.image = viewImage;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.arrayScreenshot removeLastObject];
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image) {
        appDelegate.screenShotView.screenShotImageView.image = image;
    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.arrayScreenshot.count > 2) {
        [self.arrayScreenshot removeObjectsInRange:NSMakeRange(1, self.arrayScreenshot.count - 1)];
    }
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image) {
        appDelegate.screenShotView.screenShotImageView.image = image;
    }
    return [super popToRootViewControllerAnimated:animated];
}

@end
