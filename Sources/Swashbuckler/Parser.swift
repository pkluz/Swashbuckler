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
    
    internal static var rootParser: FootlessParser.Parser<Character, SwashValue> {
        let opening = string(Preprocessor.openingDelimiter) <* newline
        let closing = string(Preprocessor.closingDelimiter) <* optional(zeroOrMore(newline))
        let parser = opening *> blockParser() <* closing
        return parser
    }
    
    internal static func blockParser() -> FootlessParser.Parser<Character, SwashValue> {
        let opening = string(Preprocessor.openingDelimiter) <* newline
        let closing = string(Preprocessor.closingDelimiter) <* optional(zeroOrMore(newline))
        let blockIdentifier: FootlessParser.Parser<Character, BlockDescriptor> = .blockIdentifierParser
        
        let transformedBlockParser = { (descriptor: BlockDescriptor, value: SwashValue) -> SwashValue in
            switch descriptor.type {
            case .classBlock:
                return SwashValue.classBlock(id: descriptor.id, value: value)
            case .idBlock:
                return SwashValue.idBlock(id: descriptor.id, value: value)
            }
        } <^> (tuple <^> (blockIdentifier <* newline <* opening) <*> lazy(blockParser()) <* closing)
        
        let parser = multilinePropertyParser <|> transformedBlockParser
        return parser
    }
    
    internal static var multilinePropertyParser: FootlessParser.Parser<Character, SwashValue> {
        return { SwashValue.block(value: $0) } <^> oneOrMore(anyPropertyParser)
    }
    
    /// Combinator, parsing any property.
    internal static var anyPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        // Note: The order in which these are tried is important. Consider syntax of properties before modifying this.
        return colorPropertyParser <|>
               fontPropertyParser <|>
               boolPropertyParser <|>
               rectPropertyParser <|>
               sizePropertyParser <|>
               numberPropertyParser
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
    
    /// Parser for number properties.
    internal static var numberPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, Float>.pointValueParser)
        let transformer = { (id: String, value: Float) -> SwashValue in
            return SwashValue.number(id: id, value: value)
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
    
    /// Parser for rect properties.
    internal static var rectPropertyParser: FootlessParser.Parser<Character, SwashValue> {
        let parser = propertyParser(with: FootlessParser.Parser<Character, ColorDescriptor>.rectPropertyParser)
        let transformer = { (id: String, rect: CGRect) -> SwashValue in
            return SwashValue.rect(id: id,
                                   x: Float(rect.origin.x),
                                   y: Float(rect.origin.y),
                                   width: Float(rect.size.width),
                                   height: Float(rect.size.height))
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
        let name = FootlessParser.Parser<Character, String>.propertyIdentifierParser
        return tuple <^> (zeroOrMore(whitespace) *> name <* zeroOrMore(whitespace)) <*>
                          valueParser <*
                          zeroOrMore(whitespace) <*
                          optional(newline)
    }
}
