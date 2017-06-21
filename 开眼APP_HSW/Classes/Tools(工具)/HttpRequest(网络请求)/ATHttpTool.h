//
//  ATHttpTool.h
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATHttpSessionManager.h"
@interface ATHttpTool : NSObject
/**数据请求*/
+ (void)GET_urlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)POST_urlWithString:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  网络检测
 */
+(void)checkNetWork;
/**
 *  网络检测
 */
+(BOOL)reachability;
@end
