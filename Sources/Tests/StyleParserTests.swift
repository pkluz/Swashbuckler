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
    
    func testReferencedStyle() {
        let input = referencedStyle()
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
                        XCTAssert(id == "headerView")
                        switch blockValue {
                        case .block(let blockValues):
                            XCTAssert(blockValues.count == 2)
                            switch blockValues.last! {
                            case .reference(let id, let referenceId):
                                XCTAssert(id == "titleFont")
                                XCTAssert(referenceId == "defaultFont")
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
        default:
            XCTAssert(false)
        }
    }
    
    func simpleStyle() -> String {
        return StyleParserTests.style(named: "SimpleStyle")
    }
    
    func nestedStyle() -> String {
        return StyleParserTests.style(named: "NestedStyle")
    }
    
    func referencedStyle() -> String {
        return StyleParserTests.style(named: "ReferencedStyle")
    }
    
    static func style(named name: String) -> String {
        let path = Bundle(for: StyleParserTests.self).path(forResource: name, ofType: "swash")!
        return try! String(contentsOfFile: path)
    }
}
