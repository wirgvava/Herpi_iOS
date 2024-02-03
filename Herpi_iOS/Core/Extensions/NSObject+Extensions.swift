//
//  NSObject+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 03.02.24.
//

import Foundation

extension NSObject {
    // Return class full name as String
    static var stringFromClass : String {
        return NSStringFromClass(self)
    }

    var stringFromClass : String {
        return NSStringFromClass(type(of: self))
    }
    
    static var className : String { 
        return self.stringFromClass.components(separatedBy: ".").last!
    }
    
    var className : String {
        return self.stringFromClass.components(separatedBy: ".").last!
    }
}
