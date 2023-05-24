//
//  addCityFromButton.swift
//  WeatherApp
//
//  Created by Anton on 24.05.23.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, complitionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfText = alertController.textFields?.first
            guard let text = tfText?.text else { return }
            complitionHandler(text)
        }
        
        alertController.addTextField() { (tf) in
            tf.placeholder = placeholder
        }
        
        let cancellButton = UIAlertAction(title: "Cancell", style: .default)
        
        alertController.addAction(okButton)
        alertController.addAction(cancellButton)
        
        present(alertController, animated: true)
    }
}
