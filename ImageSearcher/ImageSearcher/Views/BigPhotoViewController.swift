//
//  BigPhotoViewController.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import UIKit

class BigPhotoViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var viewModel: BigPhotoViewModel?
    var indicator = UIActivityIndicatorView()
    
    var imageView: UIImageView!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.init(rgb: 0x0e0e0e)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        bindViewModel()
        setIndicator()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setIndicator() {
        view.addSubview(indicator)
        indicator.center = view.center
        indicator.color = UIColor.init(rgb: 0xffffff)
        indicator.frame.size = CGSize(width: 60, height: 60)
        indicator.startAnimating()
    }
    
    func bindViewModel() {
        viewModel?.bigPhoto.bind({(image) in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.indicator.stopAnimating()
            }
        })
    }
    
}
