//
//  ATHttpSessionManager.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [tagButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}

+ (instancetype)itemWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}

+ (instancetype)itemWithTitle:(NSString *)title ImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [tagButton setTitle:title forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tagButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    tagButton.size = tagButton.currentImage.size;
    tagButton.width += 40;
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagButton];
}

- (BOOL)selected
{
    UIButton *button = self.customView;
    
    return button.selected;
}

- (void)setSelected:(BOOL)selected
{
    UIButton *button = self.customView;
    button.selected = selected;
}

//更新最新
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}



@end
