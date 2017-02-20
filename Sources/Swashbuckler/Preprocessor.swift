//
//  Preprocessor.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

public struct Preprocessor {
    
    fileprivate static let openingDelimiter = "{"
    fileprivate static let closingDelimiter = "}"
    
    internal static func run(input string: String) -> String {
        let lines = string.replacingOccurrences(of: "\t", with: "\n\n")
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
        let processed = [ openingDelimiter ] + insertTokens(lines: lines, stack: [0])
        
        return processed.joined(separator: "\n")
    }
    
    fileprivate static func insertTokens(lines: [String], stack: [UInt]) -> [String] {
        guard let line = lines.first else {
            return stack.map { _ in closingDelimiter }
        }
        
        let rest = Array(lines.dropFirst())
        let indentation = computeIndentation(for: line)
        let stackTop = stack.first ?? 0
        let stackRest = Array(stack.dropFirst())
        
        if indentation > stackTop {
            return [ openingDelimiter, line ] + insertTokens(lines: rest, stack: [indentation] + stack )
        }
        
        if indentation == stackTop {
            return [ line ] + insertTokens(lines: rest, stack: stack)
        }
        
        if indentation < stackTop {
            return [ closingDelimiter ] + insertTokens(lines: lines, stack: stackRest)
        }
        
        return []
    }
    
    fileprivate static func isWhitespace(character ch: Character) -> Bool {
        return ch == " " as Character || ch == "\t" as Character
    }
    
    fileprivate static func computeIndentation(for line: String) -> UInt {
        var sum: UInt = 0
        
        for character in line.characters {
            if !isWhitespace(character: character) { break }
            sum += 1
        }
        
        return sum
    }
}
