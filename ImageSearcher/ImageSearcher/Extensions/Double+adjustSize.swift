//
//  Double+adjustSize.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//
import UIKit

extension Double {
    func adjustSize() -> Double {
        let iPhone13ProMaxScreenWidth = 428 / self
        return UIScreen.main.bounds.width / iPhone13ProMaxScreenWidth
    }
}
