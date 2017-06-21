//
//  MYScreenShotView.h
//  MYNavigationController
//
//  Created by michael on 2017/6/6.
//  Copyright © 2017年 MYNavigationController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYScreenShotView : UIView

@property (nonatomic, strong) UIImageView *screenShotImageView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *screenShotImages;

@end
