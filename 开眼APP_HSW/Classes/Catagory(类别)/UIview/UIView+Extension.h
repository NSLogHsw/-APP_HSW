//
//  UIView (Extension)
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/**
 *  获取当前view所在的控制器
 */
- (UIViewController*)getCurrentViewController;

+(instancetype)gf_viewFromXib;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration;

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration;
- (void)removeAllSubviews;

@end
