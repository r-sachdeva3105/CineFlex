//
//  Movie.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-11-17.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String
    let release_date: String
}
