//
//  YPConstant.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/9/29.
//  Copyright © 2018 Else丶. All rights reserved.
//

import Foundation
import UIKit

// MARK: -------------------------- 全局常量 --------------------------
let ScreenWidth  = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavBarHeight = (kStatusBarHeight+44.0)
let kTabbarHeight: CGFloat = kStatusBarHeight > 20.0 ? 83.0 : 49.0
// MARK: -------------------------- 适配 --------------------------
let kScreenWRatio = (ScreenWidth/375.0)
func AdaptedValue(x:Float) -> Float {
    return Float(CGFloat(x) * kScreenWRatio)
}
// MARK: -------------------------- 字体 --------------------------
func AdaptedFontSizeValue(font:Float) -> Float {
    return (font) * Float(kScreenWRatio)
}
// MARK: -------------------------- 偏好 --------------------------
//存储
func SaveInfoForKey(_ value:String,_ key:String) {
    UserDefaults.standard.setValue(value, forKey: key)
    UserDefaults.standard.synchronize()
}
//获取
func GetInfoForKey(_ key:String) -> Any! {
    return UserDefaults.standard.object(forKey: key)
}
//删除
func RemoveForKey(_ key:String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}
// MARK: -------------------------- 输出 --------------------------
//带方法名,行数
func printLog(_ message: Any,method: String = #function,line: Int = #line) {
    print("-[method:\(method)] " + "[line:\(line)] " + "\(message)")
}
// 只在Debug下输出，OC输出写法
func DLog(_ format: String, method:String = #function,line:Int = #line,_ args: CVarArg...){
    #if DEBUG
    let va_list = getVaList(args)
    NSLogv(format, va_list)
    #else
    #endif
}

// MARK: -------------------------- 颜色 --------------------------
extension UIColor {
    // RGB颜色
    static func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
        return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    static func rgb(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
        return rgba((r), (g), (b), 1)
    }
    /// 十六进制的色值 例如：0xfff000
    static func hex(_ value:Int) -> UIColor{
        return rgb(CGFloat((value & 0xFF0000) >> 16),
                   CGFloat((value & 0x00FF00) >> 8),
                   CGFloat((value & 0x0000FF)))
    }
    /// 随机色
    static var rand: UIColor {
        return rgb(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
    }
}
// MARK: -------------------------- 字符转数字 --------------------------
extension String {
    
    /// 将字符串转换为合法的数字字符
    ///
    /// - Returns: String类型
    func toPureNumber() -> String {
        let characters:String = "0123456789."
        var originString:String = ""
        for c in self {
            if characters.contains(c){
                if ".".contains(c) && originString.contains(c){}
                else{
                    originString.append(c)
                }
            }
        }
        return originString
    }
    /// 将字符串转换为 Double 类型的数字
    ///
    /// - Returns: Double类型
    func toDouble() -> Double {
        return Double(self.toPureNumber())!
    }
    /// 将字符串转换为 Float 类型的数字
    ///
    /// - Returns: Float类型
    func toFloat() -> Float {
        return Float(self.toDouble())
    }
    /// 将字符串转换为 Int 类型的数字
    ///
    /// - Returns: Int类型
    func toInt() -> Int {
        return Int(self.toDouble())
    }
    
    // 保留旧版本的字符转换为数字类型，例："123".floatValue
    var pureNumber: String {
        return self.toPureNumber()
    }
    var doubleValue: Double {
        return self.toDouble()
    }
    var floatValue: Float {
        return self.toFloat()
    }
    var intValue: Int {
        return self.toInt()
    }
}

