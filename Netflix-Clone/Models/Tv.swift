//
//  Tv.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 19/04/25.
//

import Foundation

struct TrendingTvResponse: Decodable {
    let results: [Tv]
}

struct Tv: Decodable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let vote_count: Int
    let overview: String?
    let release_date: String?
    let vote_average: Double
}
