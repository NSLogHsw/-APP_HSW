

#import "AuthorDetailController.h"
#import "NavHeadTitleView.h"
#import "HeadView.h"
#import "VideoListTableViewCell.h"
#import "VideoListModel.h"
#import "DailyDetailViewController.h"
#import "ShareView.h"

@interface AuthorDetailController ()<UITableViewDelegate,UITableViewDataSource,NavHeadTitleViewDelegate>
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
    NSMutableArray *_dataArray0;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, strong) UILabel *topLine;

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UIButton *seleBtn;

@property (nonatomic, strong) NSString *NextPageStr;

@property (nonatomic, strong) NSArray *controllers;

@property (nonatomic, strong) NSString *RequestUrl;


@property (nonatomic, strong) UIImageView *backgroundImgV;//背景图
@property (nonatomic, assign) float backImgHeight;
@property (nonatomic, assign) float backImgWidth;
@property (nonatomic, assign) float backImgOrgy;
@property (nonatomic, strong) NavHeadTitleView *NavView;//导航栏
@property (nonatomic, strong) HeadView *headImageView;
@property (nonatomic, strong) UIView *headLineView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) int rowHeight;

@end

@implementation AuthorDetailController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setHeadView];
    [self createNav];
    self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",AuthorDetail1,self.authorId,AuthorDetail2];
    [self loadData];
    [self setTableView];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self setupRefresh];
}

-(void)setupRefresh{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    
    self.tableView.mj_footer = footer;
}

// 头视图
-(void)setHeadView{
    
    _headImageView = [[HeadView alloc]init];
    _headImageView.frame = CGRectMake(0, 64, SCREENW, 170);
    _headImageView.backgroundColor = [UIColor whiteColor];
    
    [_headImageView.imageView sd_setImageWithURL:[NSURL URLWithString:self.authorIcon]];
    _headImageView.NameLab.text = self.authorName;
    _headImageView.contentLab.text = self.authorDesc;
//    [self.view addSubview:_headImageView];
}

-(void)createNav{
    
    self.NavView = [[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 64)];
    self.NavView.title = @"";
    self.NavView.color = [UIColor whiteColor];
    self.NavView.backTitleImage = @"backImage@2x";
    self.NavView.rightTitleImage = @"icon_share_n@2x";
    self.NavView.delegate = self;
    [self.view addSubview:self.NavView];
}
// 左按钮
-(void)NavHeadback{
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 右按钮回调
-(void)NavHeadToRight{
    
    NSArray *shareAry = @[@{@"image":@"shareView_wx@2x",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend@2x",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq@2x",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_wb@2x",
                            @"title":@"新浪微博"},
                          @{@"image":@"shareView_qzone@2x",
                            @"title":@"QQ空间"},
                          @{@"image":@"share_copyLink",
                            @"title":@"复制链接"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:MyChinFont size:16.f];
    label.text = @"分享";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headerView.frame.size.height-0.5, headerView.frame.size.width - 40, 0.5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 40, 0.5)];
    lineLabel1.backgroundColor = [UIColor blackColor];
    
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

- (void)easyCustomShareViewButtonAction:(ShareView *)shareView title:(NSString *)title {
    
    NSLog(@"当前点击:%@",title);
}

#pragma mark -- 创建TabView
-(void)setTableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
}

#pragma mark -- 加载数据
-(void)loadData{

    self.modelArr = [[NSMutableArray alloc]init];
  [ATHttpTool POST_urlWithString:self.RequestUrl parameters:nil success:^(id responseObject) {
       self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
  
      self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
      
      NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
      
      for (NSDictionary *dict in itemListDict) {
          
          NSDictionary *dataDict = dict[@"data"];
          
          VideoListModel *model = [[VideoListModel alloc]init];
          model.coverForDetail = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
          model.title = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
          model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
          model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
          model.descriptionS = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
          model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
          NSDictionary *Dic = dataDict[@"consumption"];
          model.consumption = Dic;
          
          [_modelArr addObject:model];
      }
      [self.tableView reloadData];
      [SVProgressHUD dismiss];
      [self endRefresh];
  } failure:^(NSError * error) {
       [self endRefresh];
  }];

}

