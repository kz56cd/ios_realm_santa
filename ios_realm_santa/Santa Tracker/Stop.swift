//
//  Stop.swift
//  Santa Tracker
//
//  Created by msano on 2017/01/11.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import Foundation
import RealmSwift

class Stop: Object {
    dynamic var location: Location?
    dynamic var time: Date = Date(timeIntervalSinceReferenceDate: 0)
    
    convenience init(location: Location, time: Date) {
        self.init()
        self.location = location
        self.time = time
    }
}
