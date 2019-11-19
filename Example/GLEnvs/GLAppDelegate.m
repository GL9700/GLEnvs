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
    
    [[GLEnvs defaultWithEnvironments:@[@{@"开发环境":@{@"host":@"Development Environment", @"appkey":@"000000"}},
                                       @{@"测试环境":@{@"host":@"Test Environment", @"appkey":@"1111111"}},
                                       @{@"仿真环境":@{@"host":@"Emulate Environment", @"appkey":@"2222222"}},
                                       @{@"线上环境":@{@"host":@"Release Environment", @"appkey":@"3333333"}}
                                       ]] enableChangeEnvironment:YES withSelectIndex:0];
    return YES;
}
@end
