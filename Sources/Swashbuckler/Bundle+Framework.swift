//
//  Bundle+Framework.swift
//  Swashbuckler
//
//  Created by Philip Kluz on 2017-03-02.
//  Copyright © 2017 Brwd Inc. All rights reserved.
//

import Foundation

extension Bundle {
    
    public class func frameworkBundle() -> Bundle {
        return Bundle(for: ClassBundle.self)
    }
}

fileprivate class ClassBundle { }
