//
//  ViewController.swift
//  Santa Tracker
//
//  Created by 佐野正和 on 2017/01/02.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class SantaTrackerViewController: UIViewController {
    
    @IBOutlet private weak var timeRemainingLabel: UILabel!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var presentsRemainingLabel: UILabel!

    private var mapManager: MapManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        mapManager = MapManager(mapView: mapView)
        let realm = try! Realm()
        let santas = realm.objects(Santa.self)
        
        // 情報が存在しない場合、ダミー情報を書き込み
        if santas.isEmpty {
            try? realm.write {
                realm.add(Santa.test())
            }
        }
        
        // 非オプショナル型に変換
        if let santa = santas.first {
            mapManager.update(with: santa) // 地図更新
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

