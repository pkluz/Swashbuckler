//
//  PropertyParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class PropertyParserTests: XCTestCase {
    
    func testAnyPropertyParser() {
        let input = randomProperty()
        let parser = Parser.anyPropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .font(_):
            XCTAssert(true)
        case .bool(_):
            XCTAssert(true)
        case .color(_):
            XCTAssert(true)
        case .number(_):
            XCTAssert(true)
        case .size(_):
            XCTAssert(true)
        case .rect(_):
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }
    
    func testMultipleProperties() {
        let input = multipleProperties()
        let parser = Parser.multilinePropertyParser
        let output = try! parse(parser, input)
        
        switch output {
        case .block(_):
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }
    
    func properties() -> [String] {
        return [ "defaultFont 12pt 'Helvetica'",
                 "isTranslucent true",
                 "backgroundColor rgba(120, 99, 0, 255)",
                 "textColor #ff00ff",
                 "frame 15pt 15pt 500pt 500pt",
                 "origin 15pt 15pt",
                 "someValue 15pt"]
    }
    
    func randomProperty() -> String {
        let properties = self.properties()
        let index = Int(arc4random_uniform(3))
        return properties[index]
    }
    
    func multipleProperties() -> String {
        let properties = self.properties()
        return properties.joined(separator: "\n")
    }
}
