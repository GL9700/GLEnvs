//
//  GLEnvs.m
//
//  Created by liguoliang on 2018/8/10.
//

#import "GLEnvs.h"
#import "objc/message.h"
#import <UIKit/UIKit.h>
#import "GLEnvsCustomController.h"

#define kGLEnvsNameKey @"EnvsNameKey"
#define kGLEnvsInfoKey @"EnvsInfoKey"
#define kArchivePath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"GLENV.data"]
#define kGLEnvsCustomTitle @"自定义"
#define kGLEnvsSelectorTipStr @"*** 切换环境后,程序将自动退出 ***"

typedef void (* VIM) (id , SEL , ...);
@interface GLEnvs()
{
    BOOL inScreen;
}
@property (nonatomic , strong) NSArray *envs;
@end

static GLEnvs *instance;
@implementation GLEnvs

+ (GLEnvs *)defaultEnvs {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GLEnvs alloc]init];
    });
    return instance;
}

+ (GLEnvs *)defaultWithEnvironments:(NSArray<NSDictionary *>*)envs{
    if(!instance)
        [GLEnvs defaultEnvs];
    instance.envs = envs;
    return instance;
}

+ (NSDictionary *)loadEnv {
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:kArchivePath];
    return dic.allValues.firstObject;
}

+ (NSString *)loadEnvName {
    NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:kArchivePath];
    return dic.allKeys.firstObject;
}

+ (BOOL)saveEnv:(NSDictionary *)eInfo{
    return [NSKeyedArchiver archiveRootObject:eInfo toFile:kArchivePath];
}

- (void)enableChangeEnvironment:(BOOL)enable withSelectIndex:(NSUInteger)selectIndex {
    //default :NO :0
    NSAssert(selectIndex<self.envs.count, @"环境配置列表越界");
    if([GLEnvs loadEnv]==nil || enable==NO) {
        NSDictionary *envDic = self.envs[selectIndex];
        [GLEnvs saveEnv:envDic];
    }
    if(enable==YES){
        SEL selor = @selector(motionEnded:withEvent:);
        Method m = class_getInstanceMethod([UIResponder class], selor);
        VIM oimp = (VIM)method_getImplementation(m);
        IMP nimp = imp_implementationWithBlock(^(id self ,UIEventSubtype motion, UIEvent *event){
            if([event isKindOfClass:[UIEvent class]]){
                if (event.type == UIEventTypeMotion && motion == UIEventSubtypeMotionShake) {
                    GLEnvs *envs = [GLEnvs performSelector:NSSelectorFromString(@"defaultEnvs")];
                    [envs performSelector:NSSelectorFromString(@"showEnvChanger") withObject:nil afterDelay:0.0];
                }
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    if([self isKindOfClass:[UIResponder class]] && [self respondsToSelector:selor]){
//                        oimp(self, selor, motion, event);
//                    }
//                });
            }
        });
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        method_setImplementation(m, nimp);
    }
}

- (void)applicationDidBecomeActive {
    if(inScreen==NO){
        [self showEnvInScreen];
    }
}

#pragma mark- 当前环境HUD
- (void)showEnvInScreen {
    NSString *keystr = [GLEnvs loadEnvName];
    if(keystr){
        NSMutableString *showStr = [NSMutableString string];
        for(int i=0;i<20;i++){
            [showStr appendFormat:@"%@ ", keystr];
        }
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        tipLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10);
        tipLabel.text = showStr;
        tipLabel.lineBreakMode = NSLineBreakByClipping;
        tipLabel.font = [UIFont systemFontOfSize:10];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.6];
        tipLabel.frame = CGRectInset(tipLabel.frame, 0, -5);
        tipLabel.textAlignment = NSTextAlignmentCenter;
        if([UIApplication sharedApplication].keyWindow!=nil){
            [[UIApplication sharedApplication].keyWindow addSubview:tipLabel];
            inScreen = YES;
        }
    }
}

#pragma mark- 显示环境切换列表
- (void)showEnvChanger {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if(topVC.presentedViewController == nil){
        NSDictionary *info = [NSBundle mainBundle].infoDictionary;
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"<%@> 版本:%@ | Build:%@", info[@"CFBundleDisplayName"], info[@"CFBundleShortVersionString"], info[@"CFBundleVersion"]] message:kGLEnvsSelectorTipStr preferredStyle:UIAlertControllerStyleActionSheet];
        for(int i=0;i<self.envs.count;i++) {
            NSDictionary *envDic = self.envs[i];
            NSString *eName = envDic.allKeys.firstObject;
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:eName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if([GLEnvs saveEnv:envDic]){
                    exit(1);
                }
            }];
            alertAction.enabled = ![[GLEnvs loadEnvName] isEqualToString:eName];
            [actionSheet addAction:alertAction];
        }
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:kGLEnvsCustomTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            GLEnvsCustomController *controller = [GLEnvsCustomController new];
            controller.data = [[GLEnvs loadEnv] mutableCopy];
            controller.saveHandle = ^(NSDictionary * _Nonnull newdata) {
                if([GLEnvs saveEnv:@{kGLEnvsCustomTitle:newdata}]){
                    exit(1);
                }
            };
            UINavigationController *envNav = [[UINavigationController alloc]initWithRootViewController:controller];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:envNav animated:YES completion:nil];
        }];
        alertAction.enabled = YES;
        [actionSheet addAction:alertAction];
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
        [topVC presentViewController:actionSheet animated:YES completion:nil];
    }
}

@end
