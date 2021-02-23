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
#import <UIKit/UIKit.h>
#import <GLEnvsProtocol.h>

/// 匹配模式 [完全 | 开头 | 包含 | 结尾]
typedef enum : NSUInteger {
    MatchAll,       // 完全匹配
    MatchPrefix,    // 匹配开头
    MatchSuffix,    // 匹配结尾
    MatchContain    // 包含即可
} MatchType;

@interface GLEnvs : NSObject

/// 监听环境切换，返回值: [` True 正常(直接退出app)  |  False 无需重启即刻生效(下次重启更新UI) `]
@property (nonatomic) BOOL(^handleListenerWillChange)(NSDictionary *curEnv, NSDictionary *toEnv);

/// 匹配模式，默认完全匹配 (只在PasteBoard模式生效)
@property (nonatomic) MatchType type;

/// 是否开启顶栏提示条
@property (nonatomic) BOOL showTopLine;


/// GLEnvs 全局单例
+ (GLEnvs *)defaultEnvs;

/// GLEnvs 初始化
/// @param envs 环境配置
/// @return GLEnvs 全局单例
/// @code
/// // 设置时
/// [GLEnvs defaultWithEnvironments:@[
///         @"测试环境":
///         @{
///             @"Host":@"http://www.baidu.com",
///             @"appkey":@"12345"
///         },
///         @"线上环境":
///         @{
///             @"Host":@"http://www.google.com",
///             @"appkey":@"fabcde"
///         }]
///];
+ (GLEnvs *)defaultWithEnvironments:(NSArray<NSDictionary *> *)envs;

/// 手动改变环境
/// @param index 环境列表索引下标
+ (void)manualChangeEnv:(NSUInteger)index;

/// 设置是否开启摇一摇环境切换(通过剪切板内容)
/// @param string 指定剪切板内容(默认完全匹配)
/// @param match 匹配成功，使用的环境索引下标
/// @param mismatch 匹配失败，使用的环境索引下标
/// @link 匹配类型详见 (MatchType)type
- (void)enableWithPasteBoardString:(NSString *)string matchingIndex:(NSUInteger)match mismatchingIndex:(NSUInteger)mismatch;

/// 设置使用自定义图标菜单进行环境切换
/// @param title 菜单显示内容(e.g. 可以是"扫一扫"等正常业务功能)
/// @param configViewController 弹出页面呢(e.g. 扫描特定二维码，输入特定内容等)
/// @param index 第一次(默认)使用的环境索引下标
- (void)enableWithShortCutItemString:(NSString *)title PresentConfig:(UIViewController<GLEnvsProtocol>*)configViewController defaultIndex:(NSUInteger)index;

/// 设置是否启用环境切换(通过摇一摇)
/// @param enable 是否开启环境切换
/// @param index 使用的环境索引下标
- (void)enableWithShakeMotion:(BOOL)enable defaultIndex:(NSUInteger)index;

/// 获取当前的环境
/// @return 当前环境的Dictionary
/// @code
/// // 获取当前环境的Host值
/// [GLEnvs loadEnv][@"Host"]
+ (NSDictionary *)loadEnv;

/// 获取当前环境的名称
/// @return 当前环境的名称
/// @code
/// // 获取当前环境的名称
/// NSString *currentEnvName = [GLEnvs loadEnvname];
+ (NSString *)loadEnvName;

@end