#pragma mark -- 加载更多
-(void)loadMore{
    
    if ([self.NextPageStr isEqualToString:@"<null>"]) {
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        [ATHttpTool POST_urlWithString:self.RequestUrl parameters:nil success:^(id responseObject) {
            self.NextPageStr = [NSString stringWithFormat:@"%@",responseObject[@"nextPageUrl"]];
            
            NSDictionary *itemListDict = [responseObject objectForKey:@"itemList"];
            
            for (NSDictionary *dict in itemListDict) {
                
                NSDictionary *dataDict = dict[@"data"];
                
                VideoListModel *model = [[VideoListModel alloc]init];
                model.coverForDetail = [NSString stringWithFormat:@"%@",dataDict[@"cover"][@"detail"]];
                model.title = [NSString stringWithFormat:@"%@",dataDict[@"title"]];
                model.category = [NSString stringWithFormat:@"%@",dataDict[@"category"]];
                model.duration = [NSString stringWithFormat:@"%@",dataDict[@"duration"]];
                model.descriptionS = [NSString stringWithFormat:@"%@",dataDict[@"description"]];
                model.playUrl = [NSString stringWithFormat:@"%@",dataDict[@"playUrl"]];
                NSDictionary *Dic = dataDict[@"consumption"];
                model.consumption = Dic;
                
                [_modelArr addObject:model];
            }
            
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [self endRefresh];
        } failure:^(NSError * error) {
            [self endRefresh];
        }];
        
    }
}

#pragma mark -- 结束刷新
-(void)endRefresh{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 头像点击事件
-(void)tapClick:(UITapGestureRecognizer *)recognizer{
    NSLog(@"你打到我的头了");
}
// 修改昵称
-(void)fixClick:(UIButton *)btn{
    NSLog(@"修改昵称");
}

#pragma mark -- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENH/3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_headLineView) {
        _headLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, 40)];
        _headLineView.backgroundColor = [UIColor whiteColor];
        
        NSArray *arr = [NSArray arrayWithObjects:@"按时间排序",@"分享排行榜", nil];
        for (int i = 0;i < 2;i ++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(SCREENW/2), 5, SCREENW/2, 30);
            btn.tag = i;
            [btn setTitle:arr[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(headBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [_headLineView addSubview:btn];
            if (i == 0)
            {   btn.selected = YES;
                self.seleBtn = btn;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            } else {
                btn.selected = NO;
            }
        }
        CGFloat lineWidth = SCREENW/4;
        self.line = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2,35, lineWidth, 0.5)];
        self.line.backgroundColor = [UIColor grayColor];
        self.line.tag = 100;
        [_headLineView addSubview:self.line];
        
        self.topLine = [[UILabel alloc]initWithFrame:CGRectMake(lineWidth/2, 5, lineWidth, 0.5)];
        self.topLine.backgroundColor = [UIColor grayColor];
        self.topLine.tag = 101;
        [_headLineView addSubview:self.topLine];
    }
    return _headLineView;
}

- (void)headBtnClick:(UIButton*)sender
{
    if (sender.tag == 0) {
        self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",AuthorDetail1,self.authorId,AuthorDetail2];
        
    }else{
        self.RequestUrl = [NSString stringWithFormat:@"%@%@%@",AuthorShare1,self.authorId,AuthorShare2];
    }
    [self loadData];
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.seleBtn.selected = NO;
    self.seleBtn = sender;
    self.seleBtn.selected = YES;
    self.seleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.line.center;
        frame.x = SCREENW/4 + SCREENW/2 * (sender.tag);
        self.line.center = frame;
        
        CGPoint frame2 = self.topLine.center;
        frame2.x = SCREENW/4 + SCREENW/2 * (sender.tag);
        self.topLine.center = frame2;
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = _modelArr[indexPath.row];
    return cell;
}

//转换时间格式
-(NSString *)timeStrFormTime:(NSString *)timeStr
{
    int time = [timeStr intValue];
    int minutes = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d'%02d\"",minutes,second];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyDetailViewController *detail = [[DailyDetailViewController alloc]init];
    detail.model = _modelArr[indexPath.row];
    [self presentViewController:detail animated:YES completion:nil];
}

#pragma mark -- 移动变色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y <= 170) {
        self.NavView.headBgView.alpha = scrollView.contentOffset.y/170;
        self.NavView.backTitleImage = @"backImage@2x";
        self.NavView.rightImageView = @"icon_share_n@2x";
        self.NavView.color = [UIColor whiteColor];
        //状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    }else{
        self.NavView.headBgView.alpha = 1;
        self.NavView.title = self.authorName;
        self.NavView.backTitleImage = @"backImage@2x";
        self.NavView.rightImageView = @"icon_share_n@2x";
        self.NavView.color = [UIColor blackColor];
        // 隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        //状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
    
    if (contentOffsety < 0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
    }
}



@end
