//
//  FeedAdapter.swift
//  MovieDemo
//
//  Created by Sandeep on 12/02/24.
//

import Foundation
import Combine

struct FeedAdapter {
    static func topMovies() -> AnyPublisher<FeedResponse, Error> {
        let url = "https://itunes.apple.com/us/rss/topmovies/limit=50/json"

        return APIManager.get.request(url: url)
            .tryMap { data in
                do {
                    let response = try JSONDecoder().decode(FeedResponse.self, from: data)
                    return response
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }

}

