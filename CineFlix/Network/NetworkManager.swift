//
//  NetworkManager.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-11-17.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = "\(APIConstants.baseURL)/trending/movie/week?api_key=\(APIConstants.apiKey)"
        // Networking code here...
    }
}
