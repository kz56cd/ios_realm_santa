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
    
    let route = List<Stop>()
    
    private dynamic var _activity: Int = 0
    var activity: Activity {
        get {
            return Activity(rawValue: _activity)!
        }
        set {
            _activity = newValue.rawValue
        }
    }
    
    dynamic var presentsRemaining: Int = 0

    
    // 通知トークン
    private var observerTokens = [NSObject: NotificationToken]()
    
    // プロパティ変更の監視
    func addObserver(_ observer: NSObject) {
        // イニシャル受取
        addObserver(observer, forKeyPath: #keyPath(Santa._currentLocation), options: .initial, context: nil)
        // 位置情報 変更通知をセット
        addObserver(observer, forKeyPath: #keyPath(Santa._currentLocation.latitude), options: [], context: nil)
        addObserver(observer, forKeyPath: #keyPath(Santa._currentLocation.longitude), options: [], context: nil)
        addObserver(observer, forKeyPath: #keyPath(Santa._activity), options: [], context: nil)
        addObserver(observer, forKeyPath: #keyPath(Santa.presentsRemaining), options: [], context: nil)
        
        observerTokens[observer] = route.addNotificationBlock {
            [unowned self, weak observer] changes in
            switch changes {
            case .initial:
                // 処理を簡単にするため、"route"に対するKVOの呼び出しを偽装します
                observer?.observeValue(forKeyPath: "route", of: self, change: nil, context: nil)
            case .update:
                observer?.observeValue(forKeyPath: "route", of: self, change: nil, context: nil)
            case .error:
                fatalError("サンタの情報を更新できませんでした。")
            }
        }
    }
    
    func removeObserver(_ observer: NSObject) {
        observerTokens[observer]?.stop()
        observerTokens.removeValue(forKey: observer)
        removeObserver(observer, forKeyPath: #keyPath(Santa._currentLocation))
        removeObserver(observer, forKeyPath: #keyPath(Santa._currentLocation.latitude))
        removeObserver(observer, forKeyPath: #keyPath(Santa._currentLocation.longitude))
        removeObserver(observer, forKeyPath: #keyPath(Santa._activity))
        removeObserver(observer, forKeyPath: #keyPath(Santa.presentsRemaining))
    }
    
    
    // ignoredPropertiesによりRealmからは無視させる
    override static func ignoredProperties() -> [String] {
        return ["currentLocation", "activity"]
    }
}

extension Santa {
    static func test() -> Santa {
        let santa = Santa()
        santa.currentLocation = Location(latitude:35.689487, longitude:139.691706) // 東京都庁
        santa.activity = .deliveringPresents
        santa.presentsRemaining = 42
        return santa
    }
}
