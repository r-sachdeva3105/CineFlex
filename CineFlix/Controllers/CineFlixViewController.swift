//
//  CineFlixViewController.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-11-17.
//

import UIKit

class CineFlixViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var posterTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrendingMovies()
    }
    
    private func fetchTrendingMovies() {
        NetworkManager.shared.fetchTrendingMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    if let randomMovie = movies.randomElement(), let backdropPath = randomMovie.backdrop_path {
                        self?.loadBackdropImage(backdropPath: backdropPath)
                        self?.posterTitle.text = randomMovie.displayTitle
                    } else {
                        print("No movies or backdrop path available")
                    }
                case .failure(let error):
                    print("Failed to fetch trending movies: \(error.localizedDescription)")
                }
            }
        }
    }

    private func loadBackdropImage(backdropPath: String) {
        let urlString = "\(APIConstants.imageBaseURL)\(backdropPath)"
        guard let url = URL(string: urlString) else { return }

        // Load the image asynchronously
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    // Set a placeholder image if loading fails
                    self.posterView.image = UIImage(named: "placeholder-horizontal")
                }
            }
        }
    }
}
