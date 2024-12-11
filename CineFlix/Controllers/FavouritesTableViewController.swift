//
//  FavouritesTableViewController.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-12-10.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    
    // Array to hold fetched movies from Core Data
    private var favouriteMovies: [MovieCoreDataEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavouriteCell")
        
        // Fetch movies from Core Data
        fetchFavouriteMovies()
    }
    
    private func fetchFavouriteMovies() {
        favouriteMovies = CoreDataManager.shared.fetchMovies()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Single section for all favourite movies
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows equals the number of favourite movies
        return favouriteMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
        
        // Configure the cell with movie data
        let movie = favouriteMovies[indexPath.row]
        cell.textLabel?.text = movie.title ?? "Unknown Title"
        cell.detailTextLabel?.text = movie.releaseDate ?? "N/A"
        
        return cell
    }
    
    // Handle row selection to navigate to the movie detail view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = favouriteMovies[indexPath.row]
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        // Convert MovieCoreDataEntity to Movie to pass to detail view controller
        detailVC.movie = Movie(
            id: Int(selectedMovie.id),
            title: selectedMovie.title ?? "",
            name: selectedMovie.title ?? "",
            overview: selectedMovie.overview ?? "",
            poster_path: selectedMovie.posterPath ?? "",
            backdrop_path: selectedMovie.posterPath ?? "",
            media_type: nil,
            release_date: selectedMovie.releaseDate ?? "",
            first_air_date: "movie",
            vote_average: selectedMovie.voteAverage
        )
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
