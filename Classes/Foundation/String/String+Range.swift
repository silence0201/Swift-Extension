//
//  Range.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/4/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension String {
    /// 字符串长度
    public var length: Int {
        return self.characters.count
    }
    
    /// 全部字符串的Range信息
    public var fullRange: Range<String.Index> {
        return startIndex ..< endIndex
    }
    
    /// 全部字符串的NSRange信息
    public var fullNSRange: NSRange {
        return NSRange(location: 0, length: characters.count)
    }
    
    /// 将 Range<Int> 转化为  Range<String.Index>
    public func convertRange(_ range: Range<Int>) -> Range<String.Index> {
        let start = characters.index(self.startIndex, offsetBy: range.lowerBound)
        let end = characters.index(startIndex, offsetBy: range.upperBound - range.lowerBound) ;
        return start ..< end
    }
    
    /// 将 NSRange 转化为 Range<String.Index>
    public func convertRange(_ nsrange: NSRange) -> Range<String.Index> {
        let start = characters.index(startIndex, offsetBy: nsrange.location)
        let end = characters.index(start, offsetBy: nsrange.length)
        return start ..< end
    }
    
    
    /// 根据NSRange获取子串
    public func subStringWithNSRange(_ nsrange: NSRange) -> String {
        return substring(with: convertRange(nsrange))
    }
    
    /// 根据Range<Int>获取子串
    public func subStringWithRang(_ range:Range<Int>) -> String {
        return substring(with: convertRange(range))
    }
}
