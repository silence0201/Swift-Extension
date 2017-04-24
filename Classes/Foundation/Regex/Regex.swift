//
//  Regex.swift
//  SwiftExtension
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 Silence. All rights reserved.
//

import Foundation

/**
 A `Regex` represents a compiled regular expression that can be applied to
 `String` objects to search for (and replace) matched patterns.
 */
public struct Regex
{
    public typealias MatchResult = RegexMatchResult
    
    fileprivate let pattern: String
    fileprivate let nsRegex: NSRegularExpression
    
    
    /**
     Attempts to create a `Regex` with the provided `pattern`.  If this fails, a tuple `(nil, NSError)` is returned.  If it succeeds, a tuple `(Regex, nil)` is returned.
     */
    public static func create(_ pattern:String) -> (Regex?, NSError?)
    {
        var err: NSError?
        let regex: Regex?
        do {
            regex = try Regex(pattern: pattern)
        } catch let error as NSError {
            err = error
            regex = nil
        }
        
        if let err = err            { return (nil, err) }
        else if let regex = regex   { return (regex, nil) }
        else                        { return (nil, NSError(domain: "com.illumntr.Regex", code: 1, userInfo:[NSLocalizedDescriptionKey: "Unknown error."])) }
    }
    
    
    /**
     Creates a `Regex` with the provided `String` as its pattern.  If the pattern is invalid, this
     function calls `fatalError()`.  Hence, it is recommended that you use `Regex.create()` for more
     descriptive error messages.
     
     - parameter p: A string containing a regular expression pattern.
     */
    public init(_ p:String)
    {
        pattern = p
        
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        } catch _ as NSError {
            fatalError("Invalid regex: \(p)")
        }
        
        if let regex = regex {
            nsRegex = regex
        } else {
            fatalError("Invalid regex: \(p)")
        }
    }
    
    
    /**
     Creates a `Regex` with the provided `String` as its pattern.  If the pattern is invalid, this
     function initializes an `NSError` into the provided `NSErrorPointer`.  `Regex.create()` is recommended,
     as it wraps this constructor and handles the `NSErrorPointer` dance for you.
     
     - parameter p: A string containing a regular expression pattern.
     - parameter error: An `NSErrorPointer` that will contain an `NSError` if initialization fails.
     */
    public init (pattern p:String) throws
    {
        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        pattern = p
        
        var err: NSError?
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        } catch let error as NSError {
            err = error
            regex = nil
        }
        if let regex = regex {
            nsRegex = regex
        }
        else {
            nsRegex = NSRegularExpression()
            if let err = err {
                error = err
            }
            throw error
        }
    }
    
    
    /**
     Searches in `string` for the regular expression pattern represented by the receiver.
     
     - parameter string: The string in which to search for matches.
     */
    public func match (_ string:String) -> MatchResult
    {
        var matches  = [NSTextCheckingResult]()
        let all      = NSRange(location: 0, length: string.characters.count)
        let moptions = NSRegularExpression.MatchingOptions(rawValue: 0)
        
        nsRegex.enumerateMatches(in: string, options:moptions, range:all) {
            (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, ptr: UnsafeMutablePointer<ObjCBool>) in
            
            if let result = result {
                matches.append(result)
            }
        }
        
        return MatchResult(regex:nsRegex, searchString:string, items: matches)
    }
    
    
    /**
     Searches `string` for the regular expression pattern represented by the receiver.  Any matches are replaced using
     the provided `replacement` string, which can contain substitution patterns like `"$1"`, etc.
     
     - parameter string: The string to search.
     - parameter replacement: The replacement pattern to apply to any matches.
     - returns: A 2-tuple containing the number of replacements made and the transformed search string.
     */
    public func replaceMatchesIn (_ string:String, with replacement:String) -> (replacements:Int, string:String)
    {
        let mutableString = NSMutableString(string:string)
        let replacements  = nsRegex.replaceMatches(in: mutableString, options:NSRegularExpression.MatchingOptions(rawValue: 0), range:string.fullNSRange, withTemplate:replacement)
        
        return (replacements:replacements, string:String(mutableString))
    }
    
    
    /**
     Searches `string` for the regular expression pattern represented by the receiver.  Any matches are replaced using
     the provided `replacement` string, which can contain substitution patterns like `"$1"`, etc.
     
     - parameter string: The string to search.
     - parameter replacement: The replacement pattern to apply to any matches.
     - returns: The transformed search string.
     */
    public func replaceMatchesIn (_ string:String, with replacement:String) -> String {
        return map((string =~ self), replacementTemplate: replacement)
    }
}


infix operator =~

/**
 Searches `searchString` using `regex` and returns the resulting `Regex.MatchResult`.
 */
public func =~ (searchString: String, regex:Regex) -> Regex.MatchResult {
    return regex.match(searchString)
}


/**
 An object representing the result of searching a given `String` using a `Regex`.
 */
public struct RegexMatchResult: Sequence
{
    /** Returns `true` if the number of matches is greater than zero. */
    public var boolValue: Bool { return items.count > 0 }
    
    public let regex: NSRegularExpression
    public let searchString: String
    public let items: [NSTextCheckingResult]
    
    /** An array of the captures as `String`s.  Ordering is the same as the return value of Javascript's `String.match()` method. */
    public let captures: [String]
    
    
    /**
     The designated initializer.
     
     - parameter regex: The `NSRegularExpression` that was used to create this `RegexMatchResult`.
     - parameter searchString: The string that was searched by `regex` to generate these results.
     - parameter items: The array of `NSTextCheckingResult`s generated by `regex` while searching `searchString`.
     */
    public init (regex r:NSRegularExpression, searchString s:String, items i:[NSTextCheckingResult])
    {
        regex = r
        searchString = s
        items = i
        
        captures = items.flatMap { result in
            (0 ..< result.numberOfRanges).map { i in
                let nsrange = result.rangeAt(i)
                return s.subStringWithNSRange(nsrange)
            }
        }
    }
    
    
    /**
     Returns the `i`th match as an `NSTextCheckingResult`.
     */
    subscript (i: Int) -> NSTextCheckingResult {
        get { return items[i] }
    }
    
    
    /**
     Returns the captured text of the `i`th match as a `String`.
     */
    subscript (i: Int) -> String {
        get { return captures[i] }
    }
    
    
    /**
     Returns a `Generator` that iterates over the captured matches as `NSTextCheckingResult`s.
     */
    public func makeIterator() -> AnyIterator<NSTextCheckingResult> {
        var gen = items.makeIterator()
        return AnyIterator { gen.next() }
    }
    
    
    /**
     Returns a `Generator` that iterates over the captured matches as `String`s.
     */
    public func generateCaptures() -> AnyIterator<String> {
        var gen = captures.makeIterator()
        return AnyIterator { gen.next() }
    }
}


/**
 Returns the `String` created by replacing the regular expression matches in `regexResult` using `replacementTemplate`.
 */
public func map (_ regexResult:Regex.MatchResult, replacementTemplate:String) -> String
{
    let searchString = NSMutableString(string: regexResult.searchString)
    let fullRange    = regexResult.searchString.fullNSRange
    regexResult.regex.replaceMatches(in: searchString, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:fullRange, withTemplate:replacementTemplate)
    return String(searchString)
}

