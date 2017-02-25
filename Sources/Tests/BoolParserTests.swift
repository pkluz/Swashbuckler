//
//  BoolParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class BoolParserTests: XCTestCase {
    
    func testBoolTrueParser() {
        let input = boolPropertyTrue()
        let parser = Parser.boolPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .bool(let value):
            XCTAssert(value.id == "isTranslucent")
            XCTAssert(value.value == true)
        default:
            XCTAssert(false)
        }
    }
    
    func testBoolFalseParser() {
        let input = boolPropertyFalse()
        let parser = Parser.boolPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .bool(let value):
            XCTAssert(value.id == "isTranslucent")
            XCTAssert(value.value == false)
        default:
            XCTAssert(false)
        }
    }
    
    func testBoolInvalidParser() {
        let input = boolPropertyInvalid()
        let parser = Parser.boolPropertyParser
        let output = try? parse(parser, input)
        
        XCTAssert(output == nil)
    }
    
    func boolPropertyTrue() -> String {
        return "isTranslucent true"
    }
    
    func boolPropertyFalse() -> String {
        return "isTranslucent false"
    }
    
    func boolPropertyInvalid() -> String {
        return "isTranslucent hel lo"
    }
}
