//
//  ViewController.swift
//  myProject
//
//  Created by Roy on 2022/07/15.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CurrencyManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.resultLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    var currencyManager = CurrencyManager()
    
    var pickerDataSource = ["Austrailia", "Brazil", "Canada", "China", "Europe", "UK","Hong Kong", "Indonesia", "Israel", "India", "Japan", "Mexico", "Norway","New Zealand", "Poland", "Romania", "Russia", "Sweden", "Singapore", "USA", "South Africa"]

    func didFailWithError(error: Error) {
        print(error)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = currencyManager.currencyArray[row]
        currencyManager.getCurrency(for: selectedCurrency)
        countryName.text = pickerDataSource[row]
        countryImage.image = UIImage(named: pickerDataSource[row])
    }
}
