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
    }
    
    @IBAction func switchHost(sender: UIButton) {
        
        self.presentViewController(SwitchHost.switchHostView({ (data) in
            print(data)
        }), animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

