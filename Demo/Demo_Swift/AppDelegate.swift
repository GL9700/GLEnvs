//
//  AppDelegate.swift
//  Demo_Swift
//
//  Created by liguoliang on 2021/2/8.
//

import UIKit
import GLEnvs

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /// setup GLEnvs Params & return GLEnvs Instance
        let envs:GLEnvs = GLEnvs.default(withEnvironments: [
                        ["开发环境"  : [
                              "host"    : "https://www.baidu.com/s?wd=Development",
                              "appkey"  : "010222",
                              "webhost" : "http://192.168.1.1",
                        ]],
                        ["测试环境":[
                              "host"    : "https://www.baidu.com/s?wd=Test",
                              "webhost" : "http://192.168.1.2",
                              "appkey"  : "1111111"
                        ]],
                        ["仿真环境":[
                              "host"    : "https://www.baidu.com/s?wd=Simula",
                              "webhost" : "http://192.168.1.3",
                              "appkey"  : "2222222"
                        ]],
                        ["线上环境":[
                            "appkey"    : "3333333",
                            "host"      : "https://www.baidu.com/s?wd=Release",
                            "webhost"   : "http://192.168.1.4"
                        ]]
        ])
        
        /// set GLEnvs Enable in app and show mode
        envs.enable(withShakeMotion: true, defaultIndex: 0)
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        return true
    }
}

