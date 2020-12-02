//
//  GLViewController.m
//  GLEnvs
//
//  Created by liandyii@msn.com on 04/29/2019.
//  Copyright (c) 2019 liandyii@msn.com. All rights reserved.
//

#import "GLViewController.h"
#import <GLEnvs.h>
@interface GLViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentOutputTextView;

@end

@implementation GLViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.contentOutputTextView.text = [NSString stringWithFormat:@"%@\n%@", [GLEnvs loadEnvName], [GLEnvs loadEnv]];
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"--I'm Motion from ViewController--");
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"ok" message:@"ok" preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"弹窗" message:@"测试GLEnv在有弹窗的情况下.\n结论:在已有弹窗情况下，也可以弹出 GLEnvs 选择器" preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}
@end
