//
//  Computed.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/4/23.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension Date {
    
    /// Get the era from the date
    public var era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }
    
    /// Get the year from the date
    public var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: self)
    }
    
    /// Get the month from the date
    public var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: self)
    }
    
    /// Get the day from the date
    public var day: UInt {
        return UInt(Calendar.current.component(.day, from: self))
    }
    
    /// Get the hour from the date
    public var hour: UInt {
        return UInt(NSCalendar.current.component(.hour, from: self))
    }
    
    /// Get the minute from the date
    public var minute: UInt {
        return UInt(NSCalendar.current.component(.minute, from: self))
    }
    
    /// Get the second from the date
    public var second: UInt {
        return UInt(NSCalendar.current.component(.second, from: self))
    }
    
    /// Gets the nano second from the date
    public var nanosecond: Int {
        return Calendar.current.component(.nanosecond, from: self)
    }
}
