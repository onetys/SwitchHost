//
//  SwitchHost.swift
//  RosettaTobMainApp
//
//  Created by KING on 2016/11/18.
//  Copyright © 2016年 SHENMA NETWORK TECHNOLOGY (SHANGHAI) Co.,Ltd. All rights reserved.
//

import Foundation

import UIKit

private let SwitchHostViewControllerCellReuseID = "SwitchHostViewControllerCellReuseID"


class SwitchHost : UITableViewController{
    
    var viewModel: SwitchHostViewModel = SwitchHostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SwitchHost"
        self.commitInitView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.relodData()
        self.tableView.reloadData()
    }
    
    private func commitInitView() {
        
        // right item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: #selector(addNewURL))
        
        // right item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Cancel, target: self, action: #selector(dismiss))
        
        // table view
        let tableView = UITableView.init(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame)), style: .Grouped)
        tableView.backgroundColor = UIColor.init(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        tableView.rowHeight = 44
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: SwitchHostViewControllerCellReuseID)
        self.tableView = tableView
    }
    
    func dismiss() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addNewURL() {
        self.navigationController?.pushViewController(SwitchHostEditorTableViewController(), animated: true)
    }
    
    class func switchHostView(alterData: ((data: [String : String])->Void)?) -> UINavigationController {
        let switchHost = SwitchHost()
        switchHost.viewModel.alterData = alterData
        return UINavigationController.init(rootViewController: switchHost)
    }
}

// MARK: - show

extension SwitchHost{

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel.allNames.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(SwitchHostViewControllerCellReuseID, forIndexPath: indexPath)
        if indexPath.section < self.viewModel.allNames.count {
            let name = self.viewModel.allNames[indexPath.section]
            cell.textLabel?.text = name
            cell.accessoryType = name == self.viewModel.currentHostName ? .DetailButton : .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.viewModel.selectedAtIndexPath(indexPath)
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.viewModel.canEditorAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let allName = self.viewModel.allNames
            if indexPath.section < allName.count {
                self.viewModel.deleteEditor(allName[indexPath.section])
                self.viewModel.allNames.removeAtIndex(indexPath.section)
                tableView.deleteSections(NSIndexSet.init(index: indexPath.section), withRowAnimation: .Middle)
            }
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let show = SwitchHostDetailTableViewController()
        show.content = self.viewModel.contentAtIndexPath(indexPath)
        self.navigationController?.pushViewController(show, animated: true)
    }
    
}


