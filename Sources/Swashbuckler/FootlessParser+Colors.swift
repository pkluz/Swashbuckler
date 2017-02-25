//
//  FootlessParser+Colors.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

internal typealias ColorDescriptor = (r: UInt8, g: UInt8, b: UInt8, a: UInt8)

extension FootlessParser.Parser {
    
    /// Parser for color values.
    internal static var colorValueParser: FootlessParser.Parser<Character, ColorDescriptor> {
        return rgbaValueParser <|> hexValueParser
    }
    
    /// Parser for hex string values.
    internal static var hexValueParser: FootlessParser.Parser<Character, ColorDescriptor> {
        let hash = "#" as Character
        let hexCharacters = "0123456789ABCDEFabcdef"
        let hashParser = char(hash)
        let hexDigitParser = oneOf(hexCharacters)
        let hexDigitTupleParser = { "\($0.0)\($0.1)" } <^> (tuple <^> hexDigitParser <*> hexDigitParser)
        let hexComponentsParser = hashParser *>
                                  (tuple <^> hexDigitTupleParser <*>
                                             hexDigitTupleParser <*>
                                             hexDigitTupleParser <*>
                                             optional(hexDigitTupleParser))
        
        return {
            (r: UInt8($0.0, radix: 16)!,
             g: UInt8($0.1, radix: 16)!,
             b: UInt8($0.2, radix: 16)!,
             a: UInt8($0.3 ?? "FF", radix: 16)!)
        } <^> hexComponentsParser
    }
    
    /// Parser for rgba string values.
    internal static var rgbaValueParser: FootlessParser.Parser<Character, ColorDescriptor> {
        let prefix = "rgba"
        let openParenParser = char("(" as Character)
        let closeParenParser = char(")" as Character)
        let delimiter = zeroOrMore(whitespace) *> char(",") *> zeroOrMore(whitespace)
        let integerParser = FootlessParser.Parser.unsignedIntegerParser
        let parser = zeroOrMore(whitespace) *>
                     string(prefix) *>
                     openParenParser *>
                     (tuple <^> (integerParser <* delimiter) <*>
                                (integerParser <* delimiter) <*>
                                (integerParser <* delimiter) <*>
                                 integerParser ) <*
                      closeParenParser <*
                      zeroOrMore(whitespace)
        
        return { components -> ColorDescriptor in
            return (r: UInt8(components.0),
                    g: UInt8(components.1),
                    b: UInt8(components.2),
                    a: UInt8(components.3))
        } <^> parser
    }
}
