//
//  ImagesCollectionViewCell.swift
//  ImageSearcher
//
//  Created by Kyzu on 1.12.22.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    static let id = "ImagesCollectionViewCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.init(rgb: 0x000000)
        textView.textColor = UIColor.init(rgb: 0xffffff)
        textView.font = UIFont.systemFont(ofSize: 12.adjustSize())
        textView.textAlignment = .center
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        return textView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        textView.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        clipsToBounds = true
        setPhotoImageView()
        setTextView()
    }
    
    private func setPhotoImageView() {
        insertSubview(photoImageView, at: 0)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setTextView() {
        insertSubview(textView, at: 0)
        
        textView.isEditable = false
        textView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ currentPhoto: Photo?) {
    textView.text = "\(currentPhoto?.datetaken ?? "Loading...")\n\n\(currentPhoto?.title ?? "")\n\nTags:\n \(currentPhoto?.tags ?? "")"
        guard let imageURL = URL(string: currentPhoto!.urlQ ?? "") else { return }
        setImage(url: imageURL)
    }
    
    //MARK: - work with network
    private func setImage(url: URL) {
        NetworkDataFetcher().getImage(url: url) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.photoImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
