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

/**
 * @brief 初始化
 * @param envs 环境配置。
 * @return GLEnvs全局单例
 * @warning 使用时请参考 @see `+(NSDictionary *)loadEnv`
 * @discussion
 * 遵循"先设置，后使用"的规则。
 * @code
 * // 设置时
 * [GLEnvs defaultWithEnvironments:@[@"测试环境":@{@"Host":@"http://www.baidu.com", @"appkey":@"12345"}]];
 *
 */
+ (GLEnvs *)defaultWithEnvironments:(NSArray<NSDictionary *> *)envs;

/**
 * @brief 设置是否开启环境切换 并设置默认使用的环境索引
 * @param enable 是否开启环境切换
 * @param selectIndex 使用的环境索引号(0~N)
 */
- (void)enableChangeEnvironment:(BOOL)enable withSelectIndex:(NSUInteger)selectIndex;

/**
 * @brief 获取当前的环境
 * @return 当前环境的Dictionary
 * @code
 * // 获取当前环境的Host值
 * [GLEnvs loadEnv][@"Host"]
 */
+ (NSDictionary *)loadEnv;

/**
 * @brief 获取当前环境的名称
 * @return 当前环境的名称
 * @code
 * // 获取当前环境的名称
 * NSString *currentEnvName = [GLEnvs loadEnvname];
 */
+ (NSString *)loadEnvName;

@end
