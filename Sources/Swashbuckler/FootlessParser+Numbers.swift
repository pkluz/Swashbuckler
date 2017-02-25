//
//  FootlessParser+Numbers.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-18.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

fileprivate let decimalSeparator = "." as Character

extension FootlessParser.Parser {
    
    /// Parser for decimal numbers.
    internal static var decimalParser: FootlessParser.Parser<Character,Float> {
        let negativeSign = "-" as Character
        let optionalSign = optional(oneOrMore(char(negativeSign)))
        let number = unsignedDecimalParser
        let signedParser = tuple <^> optionalSign <*> number
        
        return { (number: (sign: String?, value: Float)) -> Float in
            guard let _ = number.sign else { return number.value }
            return -number.value
        } <^> signedParser
    }
    
    /// Parser for unsigned decimals.
    internal static var unsignedDecimalParser: FootlessParser.Parser<Character, Float> {
        let number = zeroOrMore(oneOf("0123456789"))
        let parser = tuple <^> number <*> optional(char(decimalSeparator) *> number)
        return { first, second -> Float in
            guard let second = second else { return Float(first) ?? 0.0 }
            return Float("\(first).\(second)")!
        } <^> parser
    }
    
    /// Parser for unsigned integers.
    internal static var unsignedIntegerParser: FootlessParser.Parser<Character, UInt> {
        let number = oneOrMore(oneOf("0123456789"))
        return { UInt($0)! } <^> number
    }
}
