//
//  FootlessParser+Rects.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-25.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import FootlessParser

extension FootlessParser.Parser {
    
    /// Parser for rect values
    internal static var rectPropertyParser: FootlessParser.Parser<Character, CGRect> {
        let pointParser = FootlessParser.Parser.pointValueParser
        let rectParser = tuple <^> (pointParser <* whitespace) <*>
                                   (pointParser <* whitespace) <*>
                                   (pointParser <* whitespace) <*>
                                    pointParser
        return { CGRect(x: CGFloat($0),
                        y: CGFloat($1),
                        width: CGFloat($2),
                        height: CGFloat($3)) } <^> rectParser
    }
}
