//
//  MapManager.swift
//  Santa Tracker
//
//  Created by msano on 2017/01/11.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import Foundation
import MapKit

class MapManager: NSObject {
    private let santaAnnotation = MKPointAnnotation() // ピンのアノテーション
    
    init(mapView: MKMapView) {
        santaAnnotation.title = "🎅"
        super.init()
        mapView.addAnnotation(self.santaAnnotation)
    }
    
    func update(with santa: Santa) {
        
        let santaLocation = santa.currentLocation.clLocationCoordinate2D
        DispatchQueue.main.async {
            self.santaAnnotation.coordinate = santaLocation
        }
        
        // サンタ位置表示のため地図を更新する
//        self.santaAnnotation.coordinate = santaLocation
    }
}

private extension Location {
    var clLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
