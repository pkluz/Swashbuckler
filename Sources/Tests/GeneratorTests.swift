//
//  GeneratorTests.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-03-02.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import XCTest
import FootlessParser
@testable import Swashbuckler

class GeneratorTests: XCTestCase {

    func testStyleStructGeneration() {
//        let input = referencedStyle()
//        let preprocessedInput = Preprocessor.run(input: input)
//        let parser = Parser.rootParser
//        let ast = try! parse(parser, preprocessedInput)
//        
//        let generatedOutput = Generator.generate(input: ast)
        XCTAssert(true)
    }
    
    func testFontGeneration() {
        let input = fontValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == fontString())
    }
    
    func testColorGeneration() {
        let input = colorValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == colorString())
    }
    
    func testBoolGeneration() {
        let input = boolValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == boolString())
    }
    
    func testNumberGeneration() {
        let input = numberValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == numberString())
    }
    
    func testSizeGeneration() {
        let input = sizeValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == sizeString())
    }
    
    func testRectGeneration() {
        let input = rectValue()
        let output = Generator.generate(input: input)
        XCTAssert(output == rectString())
    }
    
    func referencedStyle() -> String {
        return StyleParserTests.style(named: "ReferencedStyle")
    }
    
    func fontValue() -> SwashValue {
        return SwashValue.font(id: "defaultFont", size: 12.0, family: "Helvetica-Neue")
    }
    
    func fontString() -> String {
        return "public let defaultFont = UIFont(name: \"Helvetica-Neue\", size: 12.0)! // swiftlint:disable:this force_unwrap\n"
    }
    
    func colorValue() -> SwashValue {
        return SwashValue.color(id: "backgroundColor", red: 200.0, green: 150.0, blue: 0.0, alpha: 255.0)
    }
    
    func colorString() -> String {
        return "public let backgroundColor = UIColor(red: 200.0/255.0, green: 150.0/255.0, blue: 0.0/255.0, alpha: 255.0/255.0)\n"
    }
    
    func numberValue() -> SwashValue {
        return SwashValue.number(id: "viewHeight", value: 320.0)
    }
    
    func numberString() -> String {
        return "public let viewHeight = 320.0\n"
    }
    
    func boolValue() -> SwashValue {
        return SwashValue.bool(id: "isTranslucent", value: true)
    }
    
    func boolString() -> String {
        return "public let isTranslucent = true\n"
    }
    
    func sizeValue() -> SwashValue {
        return SwashValue.size(id: "viewportSize", width: 320.0, height: 200.0)
    }
    
    func sizeString() -> String {
        return "public let viewportSize = CGSize(width: 320.0, height: 200.0)\n"
    }
    
    func rectValue() -> SwashValue {
        return SwashValue.rect(id: "preferredFrame", x: 20.0, y: 20.0, width: 320.0, height: 200.0)
    }
    
    func rectString() -> String {
        return "public let preferredFrame = CGRect(x: 20.0, y: 20.0, width: 320.0, height: 200.0)\n"
    }
    
    static func style(named name: String) -> String {
        let path = Bundle(for: GeneratorTests.self).path(forResource: name, ofType: "swash")!
        return try! String(contentsOfFile: path)
    }
}
