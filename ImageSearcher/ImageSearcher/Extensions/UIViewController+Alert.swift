//
//  UIViewController+Alert.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

extension UIViewController {
    func alert(message: AlertMessage, title: String = "") {
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!]
        let messageString = NSAttributedString(string: message.rawValue, attributes: messageAttributes)
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.setValue(messageString, forKey: "attributedMessage")
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
