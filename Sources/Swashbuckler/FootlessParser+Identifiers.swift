//
//  FootlessParser+Identifiers.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

internal enum BlockType {
    case classBlock
    case idBlock
}

internal typealias BlockDescriptor = (type: BlockType, id: String)

extension FootlessParser.Parser {
    
    /// Parser for a property identifier.
    internal static var propertyIdentifierParser: FootlessParser.Parser<Character, String> {
        return extend <^> (char(CharacterSet.letters, name: "letters")) <*>
                           zeroOrMore(alphanumeric) <*
                           zeroOrMore(whitespace)
    }
    
    /// Parser for a block identifier.
    internal static var blockIdentifierParser: FootlessParser.Parser<Character, BlockDescriptor> {
        let parser = tuple <^> (string(".") <|> string("#")) <*> (extend <^> char(CharacterSet.letters, name: "letters") <*> zeroOrMore(alphanumeric))
        return { (type: $0 == "." ? .classBlock : .idBlock, id: $1) } <^> parser
    }
}
