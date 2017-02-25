//
//  FootlessParser+Sizes.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-18.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    /// Parser for size values.
    internal static var sizePropertyParser: FootlessParser.Parser<Character, CGSize> {
        let pointParser = FootlessParser.Parser.pointValueParser
        let pointTupleParser = tuple <^> (pointParser <* oneOrMore(whitespace)) <*> pointParser
        return { CGSize(width: CGFloat($0), height: CGFloat($1)) } <^> pointTupleParser
    }
}
