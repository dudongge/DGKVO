//
//  DGKVOTool.swift
//  DGKVODemo
//
//  Created by dudongge on 2018/3/2.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

import Foundation

extension NSObject {
    func observe(_ receiver: NSObject, keyPath: String, closure:@escaping ()->Void) {
        self.addObserver(DGKVOMananger.sharedInstance, forKeyPath: keyPath, options: .new, context: nil)
        DGKVOMananger.sharedInstance.add(keyPath, closure: closure, object: self.classForCoder)
    }
    
    func unObserve(_ receiver: NSObject, keyPath: String) {
        self.removeObserver(DGKVOMananger.sharedInstance, forKeyPath: keyPath)
        DGKVOMananger.sharedInstance.remove(keyPath)
    }
}

open class DGKVOObject : NSObject {
    open var closure:()->Void = { }
    open var objectClass:AnyClass?
    open var keyPath:String?
}

open class DGKVOMananger : NSObject  {
    
    static let sharedInstance = DGKVOMananger()
    
    var kvoObjects:[DGKVOObject] = NSMutableArray() as! [DGKVOObject]
    
    open func add(_ keyPath: String, closure:@escaping ()->Void, object:AnyClass) {
        let newObject = DGKVOObject()
        newObject.closure = closure
        newObject.keyPath = keyPath
        newObject.objectClass = object
        self.kvoObjects.append(newObject)
    }
    
    open func remove(_ keyPath: String) {
        let filteredArray = self.kvoObjects.filter { $0.keyPath == keyPath }
        let kvoObject = filteredArray.first
        for index in 0..<self.kvoObjects.count-1 {
            if kvoObject == self.kvoObjects[index] {
                self.kvoObjects.remove(at: index)
            }
        }
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let filteredArray = self.kvoObjects.filter { $0.keyPath == keyPath }
        for tmp in filteredArray {
            let kvoObject = tmp
            if(((object as AnyObject).isKind(of: kvoObject.objectClass!))) {
                kvoObject.closure()
            }
        }
    }
}

