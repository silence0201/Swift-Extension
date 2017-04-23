//
//  Range.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/4/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension String {
    
    /// 全部字符串的Range信息
    var fullRange: Range<String.Index> {
        return startIndex ..< endIndex
    }
    
    /// 全部字符串的NSRange信息
    var fullNSRange: NSRange {
        return NSRange(location: 0, length: characters.count)
    }
    
    /// 将 Range<Int> 转化为  Range<String.Index>
    ///
    /// - Parameter range: Range<Int>
    /// - Returns: Range<String.Index>
    func convertRange(_ range: Range<Int>) -> Range<String.Index> {
        let start = characters.index(self.startIndex, offsetBy: range.lowerBound)
        let end = characters.index(startIndex, offsetBy: range.upperBound - range.lowerBound) ;
        return start ..< end
    }
    
    /// 将 NSRange 转化为 Range<String.Index>
    ///
    /// - Parameter nsrange: NSRange
    /// - Returns: Range<String.Index>
    func convertRange(_ nsrange: NSRange) -> Range<String.Index> {
        let start = characters.index(startIndex, offsetBy: nsrange.location)
        let end = characters.index(start, offsetBy: nsrange.length)
        return start ..< end
    }
    
    
    /// 根据NSRange获取子串
    ///
    /// - Parameter nsrange: NSRange
    /// - Returns: 子串信息
    func subStringWithNSRange(_ nsrange: NSRange) -> String {
        return substring(with: convertRange(nsrange))
    }
    
    /// 根据Range<Int>获取子串
    ///
    /// - Parameter range: Range<Int>
    /// - Returns: 子串信息
    func subStringWithRang(_ range:Range<Int>) -> String {
        return substring(with: convertRange(range))
    }
}
