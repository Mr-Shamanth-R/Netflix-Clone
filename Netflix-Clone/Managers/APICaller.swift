//
//  APICaller.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 19/04/25.
//

import Foundation

struct Constants {
    static let movieApiKey = "API_KEY"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let youtubeAPiKey = "API_KEY"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    func getTrendingMoveis(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.movieApiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.movieApiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.movieApiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.movieApiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.movieApiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.movieApiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&watch_monetization_types=flatrate") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.movieApiKey)&query=\(query)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovieTrailers(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
