//
//  NumberParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class NumberParserTests: XCTestCase {
    
    func testValidNumberParser() {
        let input = validValue()
        let parser = Parser.numberPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .number(let number):
            XCTAssert(number.id == "maxWidth")
            XCTAssert(number.value == 15.0)
        default:
            XCTAssert(false)
        }
    }
    
    func testInvalidNumberParser() {
        let input = invalidValue()
        let parser = Parser.numberPropertyParser
        let output = try? parse(parser, input)
        
        XCTAssert(output == nil)
    }
    
    func validValue() -> String {
        return "maxWidth 15pt"
    }
    
    func invalidValue() -> String {
        return "maxWidth 15"
    }
}
