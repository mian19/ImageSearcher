//
//  UIButton+ActionButton.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

extension UIButton {
    static func actionButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = UIColor.init(rgb: 0xffffff)
        return button
    }
}
