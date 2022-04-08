//
//  NSObject+Extensions.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 08/04/2022.
//

import Foundation


extension NSObject {
    
    struct Keys {
        static var associatedObjects: UInt8 = 0
    }
    
    var associatedObjects: NSMutableDictionary {
        get {
            if let associatedObjects = objc_getAssociatedObject(self, &Keys.associatedObjects) as? NSMutableDictionary {
                return associatedObjects
            } else {
                let associatedObjects: NSMutableDictionary = [:]
                objc_setAssociatedObject(self, &Keys.associatedObjects, associatedObjects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return associatedObjects
            }
        }
    }
    
    func associate(value: Any?, for key: AnyHashable) {
        if let value = value {
            associatedObjects[key] = value
        } else {
            dissociate(valueFor: key)
        }
    }
    
    func assodiatedValue(for key: AnyHashable) -> Any? {
        associatedObjects[key]
    }
    
    func dissociate(valueFor key: AnyHashable) {
        associatedObjects.removeObject(forKey: key)
    }
}
