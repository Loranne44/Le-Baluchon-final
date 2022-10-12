//
//  TranslationViewController.swift
//  travelApp
//
//  Created by Loranne Joncheray on 08/09/2022.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var languageDetected: UILabel!
    @IBOutlet weak var languageDetectedTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func translateButton(_ sender: Any) {
        getTranslation()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        languageDetectedTextView.resignFirstResponder()
        englishTextView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        setUpDesign()
    }
    
    private func getTranslation() {
        TranslateService.shared.getTranslation(text: languageDetectedTextView.text) { [weak self] (success, translate) in
            self?.toggleActivityIndicator(shown: true)
            if let translate = translate {
                self?.toggleActivityIndicator(shown: false)
                self?.getDetectedLanguage(with: translate)
                self?.receiveTranslation(with: translate)
            } else {
                self?.toggleActivityIndicator(shown: false)
                self?.messageAlert(alert: .invalideResponse)
                self?.setUpDesign()
            }
        }
    }
    
    private func getDetectedLanguage(with detected_source_language: TranslateData) {
        self.languageDetected.text = detected_source_language.translations[0].detected_source_language
    }
    
    private func receiveTranslation(with text: TranslateData) {
        self.englishTextView.text = text.translations[0].text
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        translateButton.isHidden = shown
    }
    
    private func setUpDesign() {
        self.languageDetectedTextView.text = ""
        self.englishTextView.text = ""
        self.languageDetected.text = ""
    }
    
    func messageAlert(alert: TranslateDataError) {
        var message: String
        switch alert {
        case .invalideResponse:
            message = "Error in response Api"
        case .errorApiKey:
            message = "Error in apy key"
        }
        
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
