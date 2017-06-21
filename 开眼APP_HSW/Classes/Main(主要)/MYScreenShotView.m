//
//  MYScreenShotView.m
//  MYNavigationController
//
//  Created by michael on 2017/6/6.
//  Copyright © 2017年 MYNavigationController. All rights reserved.
//

#import "MYScreenShotView.h"
#import "AppDelegate.h"

static char listenToPopGestureRecognizerKey[] = "listenToPopGestureRecognizerKey";

@implementation MYScreenShotView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.screenShotImages = [NSMutableArray array];
    self.backgroundColor = [UIColor blackColor];
    self.screenShotImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    self.maskView = [[UIView alloc] initWithFrame:self.bounds];
    self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
    [self addSubview:self.screenShotImageView];
    [self addSubview:self.maskView];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    [rootViewController.view addObserver:self forKeyPath:@"transform"
                                 options:NSKeyValueObservingOptionNew
                                 context:listenToPopGestureRecognizerKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == listenToPopGestureRecognizerKey) {
        NSValue *value  = [change objectForKey:NSKeyValueChangeNewKey];
        CGAffineTransform newTransform = [value CGAffineTransformValue];
        [self showEffectChange:CGPointMake(newTransform.tx, 0)];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)showEffectChange:(CGPoint)point
{
    if (point.x > 0) {
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:-point.x / 320.0 * 0.4 + 0.4];
        self.screenShotImageView.transform = CGAffineTransformMakeScale(0.95 + (point.x / 320.0 * 0.05), 0.95 + (point.x / 320.0 * 0.05));
    }
}

- (void)restore
{
    if (self.maskView && self.screenShotImageView) {
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
        self.screenShotImageView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }
}

- (void)screenShot
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), YES, 0);
    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    self.screenShotImageView.image = sendImage;
    self.screenShotImageView.transform = CGAffineTransformMakeScale(0.95, 0.95);
}

- (void)dealloc
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    [rootViewController.view removeObserver:self forKeyPath:@"transform" context:listenToPopGestureRecognizerKey];
}

@end
