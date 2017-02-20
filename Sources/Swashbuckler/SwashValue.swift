//
//  SwashValue.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

public enum SwashValue {
    case Block(id: String, block: [SwashValue])
    case Font(id: String, size: Float, family: String)
    case Color(id: String, red: Float, green: Float, blue: Float)
    case Bool(id: String, value: Bool)
    case Size(id: String, width: Float, Height: Float)
    case Position(id: String, x: Float, y: Float)
    case Rect(id: String, x: Float, y: Float, width: Float, height: Float)
}
