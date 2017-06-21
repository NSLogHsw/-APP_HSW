//
//  ATBaseViewControl.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ATBaseViewControl.h"

@interface ATBaseViewControl ()

@end

@implementation ATBaseViewControl


- (id)init{
    self = [super init];
    if (self) {
        self.enablePanGesture = YES;

    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
}
- (void)addHud
{
    [SVProgressHUD showWithStatus:@"加载中"];
}
- (void)addHudWithMessage:(NSString*)message
{
    [SVProgressHUD showWithStatus:message];
}
- (void)addHudWithSuccess:(NSString*)message
{
    [SVProgressHUD showSuccessWithStatus:message];
}
- (void)removeHud
{
    [SVProgressHUD dismiss];
}
-(void)addInfoHud:(NSString*)message{
    [SVProgressHUD showInfoWithStatus:message];
}
-(void)addImageCustom:(NSString *)imgaeHudName status:(NSString *)status{
    [SVProgressHUD showImage:[UIImage imageNamed:imgaeHudName] status:status];
}
-(void)addHudError:(NSString *)status{
    [SVProgressHUD showErrorWithStatus:status];
}


@end
