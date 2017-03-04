//
//  ResolverTests.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-03-02.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import XCTest
import FootlessParser
@testable import Swashbuckler

class ResolverTests: XCTestCase {

    func testStyleResolver() {
        let unresolved = unresolvedStyle()
        let _ = Resolver.run(input: unresolved)
        
        XCTAssert(true) // Makes sure we didn't throw an assertion exception, which implies that resolving succeeded.
    }
    
    func unresolvedStyle() -> SwashValue {
        let input = referencedStyle()
        let preprocessedInput = Preprocessor.run(input: input)
        let parser = Parser.rootParser
        let ast = try! parse(parser, preprocessedInput)
        
        return ast
    }
    
    func referencedStyle() -> String {
        return StyleParserTests.style(named: "ReferencedStyle")
    }
    
    static func style(named name: String) -> String {
        let path = Bundle(for: ResolverTests.self).path(forResource: name, ofType: "swash")!
        return try! String(contentsOfFile: path)
    }
}
