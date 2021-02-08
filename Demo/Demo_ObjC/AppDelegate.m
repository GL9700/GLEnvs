//
//  AppDelegate.m
//  ObjC
//
//  Created by liguoliang on 2021/2/8.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    
    GLEnvs *env = [GLEnvs defaultWithEnvironments:@[
                   @{
                       @"开发环境":@{
                             @"host":@"https://www.baidu.com/s?wd=Development",
                             @"appkey":@"010222",
                             @"webhost":@"http://192.168.1.1",
                       }
                   },@{
                       @"测试环境":@{
                             @"host":@"https://www.baidu.com/s?wd=Test",
                             @"webhost":@"http://192.168.1.2",
                             @"appkey":@"1111111"
                         }
                   },@{
                       @"仿真环境":@{
                             @"host":@"https://www.baidu.com/s?wd=Simula",
                             @"webhost":@"http://192.168.1.3",
                             @"appkey":@"2222222"
                         }
                   },@{
                       @"线上环境":@{
                               @"appkey":@"3333333",
                               @"host":@"https://www.baidu.com/s?wd=Release",
                               @"webhost":@"http://192.168.1.4"
                       }
                   }
    ]];
    
    [env enableWithShakeMotion:YES defaultIndex:0];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
