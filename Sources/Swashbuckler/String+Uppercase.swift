//
//  String+Uppercase.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-03-04.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

extension String {
    
    /// Uppercases the first letter in a string.
    func uppercasedFirstLetter() -> String {
        let firstChar = String(self.characters.first!).uppercased()
        let remainingString = self.substring(from: self.index(after: self.startIndex))
        
        return firstChar + remainingString
    }
}
