//
//  KingFisherWrapper.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/7/2.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage? = nil) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}

