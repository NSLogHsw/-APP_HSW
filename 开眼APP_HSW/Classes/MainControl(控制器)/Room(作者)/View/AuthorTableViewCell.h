

#import <UIKit/UIKit.h>

@interface AuthorTableViewCell : UITableViewCell

// icon
@property (nonatomic, strong) UIImageView *iconImage;
// 作者
@property (nonatomic, strong) UILabel *authorLabel;
// 视频数量
@property (nonatomic, strong) UILabel *videoCount;
// 简介
@property (nonatomic, strong) UILabel *desLabel;


@end
