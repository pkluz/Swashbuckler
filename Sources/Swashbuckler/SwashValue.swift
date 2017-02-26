//
//  SwashValue.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

public indirect enum SwashValue {
    case root(value: SwashValue)
    case block(value: [SwashValue])
    case classBlock(id: String, value: SwashValue)
    case idBlock(id: String, value: SwashValue)
    case font(id: String, size: Float, family: String)
    case color(id: String, red: Float, green: Float, blue: Float, alpha: Float)
    case bool(id: String, value: Bool)
    case number(id: String, value: Float)
    case size(id: String, width: Float, height: Float)
    case rect(id: String, x: Float, y: Float, width: Float, height: Float)
    case reference(id: String, referencedId: String)
}
