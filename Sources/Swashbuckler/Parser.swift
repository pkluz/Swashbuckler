//
//  Parser.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import FootlessParser

internal typealias ColorDescriptor = (r: UInt8, g: UInt8, b: UInt8, a: UInt8)
internal typealias FontDescriptor = (size: Float, family: String)

public struct Parser {
    
    public static func parse(input string: String) -> SwashValue? {
        return nil
    }
    
    /// Parser for color properties.
    internal static var colorPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, ColorDescriptor>.colorValueParser)
        let transformer = { (id: String, components: ColorDescriptor) -> SwashValue in
            return SwashValue.color(id: id,
                                    red: Float(components.r) / Float(255.0),
                                    green: Float(components.g) / Float(255.0),
                                    blue: Float(components.b) / Float(255.0),
                                    alpha: Float(components.a) / Float(255.0))
        }
        
        return transformer <^> parser
    }
    
    /// Parser for font properties.
    internal static var fontPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, FontDescriptor>.fontValueParser)
        let transformer = { (id: String, fontDescriptor: FontDescriptor) -> SwashValue in
            return SwashValue.font(id: id,
                                   size: fontDescriptor.size,
                                   family: fontDescriptor.family)
        }
        
        return transformer <^> parser
    }
    
    /// Parser for boolean properties.
    internal static var boolPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, Bool>.boolValueParser)
        let transformer = { (id: String, value: Bool) -> SwashValue in
            return SwashValue.bool(id: id, value: value)
        }
        
        return transformer <^> parser
    }
    
    internal static func propertyParser<T>(with valueParser:FootlessParser.Parser<Character, T>) -> FootlessParser.Parser<Character, (String, T)> {
        let name = FootlessParser.Parser<Character, String>.objectIdentifierParser
        return tuple <^> (zeroOrMore(whitespace) *> name <* zeroOrMore(whitespace)) <*>
                          valueParser <*
                          zeroOrMore(whitespace) <*
                          optional(newline)
    }
}
