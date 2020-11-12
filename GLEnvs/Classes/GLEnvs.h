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

typedef enum : NSUInteger {
    MatchAll,       // 完全匹配
    MatchPrefix,    // 匹配开头
    MatchSuffix,    // 匹配结尾
    MatchContain    // 包含即可
} MatchType;

@interface GLEnvs : NSObject

/// 匹配类型，默认完全匹配 (只在PasteBoard模式生效)
@property (nonatomic) MatchType type;

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
 * @brief 设置使用剪切板指定内容开启环境切换功能 并设置默认使用的环境索引
 * @param string 指定剪切板内容
 * @param match 如果匹配成功，使用的环境索引号(0~N)
 * @param mismatch 如果匹配失败，使用的环境索引号(0~N)
 */
- (void)enableWithMatchingPasteBoardString:(NSString *)string useIndex:(NSUInteger)match mismatchingIndex:(NSUInteger)mismatch;

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
