//
//  YoutubeSearchResponse.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 20/04/25.
//

import Foundation

struct YoutubeSearchResponse: Decodable {
    let items: [VideoElement]
}

struct VideoElement: Decodable {
    let id: IdVideoElement
}

struct IdVideoElement: Decodable {
    let kind: String
    let videoId: String
}
