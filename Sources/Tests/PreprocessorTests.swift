//
//  PreprocessorTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import Swashbuckler

class PreprocessorTests: XCTestCase {
    
    func testBlockInsertion() {
        let rawInput = "base\nbase\n  property\n  block_one\n    property_block_one\n    property_block_one\n  property\nbase\n"
        let expectedOutput = "{\nbase\nbase\n{\n  property\n  block_one\n{\n    property_block_one\n    property_block_one\n}\n  property\n}\nbase\n}"
        let computed = Preprocessor.run(input: rawInput)
        
        XCTAssert(computed == expectedOutput)
    }
}
