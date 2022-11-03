//
//  NetworkManager.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 1.11.2022.
//

import Foundation

enum APIManager {
    case getMovieDetails(id: String)
    case searchMovies(searchText: String)
}

extension APIManager: Target {
    var baseURL: String {
        switch self {
        default:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getMovieDetails(let id):
            return "\(Constants.apiKey)&i=\(id)"
        case .searchMovies(searchText: let searchText):
            return "\(Constants.apiKey)&s=\(searchText)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieDetails:
            return .get
        case .searchMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getMovieDetails:
            return .requestPlain
        case .searchMovies:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
}
