//
//  File.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-03-02.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation
import Mustache

internal struct Generator {
    
    internal static func generate(input: SwashValue) -> String {
        return input.toString(for: .swift3_0)
    }
}

enum TemplateType: String {
    case swift3_0
}

extension SwashValue {
    
    func toString(for type: TemplateType) -> String {
        var templateName = ""
        var data = [String:Any]()
        
        switch self {
        case .number(id: let id, value: let value):
            templateName = "value_key"
            data = [ "id": id, "value": value ]
        case .bool(id: let id, value: let value):
            templateName = "value_key"
            data = [ "id": id, "value": value ? "true" : "false" ]
        case .font(id: let id, size: let size, family: let family):
            templateName = "value_font"
            data = [ "id": id, "size": size, "family": family ]
        case .color(id: let id, red: let red, green: let green, blue: let blue, alpha: let alpha):
            templateName = "value_color"
            data = [ "id": id, "red": red, "green": green, "blue": blue, "alpha": alpha ]
        case .size(id: let id, width: let width, height: let height):
            templateName = "value_size"
            data = [ "id": id, "width": width, "height": height ]
        case .rect(id: let id, x: let x, y: let y, width: let width, height: let height):
            templateName = "value_rect"
            data = [ "id": id, "x": x, "y": y, "width": width, "height": height ]
        case .idBlock(id: let id, values: let values):
            templateName = "value_idBlock"
            data = [ "id": id,
                     "symbolId": id.uppercasedFirstLetter(),
                     "properties": values.map { $0.toString(for: type) }.joined() ]
        case .classBlock(id: let id, values: let values):
            templateName = "value_classBlock"
            data = [ "id": id,
                     "symbolId": id.uppercasedFirstLetter(),
                     "properties": values.map { $0.toString(for: type) }.joined() ]
        case .root(value: let values):
            templateName = "root"
            data = [ "data": values.map { $0.toString(for: type) }.joined() ]
        default:
            break
        }
        
        do {
            let name = type.rawValue + "_" + templateName
            let template = try Template(named: name, bundle: Bundle.frameworkBundle())
            let output = try template.render(data)
            return output
        } catch let error {
            print("toString(for:) > error: \(error)")
            return ""
        }
    }
}
