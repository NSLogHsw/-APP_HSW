//
//  SWHorizontalButton.m
//  大麦APP_Hsw
//
//  Created by  677676  on 17/1/17.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "SWHorizontalButton.h"

@implementation SWHorizontalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.height = 15;
    self.titleLabel.width = [self.titleLabel getTextWidth];
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.centerY = self.titleLabel.centerY;
    self.width = [self.titleLabel getTextWidth] + self.imageView.width + 5;
}

@end
