

#import <Foundation/Foundation.h>

@interface VideoListModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *coverForDetail;

@property (nonatomic, copy) NSString *shadeView;

/** 标题 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString * descriptionS;

@property (nonatomic, copy) NSDictionary *consumption;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSString *actionUrl;

@property (nonatomic, copy) NSString *idStr;


@end
