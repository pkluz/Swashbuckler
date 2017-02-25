//
//  Parser.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import FootlessParser

public struct Parser {
    
    public static func parse(input string: String) -> SwashValue? {
        return nil
    }
    
    /// Combinator, parsing any property.
    internal static var anyPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        return colorPropertyParser <|>
               fontPropertyParser <|>
               sizePropertyParser <|>
               boolPropertyParser
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
    
    /// Parser for size properties.
    internal static var sizePropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, ColorDescriptor>.sizePropertyParser)
        let transformer = { (id: String, size: CGSize) -> SwashValue in
            return SwashValue.size(id: id, width: Float(size.width), height: Float(size.height))
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
    
    /// Generic propery parser.
    internal static func propertyParser<T>(with valueParser:FootlessParser.Parser<Character, T>) -> FootlessParser.Parser<Character, (String, T)> {
        let name = FootlessParser.Parser<Character, String>.objectIdentifierParser
        return tuple <^> (zeroOrMore(whitespace) *> name <* zeroOrMore(whitespace)) <*>
                          valueParser <*
                          zeroOrMore(whitespace) <*
                          optional(newline)
    }
}
