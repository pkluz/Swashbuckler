//
//  Resolver.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-02-26.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import Result

internal struct Resolver {
  
    internal static func resolve(value: SwashValue, keypath: [String], globalNamespace namespace: [String: SwashValue]) -> SwashValue {
        switch value {
        case .font(_),
             .color(_),
             .bool(_),
             .number(_),
             .size(_),
             .rect(_):
            return value
        case .reference(id: let id, referencedId: let referencedId):
            var keyElements = keypath
            var referencedValue: SwashValue?
            while keyElements.count > 0 {
                let possiblePath = (keyElements + [referencedId]).joined(separator: ".")
                guard let possibleValue = namespace[possiblePath] else {
                    _ = keyElements.popLast()
                    continue
                }
                
                referencedValue = possibleValue.copy(with: id)!
                break
            }
            
            assert(referencedValue != nil, "Reference for element: \(id) with name: @\(referencedId) could not be resolved!")
            
            return referencedValue!
        case .root(value: let values):
            let resolved = values.map { value -> SwashValue in
                return resolve(value: value, keypath: keypath + (value.id != nil ? [value.id!] : []), globalNamespace: namespace)
            }
            return .root(value: resolved)
        case .classBlock(id: let id, values: let values):
            let resolved = values.map { value -> SwashValue in
                return resolve(value: value, keypath: keypath + (value.id != nil ? [value.id!] : []), globalNamespace: namespace)
            }
            return .classBlock(id: id, values: resolved)
        case .idBlock(id: let id, values: let values):
            let resolved = values.map { value -> SwashValue in
                return resolve(value: value, keypath: keypath + (value.id != nil ? [value.id!] : []), globalNamespace: namespace)
            }
            return .idBlock(id: id, values: resolved)
        }
    }
    
    // Creates a global namespace mapping, without reference elements present. This mapping is then used to identify reference targets.
    internal static func leafs(for value: SwashValue, keypath: [String], current: [String: SwashValue]) -> [String: SwashValue] {
        var new = current
        switch value {
        case .font(id: let id, _, _),
             .color(id: let id, _, _, _, _),
             .bool(id: let id, _),
             .number(id: let id, _),
             .size(id: let id, _, _),
             .rect(id: let id, _, _, _, _):
            let path = (keypath + [id]).joined(separator: ".")
            new[path] = value
            return new
        case .classBlock(id: let id, values: let values),
             .idBlock(id: let id, values: let values):
            let newKeypath = keypath + [id]
            let children = values.map { value in
                return leafs(for: value, keypath: newKeypath, current: current)
            }
            
            children.forEach { mapping in
                mapping.forEach { (key: String, value: SwashValue) in
                    new[key] = value
                }
            }
            
            return new
        case .root(value: let values):
            let children = values.map { value in
                return leafs(for: value, keypath: keypath, current: current)
            }
            
            children.forEach { mapping in
                mapping.forEach { (key: String, value: SwashValue) in
                    new[key] = value
                }
            }
            
            return new
        default:
            return current
        }
    }
}
