//
//  FootlessParser+Fonts.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

internal typealias FontDescriptor = (size: Float, family: String)

extension FootlessParser.Parser {
    
    // Parser for fonts values.
    internal static var fontValueParser: FootlessParser.Parser<Character, FontDescriptor> {
        let quote = "'" as Character
        let sizeParser = unsignedDecimalParser <* string("pt")
        let fontNameParser = token(quote) *> zeroOrMore(not(quote)) <* token(quote)
        let parser = tuple <^> (sizeParser <* whitespace) <*> fontNameParser
        
        return { (size: $0, family: $1) } <^> parser
    }
}
