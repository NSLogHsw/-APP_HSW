
//
//  RecommendViewController.h
//  yunEstate
//
//  Created by  677676  on 17/6/17.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface VideoPlayViewController : UIViewController

// 视频地址
@property(nonatomic,strong) NSString *UrlString;
// 视频标题
@property(nonatomic,strong) NSString *titleStr;
// 视频时长
@property(nonatomic, assign) double duration;

@end
