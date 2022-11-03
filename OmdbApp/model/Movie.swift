//
//  Movie.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 1.11.2022.
//

import Foundation

struct Movie: Codable {
    var title: String
    var year: String
    var imdbID: String
    var type: String
    var poster: String
    var genre: String
    var runtime: String
    var director: String
    var actors: String
    var plot: String
    var released: String
    var rated: String
    var language: String
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MovieCodingsKeys.self)
            title = try container.decode(String.self, forKey: .title)
            year = try container.decode(String.self, forKey: .year)
            imdbID = try container.decode(String.self, forKey: .imdbID)
            type = try container.decode(String.self, forKey: .type)
            poster = try container.decode(String.self, forKey: .poster)
            genre = try container.decode(String.self, forKey: .genre)
            runtime = try container.decode(String.self, forKey: .runtime)
            director = try container.decode(String.self, forKey: .director)
            actors = try container.decode(String.self, forKey: .actors)
            plot = try container.decode(String.self, forKey: .plot)
            released = try container.decode(String.self, forKey: .released)
            rated = try container.decode(String.self, forKey: .rated)
            language = try container.decode(String.self, forKey: .language)
        }
        
        enum MovieCodingsKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID
            case type = "Type"
            case poster = "Poster"
            case genre = "Genre"
            case runtime = "Runtime"
            case director = "Director"
            case actors = "Actors"
            case plot = "Plot"
            case released = "Released"
            case rated = "Rated"
            case language = "Language"
        }
}

struct SearchList: Decodable {
    var Search: [SearchedMovie]
}

struct SearchedMovie: Decodable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var poster: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingsKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        imdbID = try container.decode(String.self, forKey: .imdbID)
        type = try container.decode(String.self, forKey: .type)
        poster = try container.decode(String.self, forKey: .poster)
    }
    
    enum CodingsKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

struct ErrorResponse: Decodable {
    let Response: String
    let Error: String
}
