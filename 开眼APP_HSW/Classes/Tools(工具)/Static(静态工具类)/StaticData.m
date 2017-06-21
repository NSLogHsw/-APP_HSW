//
//  StaticData.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "StaticData.h"

@implementation StaticData

+(void)saveData:(id)str forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)getData:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
