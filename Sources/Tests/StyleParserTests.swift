//
//  StyleParserTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-26.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import FootlessParser
@testable import Swashbuckler

class StyleParserTests: XCTestCase {
    
    func testSimpleStyle() {
        let input = simpleStyle()
        let preprocessedInput = Preprocessor.run(input: input)
        let parser = Parser.rootParser
        let output = try! parse(parser, preprocessedInput)
        
        switch output {
        case .block(let values):
            XCTAssert(values.count == 1)
            switch values.first! {
            case .classBlock(let id, let value):
                XCTAssert(id == "feedViewController")
                switch value {
                case .block(value: let values):
                    XCTAssert(values.count == 2)
                default:
                    XCTAssert(false)
                }
            default:
                XCTAssert(false)
            }
        default:
            XCTAssert(false)
        }
    }
    
    func testNestedStyle() {
        let input = nestedStyle()
        let preprocessedInput = Preprocessor.run(input: input)
        let parser = Parser.rootParser
        let output = try! parse(parser, preprocessedInput)
        
        switch output {
        case .block(let values):
            XCTAssert(values.count == 1)
            switch values.first! {
            case .classBlock(let id, let value):
                XCTAssert(id == "feedViewController")
                switch value {
                case .block(value: let values):
                    XCTAssert(values.count == 3)
                    switch values.last! {
                    case .idBlock(let id, let blockValue):
                        XCTAssert(id == "feedHeaderView")
                        switch blockValue {
                        case .block(let blockValues):
                            XCTAssert(blockValues.count == 1)
                        default:
                            XCTAssert(false)
                        }
                    default:
                        XCTAssert(false)
                    }
                default:
                    XCTAssert(false)
                }
            default:
                XCTAssert(false)
            }
        default:
            XCTAssert(false)
        }
    }
    
    
    func simpleStyle() -> String {
        let path = Bundle(for: StyleParserTests.self).path(forResource: "SimpleStyle", ofType: "swash")!
        return try! String(contentsOfFile: path)
    }
    
    func nestedStyle() -> String {
        let path = Bundle(for: StyleParserTests.self).path(forResource: "NestedStyle", ofType: "swash")!
        return try! String(contentsOfFile: path)
    }
}