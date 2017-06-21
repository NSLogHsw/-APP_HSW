//
//  ATBaseViewControl.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATBaseViewControl : UIViewController
@property(nonatomic,retain)SVProgressHUD * hud;
//显示加载
- (void)addHud;
//显示加载带文字
- (void)addHudWithMessage:(NSString*)message;
//移除加载
- (void)removeHud;
//用户提示
- (void)addInfoHud:(NSString*)message;
//自定义图片
-(void)addImageCustom:(NSString  *)imgaeHudName status:(NSString *)status;
//加载失败
-(void)addHudError:(NSString *)status;
//加载成功
- (void)addHudWithSuccess:(NSString*)message;



/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势



@end
