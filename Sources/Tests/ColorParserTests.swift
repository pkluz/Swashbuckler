//
//  ColorParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-24.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class ColorParserTests: XCTestCase {
    
    func testHexParser() {
        let input = hexColor()
        let parser = Parser.colorPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .color(let color):
            XCTAssert(color.red == 1)
            XCTAssert(color.green == 0)
            XCTAssert(color.blue == 1)
            XCTAssert(color.alpha == 1)
        default:
            XCTAssert(false)
        }
    }
    
    func testRGBAParser() {
        let input = rgbaColor()
        let parser = Parser.colorPropertyParser
        let maybeOutput = try? parse(parser, input)
        
        guard let output = maybeOutput else { return XCTAssert(false) }
        
        switch output {
        case .color(let color):
            XCTAssert(color.red == 1)
            XCTAssert(color.green == 150.0 / 255.0)
            XCTAssert(color.blue == 0)
            XCTAssert(color.alpha == 100.0 / 255.0)
        default:
            XCTAssert(false)
        }
    }
    
    func hexColor() -> String {
        return "primaryColor #ff00ff"
    }
    
    func rgbaColor() -> String {
        return "primaryColor rgba(255, 150, 0, 100)"
    }
}
