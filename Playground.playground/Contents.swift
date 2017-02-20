import Foundation
import UIKit

let input = "base\nbase\n  property\n  block_one\n    property_block_one\n    property_block_one\n  property\nbase\n"
let output = "{\nbase\nbase\n{\n  property\n  block_one\n{\n    property_block_one\n    property_block_one\n}\n  property\n}\nbase\n}"

let openingDelimiter = "{"
let closingDelimiter = "}"

private func preprocess(input string: String) -> String {
    let lines = input.replacingOccurrences(of: "\t", with: "\n\n")
                     .components(separatedBy: "\n")
                     .filter { !$0.isEmpty }
    let processed = [ openingDelimiter ] + insertTokens(lines: lines, stack: [0])
    
    return processed.joined(separator: "\n")
}

private func insertTokens(lines: [String], stack: [UInt]) -> [String] {
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

private func isWhitespace(character ch: Character) -> Bool {
    return ch == " " as Character || ch == "\t" as Character
}

private func computeIndentation(for line: String) -> UInt {
    var sum: UInt = 0
    
    for character in line.characters {
        if !isWhitespace(character: character) { break }
        sum += 1
    }
    
    return sum
}

let indentation = computeIndentation(for: "     h e  llo ")
let computed = preprocess(input: input)

computed == output

