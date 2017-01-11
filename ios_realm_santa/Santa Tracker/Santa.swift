//
//  Santa.swift
//  Santa Tracker
//
//  Created by msano on 2017/01/11.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import Foundation
import RealmSwift

class Santa: Object {
    private dynamic var _currentLocation: Location?
    var currentLocation: Location {
        get {
            return _currentLocation ?? Location(latitude:90, longitude:180)
        }
        set {
            _currentLocation = newValue
        }
    }
    
    // ignoredPropertiesによりRealmからは無視させる
    override static func ignoredProperties() -> [String] {
        return ["currentLocation"]
    }
}

extension Santa {
    static func test() -> Santa {
        let santa = Santa()
        santa.currentLocation = Location(latitude:35.689487, longitude:139.691706) // 東京都庁
        return santa
    }
}
