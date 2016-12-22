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
        
        // 1. 自定义文件夹名称
        
        SwitchHost.getLastSaveData("urls_0", configure: { (host) in
            host.setURLPlistName("customHost")
            }) { (data) in
                self.setURLData(data)
        }
        
        // 2. 默认寻找 SwitchHost.plist
        
        // SwitchHost.getLastSaveData("urls_0") { (data) in
            //self.setURLData(data)
        //}
    }
    
    @IBAction func switchHost(sender: UIButton) {
        
        let switchHost = SwitchHost.switchHostView({ (data) in
            self.setURLData(data)
            })
        
        // plist 文件名称
        switchHost.setURLPlistName("customHost")
        
        // 自定义显示名称 需要比URL 个数多一个，第一个为自定义名称的提示语
        switchHost.setShowName(["请输入自定义名字","百度","腾讯","小米"])
        
        self.presentViewController(UINavigationController.init(rootViewController:switchHost), animated: true, completion: nil)
        
    }
    
    private func setURLData(data: [String: String]?) {
        print(data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

