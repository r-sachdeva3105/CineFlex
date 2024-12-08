//
//  Movie.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-11-17.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let media_type: String?
    let release_date: String?
    let first_air_date: String?
    let vote_average: Float?
    
    var displayTitle: String {
        return title ?? name ?? "Untitled"
    }
}
