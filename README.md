![logo](https://github.com/GL9700/gl9700.github.io/blob/master/GLSLogo_800.png?raw=true)
# GLEnvs

[![CI Status](https://img.shields.io/travis/liandyii@msn.com/GLEnvs.svg?style=flat)](https://travis-ci.org/liandyii@msn.com/GLEnvs)
[![Version](https://img.shields.io/cocoapods/v/GLEnvs.svg?style=flat)](https://cocoapods.org/pods/GLEnvs)
[![License](https://img.shields.io/cocoapods/l/GLEnvs.svg?style=flat)](https://cocoapods.org/pods/GLEnvs)
[![Platform](https://img.shields.io/cocoapods/p/GLEnvs.svg?style=flat)](https://cocoapods.org/pods/GLEnvs)

在Debug环境中，使用摇一摇可以快速切换已配置好的网络环境，也可以直接自定义网络环境。

## Installation

GLEnvs is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GLEnvs'
```

## Simple User
1. 进行配置
	```objc
	...
		GLEnvs *envs = [GLEnvs defaultWithEnvironments:@[
            @{
                @"测试环境":@{
                    @"host":@"http://192.168.1.1:8080",
                    @"nimKey":@"debugkey333",
                    @"wxKey":@"debugkey123"
                }  
            },@{
                @"正式环境":@{
                    @"host":@"https://www.baidu.com",
                    @"nimKey":@"releasekey111",
                    @"wxKey":@"releasekey222"
                }
            }
		]];
		[envs enableChangeEnvironment:<#开启环境切换#> withSelectIndex:<#环境的索引编号#>];

        // 例如
        // [envs enableChangeEnvironment:YES withSelectIndex:0];   // 使用者可以切换环境，使用 envs[0] 作为当前环境 
        // [envs enableChangeEnvironment:NO withSelectIndex:1];    // 使用者无法切换环境，使用 envs[1] 作为当前环境
		
	...
	```

2. 使用
	```objc
	...
	NSString * key = [GLEnvs loadEnv][@"nimKey"];	// [GLEnvs loadEvn]:获取当前环境，[@"nimKey"]:环境中对应的Key值
	...
	```

## Subspec
None

## Requirements
None

## History
* 1.2.8 - 2020-04-02
    * 修复一个在Debug状态下重修改环境字典未重新加载的问题（正式环境不受影响）
* 1.2.5
    * 维护:增加了更加明确和更加详细的注释。
* 1.2.4
    * 迁移:Github
* 1.2.3
    * 修复:方法交换问题
    * 增加:版本号显示
* 1.2.2
    * 修复:修复一个崩溃Bug，对event做类型验证然后再进行后续操作
* 1.2.1
    * 优化:当前环境显示问题，从小方块修改成全屏条幅
* 1.2.0
    * 修复:一系列在真机导致崩溃的问题
* 1.1.2
    * fix Environment Save FAILED & Improve Save/Load to Archive
* 1.0.0
    * first commit

## Author
liguoliang, 36617161@qq.com

## License

GLEnvs is available under the MIT license. See the LICENSE file for more info.
