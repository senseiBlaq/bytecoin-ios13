//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "cf21df58-e31a-4e68-aed5-b3e37a23c2dc"
    
    let currencyArray = [
        "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"
    ]
    
    
    func getCoinPrice (for currency: String) {
        let getURLstring = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        print(getURLstring)//debug line to check code
        perfomGet(with: getURLstring)
    }
    
    /// gets the data from the service by converting the string to a url; create a URLSession with default config; a dataTask with compleetionHandler; calls parseJSON
    func perfomGet (with getURLstring:String) {
        
        if let url = URL(string: getURLstring) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {
                (data, repsonse, error) in
                
                if error != nil {
                    print (error!)
                    
                    return
                }
                
                if let safeData = data {
                    let testResult = parseJSON(safeData)
                    print(testResult)
                }

//                let dataString = String(data: data!, encoding: .utf8)
//                print(dataString) // debugline to check code
                
            }
            
            task.resume()
        }
    }
    
    /// decodes the data received from the webservice by using thre JSONdecode class and a custom CoinData
    /// - Parameter data is the object holding the information received from the request
    func parseJSON (_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            
            return lastPrice
        } catch {
            
            delegate?.didFailWithError(self, error:error)
            return nil
        }
    }
    
    
    

    
}
