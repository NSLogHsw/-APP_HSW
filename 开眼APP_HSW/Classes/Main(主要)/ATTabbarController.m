//
//  ATTabbarController.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ATTabbarController.h"
#import "ATNavigationController.h"
#import "RecommendViewController.h"
#import "ColumnViewController.h"
#import "OnlineViewController.h"
#import "MineViewController.h"

@interface ATTabbarController ()

@end

@implementation ATTabbarController
- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子控制器
    [self createSubViewControllers];
    //设置所有的、分栏元素项
    [self setTabBarItems];
}

-(void)createSubViewControllers{
    
    RecommendViewController *One = [[RecommendViewController alloc]init];
    ATNavigationController *navi = [[ATNavigationController alloc]initWithRootViewController:One];
  
    
    ColumnViewController *Two = [[ColumnViewController alloc]init];
    ATNavigationController *navitwo = [[ATNavigationController alloc]initWithRootViewController:Two];

    
    OnlineViewController *Three = [[OnlineViewController alloc]init];
    ATNavigationController *navithree = [[ATNavigationController alloc]initWithRootViewController:Three];

    
    MineViewController *Four = [[MineViewController alloc]init];
    ATNavigationController *naviFour = [[ATNavigationController alloc]initWithRootViewController:Four];
 
    
    self.viewControllers = @[navi,navitwo,navithree,naviFour];
}

-(void)setTabBarItems{
    
    NSArray *titleArr = @[@"精选",@"发现",@"作者",@"我的"];
    NSArray *normalImgArr = @[@"ali1",@"011",@"win1",@"my1"];
    NSArray *selectedImgArr = @[@"aliSelete1",@"01Selete1",@"winSelete1",@"mySelete1"];
    //循环设置信息
    for (int i = 0; i<4; i++) {
        UIViewController *vc = self.viewControllers[i];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
        vc.tabBarItem.tag = i;
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    //self.navigationController.navigationBar 这个的话会有一个专题改不了，所以这用最高权限
    //获取导航条最高权限
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}



@end
