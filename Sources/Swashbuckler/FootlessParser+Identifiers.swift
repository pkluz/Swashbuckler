//
//  FootlessParser+Identifiers.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    /// Parser for an object identifier.
    internal static var objectIdentifierParser: FootlessParser.Parser<Character, String> {
        return extend <^> (zeroOrMore(whitespace) *>
                           char(CharacterSet.letters, name: "letters")) <*>
                           zeroOrMore(alphanumeric) <*
                           zeroOrMore(whitespace)
    }
}
