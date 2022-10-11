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
        setUpDesign()
    }
    
    @IBAction func tappedConvertButton(_ sender: UIButton) {
        getRate()
    }
    
    private func getRate() {
        ExchangeService.shared.getExchangeCurrency { [weak self] (success, rate) in
            self?.toggleActivityIndicator(shown: true)
            if success, let rate = rate {
                let convertBtc = ExchangeService.shared.convertCurrencies(currencie: rate, valueToConvert: "BTC", ratesLabelCurrencie: (self?.bitcoinTextLabel)!, ratesLabelEur: (self?.eurosTextField)!)
                self?.bitcoinTextLabel.text = "\(convertBtc)"
                
                let convertUsd = ExchangeService.shared.convertCurrencies(currencie: rate, valueToConvert: "USD", ratesLabelCurrencie: (self?.dollarsTextLabel)!, ratesLabelEur: (self?.eurosTextField)!)
                self?.dollarsTextLabel.text = "\(convertUsd)"
                
                self?.getDate(with: rate)
                
                self?.toggleActivityIndicator(shown: false)
            } else {
                self?.presentAlert()
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
        toggleActivityIndicator(shown: false)
        self.eurosTextField.text = ""
        self.bitcoinTextLabel.text = ""
        self.dollarsTextLabel.text = ""
    }
    
    /* func messageAlert(alert: ExchangeDataError) {
     var message: String
     switch alert {
     case .invalidDate:
     message = "Error date download"
     case .invalideResponse:
     message = "ee"
     
     }
     let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
     alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
     present(alertVC, animated: true, completion: nil)
     }*/
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Une erreur est survenue", preferredStyle: .alert)
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
// ARC a revoir pour la gestion de la mémoire
