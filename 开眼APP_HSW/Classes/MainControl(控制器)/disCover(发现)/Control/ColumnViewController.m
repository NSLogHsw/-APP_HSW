//
//  ColumnViewController.m
//  yunEstate
//
//  Created by  677676  on 17/6/17.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ColumnViewController.h"
#import "DiscoveryCell.h"
#import "DiscoveryModel.h"

@interface ColumnViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *ListArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end

@implementation ColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"Love You";
    label.font = [UIFont fontWithName:MyEnFontTwo size:24];
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    // 流水布局:调整cell尺寸
    UICollectionViewFlowLayout *layout = [self setupCollectionViewFlowLayout];
    
    // 创建UICollectionView
    [self setupCollectionView:layout];
    
    // 获取网络数据
    [self getNetData];
    
}
#pragma mark - 创建流水布局
- (UICollectionViewFlowLayout *)setupCollectionViewFlowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (SCREENW - 9)/2;
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置最小行间距
    layout.minimumLineSpacing = 3;
    // 设置最小列间距
    layout.minimumInteritemSpacing = 1.5;
    
    return layout;
}
#pragma mark - 创建UICollectionView
- (void)setupCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.center = self.view.center;
    collection.bounds = self.view.bounds;
    collection.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collection];
    
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[DiscoveryCell class] forCellWithReuseIdentifier:@"Cell"];
    self.collectionView = collection;
}


-(void)getNetData{
    [self addHud];
    _ListArr = [[NSMutableArray alloc]init];
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v3/discovery";
    [ATHttpTool POST_urlWithString:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary *itemList = [responseObject objectForKey:@"itemList"];
        for (NSDictionary *dict in itemList) {
                NSString *type = [dict objectForKey:@"type"];
                if ([type isEqualToString:@"squareCard"]) {
                    NSDictionary *dataDic = dict[@"data"];
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    [arr addObject:dataDic];
                    for (NSDictionary *Dic in arr) {
                       DiscoveryModel * model =  [DiscoveryModel mj_objectWithKeyValues:Dic];
                        [_ListArr addObject:model];
                    }
                }
            }
          [_collectionView reloadData];
        [self removeHud];
    } failure:^(NSError * error) {
        [self removeHud];
    }];

}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _ListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoveryCell *cell = (DiscoveryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    DiscoveryModel *model = _ListArr[indexPath.row];
    [cell.ImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.titleLabel.text = model.title;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
//        PopularViewController *popular = [[PopularViewController alloc]init];
//        popular.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:popular animated:YES];
        
    }else if (indexPath.row == 1){
        
//        ProjectViewController *project = [[ProjectViewController alloc]init];
//        project.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:project animated:YES];
        
    }else{
        
//        DiscoveryDetailController *dis = [[DiscoveryDetailController alloc]init];
//        DiscoveryModel *model = _ListArr[indexPath.row];
//        dis.actionUrl = model.actionUrl;
//        dis.pageTitle = model.title;
//        dis.idStr = model.IdStr;
//        dis.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:dis animated:YES];
    }
}

#pragma mark - layout的代理事件
- (CGFloat)puBuLiuLayoutHeightForItemAtIndex:(NSIndexPath *)index {
    
    return SCREENH/4;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
