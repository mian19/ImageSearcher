//
//  UIViewController+Alert.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

extension UIViewController {
  func alert(message: AlertMessage, title: String = "") {
      let alertController = UIAlertController(title: title, message: message.rawValue, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
