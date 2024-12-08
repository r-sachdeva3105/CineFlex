//
//  MovieCell.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-12-06.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional setup if needed
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }

    func configure(with movie: Movie) {
//        titleLabel.text = movie.displayTitle
        if let posterPath = movie.poster_path, !posterPath.isEmpty {
            let imageUrl = URL(string: "\(APIConstants.imageBaseURL)\(posterPath)")
            DispatchQueue.global().async {
                if let imageUrl = imageUrl, let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            posterImageView.image = UIImage(named: "placeholder") // Fallback for no poster
        }
    }
}
