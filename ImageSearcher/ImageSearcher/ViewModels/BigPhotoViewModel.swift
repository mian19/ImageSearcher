//
//  BigPhotoViewModel.swift
//  ImageSearcher
//
//  Created by Kyzu on 29.11.22.
//

import Foundation
import UIKit

class BigPhotoViewModel {
    var bigPhotoInfo = Dynamic(Photo.self)
    var bigPhoto = Dynamic(UIImage())
    
    func setImage(url: URL) {
        NetworkDataFetcher().getImage(url: url) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.bigPhoto.value = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
