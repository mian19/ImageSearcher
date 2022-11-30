//
//  UILabel+customLabel.swift
//  ImageSearcher
//
//  Created by Kyzu on 1.12.22.
//

import UIKit

extension UILabel {
    static func customLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.init(rgb: 0x000000)
        return label
    }
}
