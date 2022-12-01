//
//  ImagesCollectionView.swift
//  ImageSearcher
//
//  Created by Kyzu on 1.12.22.
//

import UIKit

class ImagesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var vcDelegate: MainViewController!
    private var isFetchingMore = false
    private var cellWidth = (UIScreen.main.bounds.width - 60) / 2
    private var cellHeight: CGFloat { return (cellWidth * 1.5) }
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var networkDataFetcher = NetworkDataFetcher()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        allowsSelection = true
        translatesAutoresizingMaskIntoConstraints = false
        register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.id)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vcDelegate.viewModel?.photosWithInfo.value.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.id, for: indexPath) as? ImagesCollectionViewCell else { return UICollectionViewCell()}

        cell.backgroundColor = .gray
        let currentPhoto = vcDelegate.viewModel?.photosWithInfo.value[indexPath.item]
        cell.updateUI(currentPhoto)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photoStr = vcDelegate.viewModel.photosWithInfo.value[indexPath.row].urlZ else { return }
        vcDelegate.coordinator?.toBigPhotoVC(bigURLString: photoStr)
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         let photosCount = vcDelegate.viewModel.photosWithInfo.value.count
        if indexPath.row == photosCount - 1 {
            self.vcDelegate.viewModel.pageNumber.value += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                self?.vcDelegate.viewModel.fetchNextPage()
            })
        }
    }
    
}
