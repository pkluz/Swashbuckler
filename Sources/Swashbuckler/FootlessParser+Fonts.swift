//
//  FootlessParser+Fonts.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    // Parser for fonts values.
    internal static var fontValueParser: FootlessParser.Parser<Character, FontDescriptor> {
        let quote = "'" as Character
        let sizeParser = { Float($0) ?? 0.0 } <^> zeroOrMore(oneOf("1234567890")) <*
                                                  string("pt") <*
                                                  oneOrMore(whitespace)
        let fontNameParser = zeroOrMore(whitespace) *>
                             token(quote) *>
                             zeroOrMore(not(quote)) <*
                             token(quote) <*
                             zeroOrMore(whitespace)
        let parser = tuple <^> sizeParser <*> fontNameParser
        
        return { (size: $0, family: $1) } <^> parser
    }
}
