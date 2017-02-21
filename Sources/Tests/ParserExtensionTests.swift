//
//  ParserExtensionTests.swift
//  Tests
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import XCTest
import FootlessParser
@testable import Swashbuckler

class ParserExtensionTests: XCTestCase {
    
    func testDecimalParser() {
        let parser = Parser<Character, Float>.decimalParser()

        let output = try! parse(parser, "0.12")
        XCTAssert(output == 0.12)
        
        let output2 = try! parse(parser, "12.21")
        XCTAssert(output2 == 12.21)
        
        let output3 = try! parse(parser, "-3.45")
        XCTAssert(output3 == -3.45)
        
        do {
            let _ = try parse(parser, "abc0.12")
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
        
        do {
            let _ = try parse(parser, "0.12a")
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
        
        do {
            let _ = try parse(parser, "33a")
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
    
    func testUnsignedIntegerParser() {
        let parser = Parser<Character, UInt>.unsignedIntegerParser()
        
        let output = try! parse(parser, "12")
        XCTAssert(output == 12)
        
        let output2 = try? parse(parser, "-0.12")
        XCTAssert(output2 == nil)
        
        let output3 = try? parse(parser, "-3")
        XCTAssert(output3 == nil)
    }
    
    func testHexComponentsParser() {
        do {
            let parser = Parser<Character, ColorComponents>.hexComponentsParser()
            let valid1 = try parse(parser, "#FF00FFFF")
            XCTAssert(valid1.r == 255)
            XCTAssert(valid1.g == 0)
            XCTAssert(valid1.b == 255)
            XCTAssert(valid1.a == 255)
            
            let valid2 = try parse(parser, "#0000FF")
            XCTAssert(valid2.r == 0)
            XCTAssert(valid2.g == 0)
            XCTAssert(valid2.b == 255)
            XCTAssert(valid2.a == 255)
            
            let invalid1 = try? parse(parser, "00FF")
            XCTAssert(invalid1 == nil)
            
            let invalid2 = try? parse(parser, "00FF44FFFF")
            XCTAssert(invalid2 == nil)
            
            let invalid3 = try? parse(parser, "#NN00FF")
            XCTAssert(invalid3 == nil)
        } catch {
            XCTFail()
        }
    }
    
    func testRGBAComponentsParser() {
        do {
            let parser = Parser<Character, ColorComponents>.rgbaComponentsParser()
            let string = "rgba(255,  0, 12, 255)"
            let output = try parse(parser, string)
            XCTAssert(output.r == 255)
            XCTAssert(output.g == 0)
            XCTAssert(output.b == 12)
            XCTAssert(output.a == 255)
        } catch {
            XCTFail()
        }
    }
}
