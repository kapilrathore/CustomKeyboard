//
//  ViewController.swift
//  VisionDemo
//
//  Created by kapilrathore-mbp on 21/01/20.
//  Copyright © 2020 Kapil Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults(suiteName: "asdf")?.set("what!!", forKey: "asdf")
        UserDefaults.init
    }
}
