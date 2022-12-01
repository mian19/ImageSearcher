//
//  AppCoordinator.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        vc.viewModel = MainViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toBigPhotoVC(bigURLString: String) {
        let vc = BigPhotoViewController()
        vc.coordinator = self
        vc.viewModel = BigPhotoViewModel()
        guard let url = URL(string: bigURLString) else { return }
        vc.viewModel?.setImage(url: url)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toBack() {
        self.navigationController.popViewController(animated: true)
    }
}

