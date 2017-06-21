//
//  ATSwTextView.h
//  yunDichan
//
//  Created by  677676  on 16/11/4.
//  Copyright © 2016年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATSwTextView : UITextView
@property (nonatomic, strong) UILabel * placeHolderLabel;

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIColor * placeholderColor;

- (void)textChanged:(NSNotification * )notification;


@end
