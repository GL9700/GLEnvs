//
//  ViewController.m
//  ObjC
//
//  Created by liguoliang on 2021/2/8.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo_ObjC";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.label.text = [GLEnvs loadEnv][@"host"];
    [self.label sizeToFit];
    self.label.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", [GLEnvs loadEnv]);
}

- (UILabel *)label {
    if(!_label) {
        _label = [UILabel new];
        [self.view addSubview:_label];
    }
    return _label;
}


@end
