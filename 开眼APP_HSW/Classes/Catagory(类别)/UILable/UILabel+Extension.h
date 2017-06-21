//
//   UILabel (Extension)
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UILabel (Extension)
+ (void)showStats:(NSString *)stats atView:(UIView *)view ;
- (CGFloat)getTextWidth;
- (CGFloat)getTextHeight;
//@property(nonatomic,retain)UILabel * message;
@end
