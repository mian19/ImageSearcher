//
//  TagsCollectionViewCell.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    static let id = "TagsCollectionViewCell"
    var label: UILabel!
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.label.text = nil
//    }
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        layer.cornerRadius = self.frame.height / 2
         clipsToBounds = true
      
        backgroundColor = UIColor.init(rgb: 0xf7edf5)
         setLabel()
     }
    
    private func setLabel() {
        label = UILabel.customLabel(fontSize: 15.adjustSize())
        addSubview(label)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
