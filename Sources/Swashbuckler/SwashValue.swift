//
//  SwashValue.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-20.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

public indirect enum SwashValue {
    case root(value: [SwashValue])
    case classBlock(id: String, values: [SwashValue])
    case idBlock(id: String, values: [SwashValue])
    
    case font(id: String, size: Float, family: String)
    case color(id: String, red: Float, green: Float, blue: Float, alpha: Float)
    case bool(id: String, value: Bool)
    case number(id: String, value: Float)
    case size(id: String, width: Float, height: Float)
    case rect(id: String, x: Float, y: Float, width: Float, height: Float)
    case reference(id: String, referencedId: String)
    
    func copy(with id: String) -> SwashValue? {
        switch self {
        case .classBlock(id: _, let values):
            return .classBlock(id: id, values: values)
        case .idBlock(id: _, let values):
            return .idBlock(id: id, values: values)
        case .font(id: _, size: let size, family: let family):
            return .font(id: id, size: size, family: family)
        case .color(id: _, red: let red, green: let green, blue: let blue, alpha: let alpha):
            return .color(id: id, red: red, green: green, blue: blue, alpha: alpha)
        case .bool(id: _, value: let value):
            return .bool(id: id, value: value)
        case .number(id: _, value: let value):
            return .number(id: id, value: value)
        case .size(id: _, width: let width, height: let height):
            return .size(id: id, width: width, height: height)
        case .rect(id: _, x: let x, y: let y, width: let width, height: let height):
            return .rect(id: id, x: x, y: y, width: width, height: height)
        case .reference(id: _, referencedId: let referencedId):
            return .reference(id: id, referencedId: referencedId)
        default:
            return nil
        }
    }
    
    var id: String? {
        switch self {
        case .classBlock(id: let id, _),
             .idBlock(id: let id, _),
             .font(id: let id, _, _),
             .color(id: let id, _, _, _, _),
             .bool(id: let id, _),
             .number(id: let id, _),
             .size(id: let id, _, _),
             .rect(id: let id, _, _, _, _),
             .reference(id: let id, _):
            return id
        default:
            return nil
        }
    }
    
    func isNode() -> Bool {
        switch self {
        case .root(_), .classBlock(_), .idBlock(_):
            return true
        default:
            return false
        }
    }
    
    func isLeaf() -> Bool {
        switch self {
        case .font(_), .color(_), .bool(_), .number(_), .size(_), .rect(_), .reference(_):
            return true
        default:
            return false
        }
    }
    
    func isReference() -> Bool {
        switch self {
        case .reference(_):
            return true
        default:
            return false
        }
    }
}

extension SwashValue {
    
    func toDictionary() -> Any {
        switch self {
        case .root(let values):
            return values.map { $0.toDictionary() }
        case .classBlock(let id, let values):
            return [ "classes": [ id: values.map { $0.toDictionary() } ] ]
        case .idBlock(let id, let values):
            return [ "ids": [ id: values.map { $0.toDictionary() } ] ]
        case .font(let id, let size, let family):
            return [ id: [ "size": size, "family": family ] ]
        case .color(let id, let red, let green, let blue, let alpha):
            return [ id: [ "red": red, "green": green, "blue": blue, "alpha": alpha ] ]
        case .bool(let id, let value):
            return [ id: value ]
        case .number(let id, let value):
            return [ id: value ]
        case .size(let id, let width, let height):
            return [ id: [ "width": width, "height": height ] ]
        case .rect(let id, let x, let y, let width, let height):
            return [ id: [ "x": x, "y": y, "width": width, "height": height ] ]
        case .reference(let id, let referencedId):
            return [ id: "@\(referencedId)" ]
        }
    }
}
