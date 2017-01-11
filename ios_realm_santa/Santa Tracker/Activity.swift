//
//  Activity.swift
//  Santa Tracker
//
//  Created by msano on 2017/01/11.
//  Copyright © 2017年 佐野正和. All rights reserved.
//

import Foundation

enum Activity: Int {
    case unknown = 0
    case flying
    case deliveringPresents
    case tendingToReindeer
    case eatingCookies
    case callingMrsClaus
}

extension Activity: CustomStringConvertible {
    var description: String {
        switch self {
        case .unknown:
            // "❔ なにをしているか不明です..."
            return "❔ We're not sure what Santa's up to right now…"
        case .callingMrsClaus:
            // "📞 奥さんと電話中です！"
            return "📞 Santa is talking to Mrs. Claus on the phone!"
        case .deliveringPresents:
            // "🎁 プレゼントを配っています！"
            return "🎁 Santa is delivering presents right now!"
        case .eatingCookies:
            // "🍪 おやつをたべています。"
            return "🍪 Santa is having a snack of milk and cookies."
        case .flying:
            // "🚀 つぎの家まで移動中です。"
            return "🚀 Santa is flying to the next house."
        case .tendingToReindeer:
            // "𐂂 トナカイのお世話をしています。"
            return "𐂂 Santa is taking care of his reindeer."
        }
    }
}
