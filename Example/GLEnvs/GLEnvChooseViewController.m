//
//  GLEnvChooseViewController.m
//  GLEnvs_Example
//
//  Created by liguoliang on 2020/12/2.
//  Copyright © 2020 liandyii@msn.com. All rights reserved.
//

#import "GLEnvChooseViewController.h"

@interface GLEnvChooseViewController ()

@end

@implementation GLEnvChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onClickButton_1:(UIButton *)sender {
    [[GLEnvs defaultEnvs] enableWithShakeMotion:YES defaultIndex:0];

}
- (IBAction)onClickButton_2:(UIButton *)sender {
    [[GLEnvs defaultEnvs] enableWithShakeMotion:NO defaultIndex:3];
}
- (IBAction)onClickButton_3:(UIButton *)sender {
    [GLEnvs manualChangeEnv:2];
}
- (IBAction)onClickButton_4:(UIButton *)sender {
    [GLEnvs manualChangeEnv:3];
}

@end
