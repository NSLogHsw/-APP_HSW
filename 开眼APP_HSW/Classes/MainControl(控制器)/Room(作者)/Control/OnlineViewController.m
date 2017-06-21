//
//  OnlineViewController.m
//  yunEstate
//
//  Created by  677676  on 17/6/17.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "OnlineViewController.h"
#import "AuthorTableViewCell.h"
#import "AuthorTableViewCell.h"
#import "AuthorModel.h"
#import "AuthorDetailController.h"
@interface OnlineViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *TableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) NSDictionary *Dict;

@property (nonatomic, strong) NSString *nextPageUrl;
@end
  static NSString *iDs = @"cell";
@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextPageUrl = [NSString new];
    
    [self setNavi];
    [self setTableView];
    [self getNetData];
    
    //默认【下拉刷新】
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    //默认【上拉加载】
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self setupRefresh];
}

-(void)setupRefresh{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getNetData];
    }];
    self.TableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    self.TableView.mj_footer = footer;
}

-(void)setTableView{
    
    _TableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.rowHeight = 70;
    [_TableView registerClass:[AuthorTableViewCell class] forCellReuseIdentifier:iDs];
    
    [self.view addSubview:_TableView];
}

-(void)setNavi{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"eyepetizer";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


-(void)getNetData{
    [self addHud];
    self.modelArr = [[NSMutableArray alloc]init];
    
    [ATHttpTool POST_urlWithString:Author parameters:nil success:^(id responseObject) {
        NSArray *itemListArr = [responseObject objectForKey:@"itemList"];
        
                self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
        
                for (NSDictionary *dict in itemListArr) {
                    NSDictionary *dataDict = dict[@"data"];
                    AuthorModel *model = [AuthorModel mj_objectWithKeyValues:dataDict];
                    [_modelArr addObject:model];
                }
                [self.TableView reloadData];
                [self endRefresh];
                [self removeHud];
    } failure:^(NSError * error) {
        [self endRefresh];
        [self removeHud];
    }];
}

-(void)endRefresh{
    
    [self.TableView.mj_header endRefreshing];
    [self.TableView.mj_footer endRefreshing];
}

-(void)loadMore{
    
    if ([self.nextPageUrl isEqualToString:@"<null>"]) {
        
        [self.TableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        [self addHud];
        [ATHttpTool POST_urlWithString:Author parameters:nil success:^(id responseObject) {
            self.nextPageUrl = nil;
            NSArray *itemListArr = [responseObject objectForKey:@"itemList"];
            
            self.nextPageUrl = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            
            for (NSDictionary *dict in itemListArr) {
                NSDictionary *dataDict = dict[@"data"];
                AuthorModel *model = [AuthorModel mj_objectWithKeyValues:dataDict];
                [_modelArr addObject:model];
            }
            [self.TableView reloadData];
            [self endRefresh];
            [self removeHud];
        } failure:^(NSError * error) {
            [self endRefresh];
            [self removeHud];
        }];

    }
}

#pragma mark -- TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    AuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iDs];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    AuthorModel *model = _modelArr[indexPath.row];
    if (kStringIsEmpty(model.title) ) {
        model.subTitle = @"黄世文";
    }
    cell.authorLabel.text = model.title;
    cell.desLabel.text = model.descriptionS;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthorDetailController *detail = [[AuthorDetailController alloc]init];
    AuthorModel *model = _modelArr[indexPath.row];
    detail.authorId = model.idS;
    detail.authorIcon = model.icon;
    detail.authorDesc = model.descriptionS;
    detail.authorName = model.title;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    detail.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
