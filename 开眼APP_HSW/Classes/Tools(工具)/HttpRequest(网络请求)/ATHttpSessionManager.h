//
//  ATHttpSessionManager.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ATHttpSessionManager : AFHTTPSessionManager
+ (instancetype)shareManager;
@end
