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
//            mapManager.update(with: santa) // 地図更新
            santa.addObserver(self)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let santa = object as? Santa {
            update(with: santa)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func update(with santa: Santa) {
        mapManager.update(with: santa)
        let activity = santa.activity.description
        let presentsRemaining = "\(santa.presentsRemaining)"
        DispatchQueue.main.async {
            self.activityLabel.text = activity
            self.presentsRemainingLabel.text = presentsRemaining
        }
    }

}

