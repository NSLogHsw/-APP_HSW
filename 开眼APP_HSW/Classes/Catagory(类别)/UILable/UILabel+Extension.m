//
//   UILabel (Extension)
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//


#import "UILabel+Extension.h"
#import "UIView+Extension.h"

@implementation UILabel (Extension)

#pragma mark - 展示信息Lable
+ (void)showStats:(NSString *)stats atView:(UIView *)view {
    
    
    [view removeFromSuperview];
    
    UILabel *message = [[UILabel alloc] init];
    message.layer.cornerRadius = 5;
    message.clipsToBounds = YES;
    message.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    message.numberOfLines = 0;
    message.alpha = 1;
    message.font = [UIFont systemFontOfSize:14];
    message.textColor = [UIColor whiteColor];
    message.textAlignment = NSTextAlignmentCenter;
    message.text = stats;
  
    message.frame = CGRectMake(5, 5, [message getTextWidth] + 40, [message getTextHeight] + 20);
    message.center = view.center;
    [view addSubview:message];
  
    
    [UIView animateWithDuration:3 animations:^{
        message.alpha = .9;
    } completion:^(BOOL finished) {
        [message removeFromSuperview];
    }];
    
}

#pragma mark - 开发必备利器
- (CGFloat)getTextWidth
{
    CGSize newSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    return newSize.width;
}

- (CGFloat)getTextHeight
{
    CGSize newSize = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    return newSize.height;
}

@end
