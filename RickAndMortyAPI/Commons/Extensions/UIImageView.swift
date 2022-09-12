//
//  UIImageView.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 04/09/22.
//

import UIKit.UIImageView

extension UIImageView {
    func dowloadImage(at urlString: String) {
        guard let imageUrl = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let imageData = NSData(contentsOf: imageUrl) {
                let image = UIImage(data: imageData as Data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
