//
//  ATHttpTool.m
//  yunEstate
//
//  Created by  677676  on 17/3/23.
//  Copyright © 2017年 艾腾软件. All rights reserved.
//

#import "ATHttpTool.h"
static bool checkNetWork;

@implementation ATHttpTool
+ (void)GET_urlWithString:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    
//    [SVProgressHUD reveal];
    
    ATHttpSessionManager *manager = [ATHttpSessionManager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            [SVProgressHUD dismiss];
            success(responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
//            [SVProgressHUD revealErrorWithStatus:@"请求失败"];
        }
    }];
}
+ (void)POST_urlWithString:(NSString *)url parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
//    [SVProgressHUD reveal];
    
    ATHttpSessionManager *manager = [ATHttpSessionManager shareManager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            [SVProgressHUD dismiss];
            success(responseDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
//            [SVProgressHUD revealErrorWithStatus:@"请求失败"];
        }
    }];
    
}


#pragma mark- 网络监测
+(void)checkNetWork
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                checkNetWork=YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                checkNetWork=YES;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            {
                checkNetWork=NO;
                // [MBProgressHUD showError:@"无网络连接"];
                
            }
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                checkNetWork=NO;
                //[MBProgressHUD showError:@"未知网络"];
                
                NSLog(@"未知网络");
                break;
                
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}
+(BOOL)reachability
{
    return checkNetWork;
}
- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


@end
