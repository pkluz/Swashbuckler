//
//  RectParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class RectParserTests: XCTestCase {
    
    func testValidRectParser() {
        let input = validRect()
        let parser = Parser.rectPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .rect(let value):
            XCTAssert(value.id == "frame")
            XCTAssert(value.x == 15.0)
            XCTAssert(value.y == 15.0)
            XCTAssert(value.width == 50.0)
            XCTAssert(value.height == 50.0)
        default:
            XCTAssert(false)
        }
    }
    
    func testInvalidRectParser() {
        let input = invalidRect()
        let parser = Parser.rectPropertyParser
        let output = try? parse(parser, input)
        
        XCTAssert(output == nil)
    }
    
    func validRect() -> String {
        return "frame 15pt 15pt 50pt 50pt"
    }
    
    func invalidRect() -> String {
        return "frame 15pt 15pt 50pt"
    }
}
