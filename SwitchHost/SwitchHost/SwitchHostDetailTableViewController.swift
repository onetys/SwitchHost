//
//  SwitchHostDetailTableViewController.swift
//  LoginURL
//
//  Created by KING on 2016/12/22.
//  Copyright © 2016年 KING. All rights reserved.
//

import UIKit

class SwitchHostDetailTableViewController: UITableViewController {
    
    var content: [String : String] = [String : String]()
    
    private lazy var titles: [String] = {
        var result = [String]()
        for (name,value) in self.content {
            result.append(name)
        }
        return result
    }()
    
    private lazy var subTitles: [String] = {
        var result = [String]()
        for (name,value) in self.content {
            result.append(value)
        }
        return result
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView.init(frame: self.view.bounds, style: .Plain)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "reuseIdentifier")
        }

        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = subTitles[indexPath.row]

        return cell
    }
 

 }
