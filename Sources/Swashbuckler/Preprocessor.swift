//
//  Preprocessor.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

internal struct Preprocessor {
    
    internal static let openingDelimiter = "{"
    internal static let closingDelimiter = "}"
    fileprivate static let tabAsSpaces = "    "
    
    /// Runs the preprocessor on a given input string.
    internal static func run(input string: String) -> String {
        let lines = string.replacingOccurrences(of: "\t", with: tabAsSpaces)
                          .components(separatedBy: "\n")
                          .filter { !$0.isEmpty }
        let processed = [ openingDelimiter ] + insertDelimiters(lines: lines, stack: [0])
        return processed.map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
                        .joined(separator: "\n")
    }
    
    /// Inserts block delimiters into a tab and space aligned file.
    fileprivate static func insertDelimiters(lines: [String], stack: [UInt]) -> [String] {
        guard let line = lines.first else {
            return stack.map { _ in closingDelimiter }
        }
        
        let rest = Array(lines.dropFirst())
        let indentation = computeIndentation(for: line)
        let stackTop = stack.first ?? 0
        let stackRest = Array(stack.dropFirst())
        
        if indentation > stackTop {
            return [ openingDelimiter, line ] + insertDelimiters(lines: rest, stack: [indentation] + stack )
        }
        
        if indentation == stackTop {
            return [ line ] + insertDelimiters(lines: rest, stack: stack)
        }
        
        if indentation < stackTop {
            return [ closingDelimiter ] + insertDelimiters(lines: lines, stack: stackRest)
        }
        
        return []
    }
    
    /// Checks whether the give input character is a whitespace character.
    fileprivate static func isWhitespace(character ch: Character) -> Bool {
        return ch == " " as Character || ch == "\t" as Character
    }
    
    /// Computes the level of indentation for a given line
    fileprivate static func computeIndentation(for line: String) -> UInt {
        var sum: UInt = 0
        
        for character in line.characters {
            if !isWhitespace(character: character) { break }
            sum += 1
        }
        
        return sum
    }
}
