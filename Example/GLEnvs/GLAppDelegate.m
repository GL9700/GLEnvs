//
//  GLAppDelegate.m
//  GLEnvs
//
//  Created by liandyii@msn.com on 04/29/2019.
//  Copyright (c) 2019 liandyii@msn.com. All rights reserved.
//

#import "GLAppDelegate.h"
#import <GLEnvs.h>

@implementation GLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    
    GLEnvs *env = [GLEnvs defaultWithEnvironments:@[
                   @{
                       @"开发环境":@{
                             @"host":@"Development Environment",
                             @"appkey":@"010222",
                             @"webhost":@"http://192.168.1.4",
                       }
                   },@{
                       @"测试环境":@{
                             @"host":@"Test Environment",
                             @"webhost":@"http://192.168.1.6",
                             @"appkey":@"1111111"
                         }
                   },@{
                       @"仿真环境":@{
                             @"host":@"Emulate Environment",
                             @"webhost":@"http://192.168.1.3",
                             @"appkey":@"2222222"
                         }
                   },@{
                       @"线上环境":@{
                             @"host":@"Release Environment",
                             @"webhost":@"http://192.168.1.4",
                             @"appkey":@"3333333"
                       }
                   }
    ]];
    [env enableChangeEnvironment:YES withSelectIndex:0];
    return YES;
}
@end
