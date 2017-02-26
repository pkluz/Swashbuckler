//
//  Swashbuckler.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import FootlessParser
import Result

public enum SwashbucklerError: Error {
    case parserError(underlying: Error)
}

public struct Swashbuckler {

    public func run(input: String) -> Result<SwashValue, SwashbucklerError> {
        let preprocessedInput = Preprocessor.run(input: input)
        return Parser.parse(input: preprocessedInput)
    }
}
