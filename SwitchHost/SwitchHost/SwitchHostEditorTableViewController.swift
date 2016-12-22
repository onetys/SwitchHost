//
//  SwitchHostEditorTableViewController.swift
//  LoginURL
//
//  Created by KING on 2016/12/22.
//  Copyright © 2016年 KING. All rights reserved.
//

import UIKit

class SwitchHostEditorTableViewController: UIViewController {
    
    weak var viewModel: SwitchHostViewModel!
    
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commitInitView()
    }
    
    private func commitInitView() {
        
        // right item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Done, target: self, action: #selector(editorDone))

        // scroll view
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: CGRectGetHeight(self.view.frame)))
        scrollView.keyboardDismissMode = .Interactive
        scrollView.backgroundColor = UIColor.init(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        
        
        var _y: CGFloat = 20
        
        if self.viewModel.plistHostList.count > 0 {
            
            // segmentControl
            let segmentControl = UISegmentedControl.init(items: self.viewModel.plistHostList + ["clear"])
            segmentControl.frame = CGRectMake((scrollView.frame.size.width - segmentControl.frame.size.width) / 2.0, 20, segmentControl.frame.size.width, segmentControl.frame.size.height)
            segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), forControlEvents: .ValueChanged)
            scrollView.addSubview(segmentControl)
            
            _y += CGRectGetMaxY(segmentControl.frame)
        }
        
        
        // text firelds
        var index: CGFloat = 0
        
        var maxHeight: CGFloat = 0
        
        let width = self.view.frame.size.width - 2 * 10
        
        for name in self.viewModel.showName {
            
            let textField = UITextField.init(frame: CGRect.init(x: 10, y: _y + index * (40 + 20), width: width, height: 40))
            
            textField.backgroundColor = UIColor.whiteColor()
            
            textField.placeholder = name
            
            textField.tag = 500 + Int(index)
            
            textField.layer.cornerRadius = 4
            
            textField.layer.masksToBounds = true
            
            scrollView.addSubview(textField)
            
            maxHeight = CGRectGetMaxY(textField.frame)
            
            index += 1
            
        }
        
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), maxHeight + 270)
        
        self.scrollView = scrollView
        
        self.view.addSubview(self.scrollView)
    }
    
    // 完成编辑
    func editorDone() {
        let result: NSMutableDictionary = NSMutableDictionary()
        
        var index = 0
        
        for view in self.scrollView.subviews {
            // 输入框
            if view.isKindOfClass(UITextField.classForCoder()) {
                guard let textF = view as? UITextField, let text = textF.text where !text.isEmpty else {
                    index += 1
                    return
                }
                result.setObject(text, forKey: self.viewModel.urlNames[index])
                index += 1
            }
        }
        
        if let name = result["name"] as? String {
            if self.viewModel.urlNames.contains(name) {
                return
            }
        }
        
        self.viewModel.saveResult(result)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func segmentControlAction(control: UISegmentedControl) {
        
        if control.selectedSegmentIndex == control.numberOfSegments - 1 {
            for view in self.scrollView.subviews {
                if let textField = view as? UITextField {
                    textField.text = nil
                }
            }
            return
        }
        
        let content = self.viewModel.getPlistContent(self.viewModel.plistHostList[control.selectedSegmentIndex])
        
        let values = content.allValues
        
        for view in self.scrollView.subviews {
            if let textField = view as? UITextField {
                let index = textField.tag - 500 - 1
                if index < values.count && index >= 0{
                    textField.text = values[index] as? String
                }
            }
        }
            
    }
}
