//
//  ViewController.swift
//  ImageSearcher
//
//  Created by Kyzu on 28.11.22.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    
    }
    
    func bindViewModel() {
        viewModel.statusText.bind(<#T##listener: Dynamic<String>.Listener?##Dynamic<String>.Listener?##(String) -> Void#>)
    }


}

