//
//  TagsCollectionView.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import Foundation
import UIKit

class TagsCollectionView: UICollectionView {
    
    weak var vcDelegate: MainViewController!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        register(TagsCollectionViewCell.self, forCellWithReuseIdentifier: TagsCollectionViewCell.id)
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vcDelegate.viewModel?.tags.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.id, for: indexPath) as? TagsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = vcDelegate.viewModel?.tags.value[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: frame.height)
    }
}
