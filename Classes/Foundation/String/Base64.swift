//
//  Base64.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/5/11.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

extension String {
    /// Init string with a base64 encoded string
    init?(base64: String) {
        let pad = String(repeating: "=", count: base64.length % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded,
                                  options: NSData.Base64DecodingOptions(rawValue: 0)),
            let decodedString = NSString(data: decodedData,
                                         encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
    
    
    /// base64 encoded of string
    public var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
}
