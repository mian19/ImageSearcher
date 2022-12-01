//
//  SortView.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

class SortView: UIView {
    let label = UILabel()
    let sortTypePicker = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.3)
        self.backgroundColor = UIColor.init(rgb: 0x0e0e0e)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        setElements()
    }
    
    convenience init(pickerDelegate: UIViewController, selectedRow: Int) {
        self.init(frame: CGRect.zero)
        sortTypePicker.delegate = pickerDelegate as? UIPickerViewDelegate
        sortTypePicker.dataSource = pickerDelegate as? UIPickerViewDataSource
        self.sortTypePicker.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    private func setElements() {
        label.text = "Sort by:"
        label.frame = CGRect(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height * 0.2)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25.0)
        
        sortTypePicker.frame = CGRect(x: self.bounds.minX, y: label.frame.maxY, width: self.bounds.width, height: self.bounds.height * 0.6)
        self.addSubview(label)
        self.addSubview(sortTypePicker)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
