//
//  FontParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-24.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class FontParserTests: XCTestCase {
    
    func testFontParser() {
        let input = font()
        let parser = Parser.fontPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .font(let font):
            XCTAssert(font.size == 12.0)
            XCTAssert(font.family == "Helvetica")
            XCTAssert(font.id == "defaultFont")
        default:
            XCTAssert(false)
        }
    }
    
    func font() -> String {
        return "defaultFont 12pt 'Helvetica'"
    }
}
