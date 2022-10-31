//
//  ExchangeRateViewController.swift
//  travelApp
//
//  Created by Loranne Joncheray on 08/09/2022.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    @IBOutlet weak var eurosTextField: UITextField!
    @IBOutlet weak var dollarsTextLabel: UILabel!
    @IBOutlet weak var bitcoinTextLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var dateUpdated: UILabel!
    
    override func viewDidLoad() {
        activityIndicator.isHidden = true
        setUpDesign()
    }
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        getRate()
    }
    
    private func getRate() {
        guard let euroInput = eurosTextField.text,
              let eurosValue = Double(euroInput)
        else {
            messageAlert(alert: .invalidAmount)
            setUpDesign()
            return
        }
        ExchangeService.shared.getExchangeCurrency { [weak self] (success, rate) in
            self?.toggleActivityIndicator(shown: true)
            if let rate = rate {
                let convertBtc = ExchangeService.shared.convertCurrencies(dataCurrencieTarget: rate, currencieKey: "BTC", euroValue: eurosValue)
                self?.bitcoinTextLabel.text = "\(convertBtc)"
                
                let convertUsd = ExchangeService.shared.convertCurrencies(dataCurrencieTarget: rate, currencieKey: "USD", euroValue: eurosValue)
                self?.dollarsTextLabel.text = "\(convertUsd)"
                
                self?.getDate(with: rate)
                
                self?.toggleActivityIndicator(shown: false)
            } else {
                self?.toggleActivityIndicator(shown: false)
                self?.messageAlert(alert: ExchangeDataError.invalidData)
                self?.setUpDesign()
            }
        }
    }
    
    private func getDate(with date: ExchangeData) {
        self.dateUpdated.text = "Date updated : " + date.date
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        eurosTextField.resignFirstResponder()
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func setUpDesign() {
        self.eurosTextField.text = ""
        self.bitcoinTextLabel.text = ""
        self.dollarsTextLabel.text = ""
    }
    
    func messageAlert(alert: ExchangeDataError) {
        let alertVC = UIAlertController(title: "Error", message:  alert.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

extension ExchangeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
