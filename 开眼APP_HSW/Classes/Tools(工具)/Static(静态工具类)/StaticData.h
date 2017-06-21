//
//  StaticData.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticData : NSObject
#pragma mark - 数据存储在本地
+(void)saveData:(id)str forKey:(NSString *)key;
#pragma mark - 取出本地数据
+(id)getData:(NSString *)key;
@end
