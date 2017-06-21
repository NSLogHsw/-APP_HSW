
#import "AuthorModel.h"

@implementation AuthorModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"idS":@"id",
            @"descriptionS":@"description"
             };
}
@end
