//
//  ViewController.swift
//  ByteCoin
//
//  Created by murad on 30.11.2024.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    //MARK: - Properties
    
    let byteCoinView = ByteCoinView()
    var coinManager = CoinManager()
    let defaultCurrency = "USD"
    
    //MARK: - Life cycle
    override func loadView() {
        view = byteCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        fetchInitialCurrencyRate()
        setUpPickerViewWithDefaultCurrency()
    }

    //MARK: - Methods
    
    private func setDelegates() {
        coinManager.delegate = self
        byteCoinView.setPickerViewDelegate(self)
        byteCoinView.setPickerViewDataSource(self)
    }
    
    private func fetchInitialCurrencyRate() {
        coinManager.fetchRate(for: defaultCurrency)
    }
    
    private func setUpPickerViewWithDefaultCurrency() {
        byteCoinView.setDefaultPickerSelection(coinsArray: coinManager.currencyArray, currency: defaultCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension ByteCoinViewController: CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, coinData: CoinModel) {
        byteCoinView.updateUI(with: coinData)
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

//MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension ByteCoinViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = coinManager.currencyArray[row]
        coinManager.fetchRate(for: selected)
    }
}

