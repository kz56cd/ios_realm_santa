//
//  Location.swift
//  Santa Tracker
//
//  Created by msano on 2017/01/11.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    dynamic var latitude: Double  = 0.0
    dynamic var longitude: Double = 0.0
    
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
}
