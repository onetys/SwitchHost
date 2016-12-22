//
//  SwitchHostViewModel.swift
//  LoginURL
//
//  Created by KING on 2016/12/22.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

private let currentURLPlistName = "com.switchhost.currentname"

class SwitchHostViewModel {
    
    var alterData: ((data: [String : String])->Void)?
    
    var localURLPlistName = "SwitchHost"
    
    lazy var showName: [String] = { ["请输入自定义名称"] + self.templeUrlNames }()
    
    var currentHostName: String {
        get {
            guard let name = NSUserDefaults.standardUserDefaults().valueForKey(currentURLPlistName) as? String else {
                return ""
            }
            return name
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: currentURLPlistName)
        }
    }
    
    lazy var urlNames: [String] = {
        return ["name"] + self.templeUrlNames
    }()
    
    private lazy var templeUrlNames: [String] = {
        if let first = self.plistHostList.first {
            return self.getPlistContent(first).allKeys as! [String]
        }
        return [String]()
    }()
    
    // 展示的所有名称
    lazy var allNames: [String] = {
        self.plistHostList + self.editorAllNames()
    }()
    
    func relodData() {
        self.allNames = self.plistHostList + self.editorAllNames()
    }
    
    // 本地plist
    lazy var plistHostList: [String] = {
        var plist = [String]()
        guard let path = NSBundle.mainBundle().pathForResource(self.localURLPlistName, ofType: "plist"), let result = NSArray.init(contentsOfFile: path) as? [String] else {
            return plist
        }
        return result
    }()
    
}

// MARK: - for tableview

extension SwitchHostViewModel {
    
    func selectedAtIndexPath(indexPath: NSIndexPath) {
        
        let allName = self.allNames
        
        if indexPath.section >= allName.count {
            return
        }
        // bundle plist
        if indexPath.section < self.plistHostList.count {
            let name = self.plistHostList[indexPath.section]
            self.currentHostName = name
            self.setupSystemURLS(self.getPlistContent(name))
            return
        }
            // 本地存储
        else {
            let name = self.allNames[indexPath.section]
            self.currentHostName = name
            if let content = self.getLocalContent(name) {
                self.setupSystemURLS(content)
            }
        }
        
    }
    
    func canEditorAtIndexPath(indexPath: NSIndexPath) -> Bool {
        if (indexPath.section < self.plistHostList.count) {
            return false
        }
        return true
    }
    
    func contentAtIndexPath(indexPath: NSIndexPath) -> [String: String] {
        let empty = [String: String]()
        if indexPath.section < self.plistHostList.count {
            guard let content = self.getPlistContent(self.plistHostList[indexPath.section]) as? [String : String] else {
                return empty
            }
            return content
        } else if indexPath.section < self.allNames.count {
            guard let content = self.getLocalContent(self.allNames[indexPath.section]) as? [String : String] else {
                return empty
            }
            return content
        }
        return empty
    }
}

// MARK: - content

extension SwitchHostViewModel {
    
    func getPlistContent(name: String) -> NSDictionary {
        // 此处一定要加载到
        guard let plistPath = NSBundle.mainBundle().pathForResource(name, ofType: "plist"), let content = NSDictionary.init(contentsOfFile: plistPath) else {
            fatalError("SwitchHost error: can not find a plist named \(name)")
        }
        return content
    }
    
    func getLocalContent(name: String) -> NSDictionary? {
        guard let path = self.editorPath() else {
            return nil
        }
        
        return NSDictionary.init(contentsOfFile: path + "/\(name)")
    }
    
    private func editorAllNames() -> [String] {
        var result = [String]()
        guard let path = self.editorPath() else {
            return result
        }
        let allName = NSFileManager.defaultManager().subpathsAtPath(path)
        guard let eAllName = allName else {
            return result
        }
        for name in eAllName {
            if name != "current___________" {
                result.append(name)
            }
        }
        return result
    }
    
    private func editorPath() -> String? {
        
        guard let cache = getCachePath() else {
            return nil
        }
        
        return cache + "/com.instalment.customurl"
    }
    
    func deleteEditor(name:String) {
        
        guard let editorPath = editorPath() else {
            return
        }
        let path =  editorPath + "/" + name
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            let _ = try? NSFileManager.defaultManager().removeItemAtPath(path)
        }
    }
}

// MARK: - tool

extension SwitchHostViewModel {
    
    private func getCachePath() -> String?{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        guard let first = paths.first else {
            return nil
        }
        return first
    }
    
    private func setupSystemURLS(data: NSDictionary) {
        guard let result = data as? [String : String] else {
            return
        }
        self.alterData?(data: result)
    }
    
    func saveResult(result: NSDictionary) {
        
        let directoryName = "/com.instalment.customurl"
        
        guard let cache = getCachePath() else {
            return
        }
        let path =  cache + directoryName
        print(path)
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
            }catch _{
                return
            }
        }
        
        guard let name = result["name"] as? String else {
            return
        }
        
        result.writeToFile(path + "/\(name)", atomically: true)
    }
}
