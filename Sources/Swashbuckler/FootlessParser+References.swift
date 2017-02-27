//
//  FootlessParser+References.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-26.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    /// Parser for reference values.
    internal static var referenceValueParser: FootlessParser.Parser<Character, String> {
        let referenceName = string("@") *> FootlessParser.Parser.propertyIdentifierParser
        let parser = referenceName <* zeroOrMore(whitespace)
        return  parser
    }
}
 
