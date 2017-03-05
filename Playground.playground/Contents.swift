import Foundation
import FootlessParser
@testable import Swashbuckler
import Result

// Input Style Sheet File.
let input = ".feedViewController\n    backgroundColor #FF00CC\n    defaultFont 12pt 'Helvetica-Neue'\n\n    #headerView\n        isTranslucent true\n        titleFont @defaultFont"

// 1. Preprocess
let preprocessedInput = Preprocessor.run(input: input)

// 2. Parse
let parser = Parser.rootParser
let ast = try! parse(parser, preprocessedInput)

// 3. Resolve
let resolvedAst = Resolver.run(input: ast)

// 4. Generate Code
let output = Generator.generate(input: resolvedAst, platform: .swift3_0)

// print(output)
