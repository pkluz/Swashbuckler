//
//  FootlessParser+Bools.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-18.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    /// Parser for boolean values.
    internal static var boolValueParser: FootlessParser.Parser<Character, Bool> {
        let parser = zeroOrMore(whitespace) *>
                    (string("true") <|> string("false")) <*
                     zeroOrMore(whitespace)
        
        return { $0 == "true" } <^> parser
    }
}
