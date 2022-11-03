//
//  OmdbApi.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 1.11.2022.
//

import Foundation
import Alamofire

protocol OmdbAPIProtocol {
    func getMovieDetails(id: String, completionHandler: @escaping (Result<Movie, NSError>) -> Void)
    func getMovies(searchText: String, completionHandler: @escaping (Result<SearchList, NSError>) -> Void)
}

class OmdbAPI: BaseAPI<APIManager>, OmdbAPIProtocol {
    
    func getMovieDetails(id: String, completionHandler: @escaping (Result<Movie, NSError>) -> Void) {
        self.fetchData(target: .getMovieDetails(id: id), responseClass: Movie.self) { (result) in
            completionHandler(result)
        }
    }
    
    func getMovies(searchText: String, completionHandler: @escaping (Result<SearchList, NSError>) -> Void) {
        self.fetchData(target: .searchMovies(searchText: searchText), responseClass: SearchList.self) { (result) in
            completionHandler(result)
        }
    }
}
