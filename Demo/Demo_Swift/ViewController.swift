//
//  ViewController.swift
//  Demo_Swift
//
//  Created by liguoliang on 2021/2/8.
//

import UIKit
import GLEnvs

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Demo_Swift"
        label.text = GLEnvs.loadEnv()["host"] as? String
        label.sizeToFit()
        label.center = self.view.center
    }
    
    lazy var label:UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        return label
    }()
}

