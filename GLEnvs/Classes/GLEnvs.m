//
//  GLEnvs.m
//
//  Created by liguoliang on 2018/8/10.
//

#import "GLEnvs.h"
#import "objc/message.h"
#import "GLEnvsCustomController.h"

#define kGLEnvsNameKey        @"EnvsNameKey"
#define kGLEnvsInfoKey        @"EnvsInfoKey"
#define kArchivePath          [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"GLENV.data"]
#define kGLEnvsCustomTitle    @"✍️ 自定义"
#define kGLEnvsSelectorTipStr @"*** 切换环境后,程序将自动退出 ***"

typedef void (*VIM) (id, SEL, ...);
@interface GLEnvs ()
{
    BOOL inScreen;
}
@property (nonatomic, strong) NSArray *envs;
@property (nonatomic) UIViewController *shortcutViewController;
@property (nonatomic) UIAlertController *actionSheet;
@end

static GLEnvs *instance;
NSString * const GLENV_SHORTCUT_TITLE = @"com.glenv.shortcut";
@implementation GLEnvs

+ (GLEnvs *)defaultEnvs {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GLEnvs alloc]init];
        [instance shortCutRemoveItemWithType:GLENV_SHORTCUT_TITLE];
    });
    return instance;
}

+ (GLEnvs *)defaultWithEnvironments:(NSArray<NSDictionary *> *)envs {
    if (!instance) [GLEnvs defaultEnvs];
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

+ (BOOL)saveEnv:(NSDictionary *)eInfo {
    return [NSKeyedArchiver archiveRootObject:eInfo toFile:kArchivePath];
}

+ (void)manualChangeEnv:(NSUInteger)index {
    if(index<[GLEnvs defaultEnvs].envs.count){
        NSDictionary *envDic = [GLEnvs defaultEnvs].envs[index];
        NSDictionary *curDict = [GLEnvs loadEnv];
        if ([GLEnvs saveEnv:envDic]) {
            if([GLEnvs defaultEnvs].handleListenerWillChange) {
                if([GLEnvs defaultEnvs].handleListenerWillChange(curDict, envDic)) {
                    exit(1);
                }
            }
            else{
                exit(1);
            }
        }
    }
}
- (void)defaultEnvIndex:(NSUInteger)index {
    NSAssert(index < self.envs.count, @"环境配置列表越界");
    if([GLEnvs loadEnv] == nil){
        [GLEnvs saveEnv:self.envs[index]];
    }
}
- (void)shortCutAddItem:(UIApplicationShortcutItem *)item {
    BOOL isFindItem = NO;
    for (UIApplicationShortcutItem *itemp in [UIApplication sharedApplication].shortcutItems) {
        if([itemp.type isEqualToString:item.type]){
            isFindItem = YES;
        }
    }
    if(isFindItem==NO){
        NSArray *shortcutItems = [[UIApplication sharedApplication].shortcutItems arrayByAddingObject:item];
        [UIApplication sharedApplication].shortcutItems = shortcutItems;
    }
}
- (void)shortCutRemoveItemWithType:(NSString *)type {
    int index = -1;
    for (int i=0;i<[UIApplication sharedApplication].shortcutItems.count;i++) {
        UIApplicationShortcutItem *itemp = [UIApplication sharedApplication].shortcutItems[i];
        if([itemp.type isEqualToString:type]){
            index = i;
        }
    }
    if(index>=0) {
        NSMutableArray *shortcutItems = [[UIApplication sharedApplication].shortcutItems mutableCopy];
        [shortcutItems removeObjectAtIndex:index];
        [UIApplication sharedApplication].shortcutItems = [shortcutItems copy];
    }
}

- (void)_glenv_application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if([self respondsToSelector:@selector(application:performActionForShortcutItem:completionHandler:)]){
        if([shortcutItem.type isEqualToString:@"com.glenv.shortcut"]) {
            if([GLEnvs defaultEnvs].shortcutViewController){
                UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
                while (rootVC.presentedViewController) {
                    rootVC = rootVC.presentedViewController;
                }
                [rootVC presentViewController:[GLEnvs defaultEnvs].shortcutViewController animated:YES completion:nil];
            }
        }
        [[GLEnvs defaultEnvs] _glenv_application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
    }
}

- (void)enableWithShortCutItemString:(NSString *)title PresentConfig:(UIViewController<GLEnvsProtocol>*)configViewController defaultIndex:(NSUInteger)index{
    [self defaultEnvIndex:index];
    if(configViewController!=nil){
        self.shortcutViewController = configViewController;
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:GLENV_SHORTCUT_TITLE localizedTitle:title];
        [self shortCutAddItem:item];
        
        Method method1 = class_getInstanceMethod([UIApplication sharedApplication].delegate.class, @selector(application:performActionForShortcutItem:completionHandler:));
        Method method2 = class_getInstanceMethod(self.class, @selector(_glenv_application:performActionForShortcutItem:completionHandler:));
        if(method1 == NULL){
            class_addMethod([UIApplication sharedApplication].delegate.class, @selector(application:performActionForShortcutItem:completionHandler:), method_getImplementation(method2), method_getTypeEncoding(method2));
        }else{
            method_exchangeImplementations(method1, method2);
        }
    }
}

