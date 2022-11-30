//
//  TagTextField.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

class TagTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizationTF()
    }
    
    private func customizationTF() {
        layer.cornerRadius = 20.adjustSize()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 18.adjustSize())
        autocapitalizationType = .none
        autocorrectionType = .no
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15.adjustSize(), height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        returnKeyType = .done
        backgroundColor = UIColor.init(rgb: 0x272727)
        textColor = UIColor.init(rgb: 0xffffff)
        attributedPlaceholder = NSAttributedString(string: "Add photo tag ", attributes: [.foregroundColor: UIColor.init(rgb: 0xd5d5d5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
