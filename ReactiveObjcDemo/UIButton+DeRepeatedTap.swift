//
//  UIButton+DeRepeatedTap.swift
//  ReactiveObjcDemo
//
//  Created by 刘隆昌 on 2020/4/25.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation
import UIKit


/* 使用:
 pushBtn.startForbidContinuousClick()
 pushBtn.forbidInterval = 1.5

 @IBAction func pushVC(_ sender: Any) {
         print("被点击了....")
 }
 */


extension UIButton {
    
    private static var ForbidIntervalKey = "ForbidIntervalKey"
    private static var LastClickTimeKey = "LastClickTimeKey"
    
    /// 按钮不能被重复点击的时间间隔（默认两秒）
    var forbidInterval: TimeInterval {
        get {
            if let interval = objc_getAssociatedObject(self, &UIButton.ForbidIntervalKey) as? TimeInterval {
                return interval
            }
            return 2
        }
        set {
            objc_setAssociatedObject(self, &UIButton.ForbidIntervalKey, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 存储上次点击的时间(默认是1970年的时间)
    private var lastClickDate: Date {
        get {
            if let lastDate = objc_getAssociatedObject(self, &UIButton.LastClickTimeKey) as? Date {
                return lastDate
            }
            return Date.init(timeIntervalSince1970: 0)
        }
        set {
            objc_setAssociatedObject(self, &UIButton.LastClickTimeKey, newValue as Date, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func startForbidContinuousClick() {
        if let originalMethod: Method = class_getInstanceMethod(self.classForCoder, #selector(UIButton.sendAction)),
            let newMethod: Method = class_getInstanceMethod(self.classForCoder, #selector(UIButton.de_sendAction(action:to:forEvent:))) {
            method_exchangeImplementations(originalMethod, newMethod)
        }
    }
    
    @objc dynamic func de_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        if Date().timeIntervalSince(lastClickDate) > forbidInterval {
            self.de_sendAction(action: action, to: target, forEvent: event)
            lastClickDate = Date()
        }
    }
    
}



//另一种方式:
//@IBAction func pushClick(_ sender: Any) {
//    let button = sender as! UIButton
//    button.isEnabled = false
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        button.isEnabled = true
//    }
//    /*要做的事*/
//    print("被点击了...")
//}