- (void)enableWithPasteBoardString:(NSString *)string matchingIndex:(NSUInteger)match mismatchingIndex:(NSUInteger)mismatch {
    NSString *pbcontent = UIPasteboard.generalPasteboard.string;
    BOOL enable = NO;
    switch (self.type) {
        case MatchPrefix:
            enable = [pbcontent hasPrefix:string];
            break;
        case MatchSuffix:
            enable = [pbcontent hasSuffix:string];
            break;
        case MatchContain:
            enable = [pbcontent containsString:string];
            break;
        default:
            enable = [pbcontent isEqualToString:string];
            break;
    }
    [self enableWithShakeMotion:enable defaultIndex:enable ? match : mismatch];
}

- (void)enableWithShakeMotion:(BOOL)enable defaultIndex:(NSUInteger)selectIndex {
    NSAssert(selectIndex < self.envs.count, @"环境配置列表越界");
    NSString *currentEnvName = [GLEnvs loadEnvName];
    NSDictionary *currentEnv = [GLEnvs loadEnv];
    NSDictionary *newEnv = nil;
    NSDictionary *envDic = self.envs[selectIndex];
    // 未找到环境(写入新环境)
    if(currentEnv == nil){
        [GLEnvs saveEnv:envDic];
    }
    // 不允许修改环境(始终使用最新环境)
    if (enable == NO) {
        [GLEnvs saveEnv:envDic];
    }else{
        for (NSDictionary *tempEnv in self.envs) {
            if([tempEnv.allKeys.firstObject isEqualToString:currentEnvName]){
                newEnv = tempEnv[currentEnvName];
            }
        }
        // 环境不同(重写保存环境，并使用最新))
        if(newEnv && ![newEnv isEqualToDictionary:currentEnv]){
            [GLEnvs saveEnv:envDic];
        }
        SEL selor = @selector(motionEnded:withEvent:);
        Method m = class_getInstanceMethod([UIResponder class], selor);
        IMP nimp = imp_implementationWithBlock(^(id self, UIEventSubtype motion, UIEvent *event) {
            if ([event isKindOfClass:[UIEvent class]]) {
                if (event.type == UIEventTypeMotion && motion == UIEventSubtypeMotionShake) {
                    GLEnvs *envs = [GLEnvs performSelector:NSSelectorFromString(@"defaultEnvs")];
                    [envs performSelector:NSSelectorFromString(@"showEnvChanger") withObject:nil afterDelay:0.0];
                }
            }
        });
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        method_setImplementation(m, nimp);
    }
}

- (void)applicationDidBecomeActive {
    if (inScreen == NO) {
        [self showEnvInScreen];
    }
}

#pragma mark- 当前环境HUD
- (void)showEnvInScreen {
    NSString *keystr = [GLEnvs loadEnvName];
    if (keystr) {
        NSMutableString *showStr = [NSMutableString string];
        for (int i = 0; i < 20; i++) {
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
        if ([UIApplication sharedApplication].keyWindow != nil) {
            [[UIApplication sharedApplication].keyWindow addSubview:tipLabel];
            inScreen = YES;
        }
    }
}

#pragma mark- 显示环境切换列表
- (void)showEnvChanger {
    if(self.actionSheet.presentingViewController==nil) {
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }
        [rootVC presentViewController:self.actionSheet animated:YES completion:nil];
    }
}

- (UIAlertController *)actionSheet {
    if(!_actionSheet) {
        NSDictionary *info = [NSBundle mainBundle].infoDictionary;
        NSString *title = [NSString stringWithFormat:@"%@ | 版本:%@ | Build:%@", info[@"CFBundleDisplayName"] ? : info[@"CFBundleName"], info[@"CFBundleShortVersionString"], info[@"CFBundleVersion"]];
        _actionSheet = [UIAlertController alertControllerWithTitle:title message:kGLEnvsSelectorTipStr preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 所有环境
        for (int i = 0; i < self.envs.count; i++) {
            NSDictionary *envDic = self.envs[i];
            NSString *envName = envDic.allKeys.firstObject;
            NSString *sheetTitle = envName;
            if([[GLEnvs loadEnvName] isEqualToString:envName]){
                sheetTitle = [NSString stringWithFormat:@"%@", envName];
            }
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:sheetTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                NSDictionary *curDict = [GLEnvs loadEnv];
                if ([GLEnvs saveEnv:envDic]) {
                    if([GLEnvs defaultEnvs].handleListenerWillChange) {
                        if([GLEnvs defaultEnvs].handleListenerWillChange(curDict, envDic)) {
                            exit(1);
                        }
                    }
                    else{
                        exit(1);
                    }
                }
            }];
            alertAction.enabled = ![[GLEnvs loadEnvName] isEqualToString:envName];
            [_actionSheet addAction:alertAction];
        }
        
        // 自定义
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:kGLEnvsCustomTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            GLEnvsCustomController *controller = [GLEnvsCustomController new];
            controller.data = [[GLEnvs loadEnv] mutableCopy];
            controller.handleSave = ^(NSDictionary *_Nonnull newdata) {
                NSDictionary *curDict = [GLEnvs loadEnv];
                if ([GLEnvs saveEnv:@{kGLEnvsCustomTitle: newdata}]) {
                    if([GLEnvs defaultEnvs].handleListenerWillChange) {
                        if([GLEnvs defaultEnvs].handleListenerWillChange(curDict, newdata)) {
                            exit(1);
                        }
                    }
                    else{
                        exit(1);
                    }
                }
            };
            UINavigationController *envNav = [[UINavigationController alloc]initWithRootViewController:controller];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:envNav animated:YES completion:nil];
        }];
        alertAction.enabled = YES;
        [_actionSheet addAction:alertAction];
        
        // 取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_actionSheet addAction:cancelAction];
        
        
    }
    return _actionSheet;
}
@end
