
#import "VideoListModel.h"

@implementation VideoListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
            @"descriptionS": @"description",
             };
}
@end
