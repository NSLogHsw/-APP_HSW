

#import <UIKit/UIKit.h>

@interface AuthorDetailController : UIViewController

@property (nonatomic, strong) NSString *authorId;

// 作者信息
@property (nonatomic, copy) NSString *authorName;

@property (nonatomic, copy) NSString *authorDesc;

@property (nonatomic, copy) NSString *authorIcon;

@end
