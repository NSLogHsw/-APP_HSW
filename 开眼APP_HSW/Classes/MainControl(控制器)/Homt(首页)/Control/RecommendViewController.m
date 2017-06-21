//
//  RecommendViewController.m
//  yunEstate
//
//  Created by  677676  on 17/6/17.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "RecommendViewController.h"
#import "ColumnViewController.h"
#import "VideoListModel.h"
#import "VideoListTableViewCell.h"
#import "DailyDetailViewController.h"

@interface RecommendViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ListArr;
@property (nonatomic, strong) NSString *NextPageStr;
@end

@implementation RecommendViewController


- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
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
 
    [self setNav];
    [self setTableView];
    [self getNetData];
    //【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
}


/**
 *  设置导航栏
 */
-(void)setNav{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"HuangShiWen";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
}
-(void)setTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.rowHeight = SCREENH/3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.tableView registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
-(void)setupRefresh{
    
    MJRefreshNormalHeader *header  =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer  =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}
// 获取数据
-(void)getNetData{
    [self addHud];
    
    _ListArr = [NSMutableArray array];
    NSString * str = [self changeTime:[self getdate]];
    NSString * urlStr = [NSString stringWithFormat:dailyList,(NSInteger)10,str];
    [ATHttpTool POST_urlWithString:urlStr parameters:nil success:^(id success) {
        
       self.NextPageStr = [NSString stringWithFormat:@"%@",success[@"nextPageUrl"]];
 
        NSDictionary *dailyListDict = [success objectForKey:@"dailyList"];
        
        for (NSDictionary *videoList in dailyListDict) {
           
         [_ListArr addObjectsFromArray: [VideoListModel mj_objectArrayWithKeyValuesArray:videoList[@"videoList"]]];
        }
        [self.tableView reloadData];
        [self removeHud];
        [self endRefresh];
        
        
    } failure:^(NSError * error) {
        [self removeHud];
        [self endRefresh];
    }];
    
    
}
// 加载更多
-(void)loadMore{
    if ([self.NextPageStr isEqualToString:@"<null>"]) {

        [self loadMoreEnd];
        
    }else{
        [self addHud];
        
        [ATHttpTool POST_urlWithString:self.NextPageStr parameters:nil success:^(id success) {
            
            self.NextPageStr = [NSString stringWithFormat:@"%@",success[@"nextPageUrl"]];
            
            NSDictionary *dailyListDict = [success objectForKey:@"dailyList"];
            
            for (NSDictionary *videoList in dailyListDict) {
                
          
                [_ListArr addObjectsFromArray: [VideoListModel mj_objectArrayWithKeyValuesArray:videoList[@"videoList"]]];
            }
            [self.tableView reloadData];
            [self removeHud];
            [self endRefresh];
            
            
        } failure:^(NSError * error) {
            [self removeHud];
            [self endRefresh];
        }];
    }
}
-(void)loadMoreEnd{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH/3)];
    footView.backgroundColor = [UIColor whiteColor];
    UILabel *footLabel = [[UILabel alloc]init];
    footLabel.frame = CGRectMake(0, self.view.height/2 - 10, self.view.width, 20);
    footLabel.font = [UIFont fontWithName:MyEnFontTwo size:14.f];
    footLabel.text = @"- The End -";
    [footView addSubview:footLabel];
    self.tableView.tableFooterView = footView;
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ListArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = _ListArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    detail.model = _ListArr[indexPath.row];
    [self presentViewController:detail animated:YES completion:nil];
}

/**
 *  时间
 *
 *
 */
-(NSTimeInterval)getdate{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]* 1000;
    return a;
}

// 获取当天的时间
-(NSString *)changeTime:(NSTimeInterval)time{
    
    time = time - 86400000 *5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time/ 1000.0 ];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyyMMdd"];
    NSString *str  = [objDateformat stringFromDate: date];
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
