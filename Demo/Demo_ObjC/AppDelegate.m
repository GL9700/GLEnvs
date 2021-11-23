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
    
//    [[[[GLEnvs defaultEnvs]
//        registEnvsWithName:@"开发环境" Index:0 Content:@{
//            @"host":@"https://www.baidu.com/s?wd=Development",
//            @"appkey":@"010222",
//            @"webhost":@"http://192.168.1.1",
//        }]
//        registEnvsWithName:@"测试环境" Index:1 Content:@{
//            @"host":@"https://www.baidu.com/s?wd=Test",
//            @"webhost":@"http://192.168.1.2",
//            @"appkey":@"1111111"
//        }]
//        registEnvsWithName:@"仿真环境" Index:2 Content:@{
//            @"host":@"https://www.baidu.com/s?wd=Simula",
//            @"webhost":@"http://192.168.1.3",
//            @"appkey":@"2222222"
//    }];
    
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
    env.showTopLine = YES;
    [env enableWithShakeMotion:YES defaultIndex:0];
    
    /// 增加针对切换环境的监听器
    // 不定义 / 返回 YES ： 切换环境立刻重启App
    // 返回NO           ： 立刻生效，重启App后刷新状态
    env.handleListenerWillChange = ^BOOL(NSDictionary *curEnv, NSDictionary *toEnv) {
        NSLog(@"Current:%@", curEnv);   // 当前环境
        NSLog(@"To:%@", toEnv); // 切换至

        // 立刻退出app，然后再次进入可以切换环境
        // 如果返回NO，那么立刻切换环境 ( 页面和数据暂时无法同步，需要重启App来刷新界面数据 )
        return YES;
    };
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
