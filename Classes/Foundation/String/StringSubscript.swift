//
//  StringSubscript.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/5/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension String {
    /// Cut string from integerIndex to the end
    public subscript(integerIndex: Int) -> Character {
        let index = characters.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }
    
    /// Cut string from range
    public subscript(integerRange: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = characters.index(startIndex, offsetBy: integerRange.upperBound)
        return self[start..<end]
    }
    
    /// Cut string from closedrange
    public subscript(integerClosedRange: ClosedRange<Int>) -> String {
        return self[integerClosedRange.lowerBound..<(integerClosedRange.upperBound + 1)]
    }
}
