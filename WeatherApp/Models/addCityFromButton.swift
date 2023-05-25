//
//  addCityFromButton.swift
//  WeatherApp
//
//  Created by Anton on 24.05.23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, complitionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfText = alertController.textFields?.first
            guard let text = tfText?.text, !text.isEmpty else {
                print("ERROR IS HERE")
                return
            }
            complitionHandler(text)
        }

        alertController.addTextField() { (tf) in
            tf.placeholder = placeholder
        }

        let cancelButton = UIAlertAction(title: "Cancel", style: .default)

        alertController.addAction(okButton)
        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }
    
       func displayErrorMessage(message: String) {
           let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
   }


