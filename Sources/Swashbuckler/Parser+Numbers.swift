//
//  Parser+Numbers.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-18.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import FootlessParser

internal typealias ColorComponents = (r: UInt8, g: UInt8, b: UInt8, a: UInt8)

fileprivate let decimalSeparator = "." as Character

extension Parser {
    
    /// Parses a decimal number.
    internal static func decimalParser() -> Parser<Character,Float> {
        let negativeSign = "-" as Character
        let optionalSign = optional(oneOrMore(char(negativeSign)))
        let number = unsignedDecimalParser() { first, second -> Float in
            guard let second = second else { return 0.0 }
            return Float("\(first).\(second)")!
        }
        let signedParser = tuple <^> optionalSign <*> number
        
        return { (number: (sign: String?, value: Float)) -> Float in
            guard let _ = number.sign else { return number.value }
            return -number.value
        } <^> signedParser
    }
    
    fileprivate static func unsignedDecimalParser<T>(transformer: @escaping (String, String?) -> (T)) -> Parser<Character, T> {
        let number = zeroOrMore(oneOf("0123456789"))
        let parser = tuple <^> number <*> optional(char(decimalSeparator) *> number)
        return transformer <^> parser
    }
    
    internal static func unsignedIntegerParser() -> Parser<Character, UInt> {
        let number = oneOrMore(oneOf("0123456789"))
        return { UInt($0)! } <^> number
    }
    
    internal static func hexComponentsParser() -> Parser<Character, ColorComponents> {
        let hash = "#" as Character
        let hexCharacters = "0123456789ABCDEFabcdef"
        let hashParser = char(hash)
        let hexDigitParser = oneOf(hexCharacters)
        let hexDigitTupleParser = { "\($0.0)\($0.1)" } <^> (tuple <^> hexDigitParser <*> hexDigitParser)
        
        let colorComponentsParser = hashParser *> (tuple <^> hexDigitTupleParser <*> hexDigitTupleParser <*> hexDigitTupleParser <*> optional(hexDigitTupleParser))
        return {
            (UInt8($0.0, radix: 16) ?? 0,
             UInt8($0.1, radix: 16) ?? 0,
             UInt8($0.2, radix: 16) ?? 0,
             UInt8($0.3 ?? "FF", radix: 16) ?? 0)
        } <^> colorComponentsParser
    }
    
    internal static func rgbaComponentsParser() -> Parser<Character, ColorComponents> {
        let prefix = "rgba"
        let openParenParser = char("(" as Character)
        let closeParenParser = char(")" as Character)
        let delimiter = zeroOrMore(whitespace) *> char(",") *> zeroOrMore(whitespace)
        let integerParser =  unsignedIntegerParser()
        
        let parser = string(prefix) *> openParenParser *> (tuple <^> (integerParser <* delimiter) <*> (integerParser <* delimiter) <*> (integerParser <* delimiter) <*> integerParser ) <* closeParenParser
        return { components -> ColorComponents in
            return (r: UInt8(components.0),
                    g: UInt8(components.1),
                    b: UInt8(components.2),
                    a: UInt8(components.3))
        } <^> parser
    }
}
