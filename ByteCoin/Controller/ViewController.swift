//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var coinManger = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManger.delegate = self
    }
}


// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    /// sets the number of column in the ui picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// determines how many rows in the UIPicker
    /// - Returns: use a method to count the currencies in the array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManger.currencyArray.count
    }
    
}


// MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    /// a delegate method that sets the title of th row in the ui picker
    /// - Returns: the name of the currency got by using the index for currency array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManger.currencyArray[row]
    }
    
    
    /// passes the selected currency (row) in the UIPicker to the method in the CoinManager
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManger.currencyArray[row]
        coinManger.getCoinPrice(for: selectedCurrency)
        
//        print(selectedCurrency) // debug line
    }
}


// MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(_ coinManager: CoinManager, coinModel: CoinModel) {
        
        DispatchQueue.main.async {
            
            self.bitcoinLabel.text = coinModel.lastPriceString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: any Error) {
        
        print(error)
    }
}
                                

