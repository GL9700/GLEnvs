//
//  GLEnvs.h
//
//  Created by liguoliang on 2018/8/10.
//

/*
 * ------------设置------------
 * GLEnvs *envs = [GLEnvs defaultWithEnvironments:@[
 *  @{@"TEST":@{@"HOST":@"<testHost>",@"Value":@"<testValue>"}},
 *  @{@"DEV":@{@"HOST":@"<devHost>",@"Value":@"<devValue>"}},
 *  @{@"Release":@{@"HOST":@"<releaseHost>",@"Value":@"<releaseValue>"}}
 *  ]];
 * [envs enableChangeEnvironment:YES withSelectIndex:0];
 *
 * ------------使用------------
 * NSURL *url = [[GLEnvs loadEnv][@"HOST"] stringByAppendingPathComponent:@"xx/xx"];
 * NSString *key = [GLEnvs loadEnv][@"Value"];
 */
#import <Foundation/Foundation.h>

@interface GLEnvs : NSObject

/** 初始化 */
+ (GLEnvs *)defaultWithEnvironments:(NSArray<NSDictionary *>*)envs;

/** 设置是否开启环境切换 并设置默认使用的环境索引 */
- (void)enableChangeEnvironment:(BOOL)enable withSelectIndex:(NSUInteger)selectIndex;

/** return:当前的环境 */
+ (NSDictionary *)loadEnv;
+ (NSString *)loadEnvName;
@property(nonatomic, strong) NSMutableString *output;
@end
