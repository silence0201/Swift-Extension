//
//  StringFormat.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/5/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension String {
    init(_ value: Float, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
    
    init(_ value: Double, precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = .decimal
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
}

extension String {
    /// Capitalizes first character of String
    public mutating func capitalizeFirst() {
        guard characters.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
    }
    
    /// Capitalizes first character of String, returns a new string
    public func capitalizedFirst() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
    
    /// Uppercases first 'count' characters of String
    public mutating func uppercasePrefix(_ count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                             with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
    }
    
    /// Uppercases first 'count' characters of String, returns a new string
    public func uppercasedPrefix(_ count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).uppercased())
        return result
    }
    
    /// Uppercases last 'count' characters of String
    public mutating func uppercaseSuffix(_ count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                             with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
    }
    
    /// Uppercases last 'count' characters of String, returns a new string
    public func uppercasedSuffix(_ count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(characters.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[characters.index(endIndex, offsetBy: -min(count, length))..<endIndex]).uppercased())
        return result
    }
    
    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex)
    public mutating func uppercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return }
        self.replaceSubrange(self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to),
                             with: String(self[self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to)]).uppercased())
    }

    /// Uppercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    public func uppercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to),
                               with: String(self[characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to)]).uppercased())
        return result
    }
    
    /// Lowercases first character of String
    public mutating func lowercaseFirst() {
        guard characters.count > 0 else { return }
        self.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
    }
    
    /// Lowercases first character of String, returns a new string
    public func lowercasedFirst() -> String {
        guard characters.count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).lowercased())
        return result
    }
    
    /// Lowercases first 'count' characters of String
    public mutating func lowercasePrefix(_ count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceSubrange(startIndex..<self.index(startIndex, offsetBy: min(count, length)),
                             with: String(self[startIndex..<self.index(startIndex, offsetBy: min(count, length))]).lowercased())
    }
    
    /// Lowercases first 'count' characters of String, returns a new string
    public func lowercasedPrefix(_ count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex..<characters.index(startIndex, offsetBy: min(count, length)),
                               with: String(self[startIndex..<characters.index(startIndex, offsetBy: min(count, length))]).lowercased())
        return result
    }
    
    /// Lowercases last 'count' characters of String
    public mutating func lowercaseSuffix(_ count: Int) {
        guard characters.count > 0 && count > 0 else { return }
        self.replaceSubrange(self.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                             with: String(self[self.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
    }

    /// Lowercases last 'count' characters of String, returns a new string
    public func lowercasedSuffix(_ count: Int) -> String {
        guard characters.count > 0 && count > 0 else { return self }
        var result = self
        result.replaceSubrange(characters.index(endIndex, offsetBy: -min(count, length))..<endIndex,
                               with: String(self[characters.index(endIndex, offsetBy: -min(count, length))..<endIndex]).lowercased())
        return result
    }
    
    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex)
    public mutating func lowercase(range: CountableRange<Int>) {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return }
        self.replaceSubrange(self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to),
                             with: String(self[self.index(startIndex, offsetBy: from)..<self.index(startIndex, offsetBy: to)]).lowercased())
    }
    
    /// Lowercases string in range 'range' (from range.startIndex to range.endIndex), returns new string
    public func lowercased(range: CountableRange<Int>) -> String {
        let from = max(range.lowerBound, 0), to = min(range.upperBound, length)
        guard characters.count > 0 && (0..<length).contains(from) else { return self }
        var result = self
        result.replaceSubrange(characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to),
                               with: String(self[characters.index(startIndex, offsetBy: from)..<characters.index(startIndex, offsetBy: to)]).lowercased())
        return result
    }
}
