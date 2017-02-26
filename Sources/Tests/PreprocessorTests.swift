//
//  PreprocessorTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
@testable import Swashbuckler

class PreprocessorTests: XCTestCase {
    
    func testBlockInsertion() {
        let rawInput = "base\n.block\n  property\n  .block_two\n    property_block_two\n    property_block_two\n  property\nbase\n"
        let expectedOutput = "{\nbase\n.block\n{\nproperty\n.block_two\n{\nproperty_block_two\nproperty_block_two\n}\nproperty\n}\nbase\n}"
        let computed = Preprocessor.run(input: rawInput)
        
        XCTAssert(computed == expectedOutput)
    }
}
