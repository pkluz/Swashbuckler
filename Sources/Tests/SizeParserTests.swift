//
//  SizeParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class SizeParserTests: XCTestCase {
    
    func testValidSizeParser() {
        let input = validSize()
        let parser = Parser.sizePropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .size(let value):
            XCTAssert(value.id == "iconSize")
            XCTAssert(value.width == 12.0)
            XCTAssert(value.height == 24.0)
        default:
            XCTAssert(false)
        }
    }
    
    func testInvalidSizeParser() {
        let input = invalidSize()
        let parser = Parser.sizePropertyParser
        let output = try? parse(parser, input)
        
        XCTAssert(output == nil)
    }
    
    func validSize() -> String {
        return "iconSize 12pt 24pt"
    }
    
    func invalidSize() -> String {
        return "iconSize 12pt 24p"
    }
}
