//
//  CoinModel.swift
//  ByteCoin
//
//  Created by sensei_blaq on 16/01/2026.
//  Copyright © 2026 The App Brewery. All rights reserved.
//

import Foundation

/// this takes the decoded value from CointData and is used to update the UI labels in the VC
struct CoinModel {
    
    let lastPrice: Double
    let currency: String 
    
    var lastPriceString: String {
        return String(format: "%.0f", lastPrice)
    }
}
