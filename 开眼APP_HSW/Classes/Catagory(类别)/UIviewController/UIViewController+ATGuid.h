//
//  UIViewController+ATGuid.h
//  yunEstate
//
//  Created by  677676  on 17/3/27.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ATGuid)<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>


//*实现引导页的控制器，外部不用调用即可实现GuidView,可以修改下面的图片*/




@end
/*这里是要展示的图片，修改即可,当然不止三个  1242 * 2208的分辨率最佳,如果在小屏手机上显示不全，最好要求UI重新设计图片*/

#define ImageArray @[@"封面0.jpg",@"封面1.jpg",@"封面2.jpg",@"封面3.jpg"]

/*
 如果要修改立即体验按钮的样式
 重新- (UIButton*)removeBtn方法即可
 */
