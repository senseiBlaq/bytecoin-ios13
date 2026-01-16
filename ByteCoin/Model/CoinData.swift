//
//  CoinData.swift
//  ByteCoin
//
//  Created by sensei_blaq on 15/01/2026.
//  Copyright © 2026 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData:Codable { // this the same structure as the JSON 
    
    let rate: Double
    let asset_id_quote: String
}
