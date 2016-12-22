//
//  ViewController.swift
//  SwitchHost
//
//  Created by KING on 2016/12/22.
//  Copyright © 2016年 KING. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 程序每次启动都要调用此方法，保证URL 被设置
        SwitchHost.getLastSaveData("urls_0") { (data) in
            self.setURLData(data)
        }
    }
    
    @IBAction func switchHost(sender: UIButton) {
        let switchHost = SwitchHost.switchHostView({ (data) in
            self.setURLData(data)
            })
        self.presentViewController(switchHost, animated: true, completion: nil)
        
    }
    
    private func setURLData(data: [String: String]?) {
        print(data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

