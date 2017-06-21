

#import <Foundation/Foundation.h>

@interface AuthorModel : NSObject

// icon
@property (nonatomic, copy) NSString *icon;
// 作者
@property (nonatomic, copy) NSString *title;
// 视频数量
@property (nonatomic, copy) NSString *subTitle;
// 简介
@property (nonatomic, copy) NSString * descriptionS;
// ID
@property (nonatomic, copy) NSString *idS;
// actionUrl
@property (nonatomic, copy) NSString *actionUrl;


@end
