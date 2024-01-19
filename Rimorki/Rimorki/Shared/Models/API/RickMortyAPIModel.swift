//
//  RickMortyAPIModel.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import Foundation

struct RickMortyAPIModel: Hashable, Identifiable, Codable {
    struct Info: Hashable, Identifiable, Codable {
        var id = UUID()
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
        enum CodingKeys: CodingKey {
            case count
            case pages
            case next
            case prev
        }
        
        static let empty: Info = .init(
            count: 0,
            pages: 0,
            next: nil,
            prev: nil
        )
    }
    
    struct Result: Hashable, Identifiable, Codable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: Location
        let location: Location
        let image: String
        let episodes: [String]
        let url: String
        let created: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case status
            case species
            case type
            case gender
            case origin
            case location
            case image
            case episodes = "episode"
            case url
            case created
        }
        
        static let empty: Result = .init(
            id: 0,
            name: "",
            status: "",
            species: "",
            type: "",
            gender: "",
            origin: .empty,
            location: .empty,
            image: "",
            episodes: [],
            url: "",
            created: ""
        )
    }
    
    struct Location: Hashable, Identifiable, Codable {
        var id = UUID()
        let name: String
        let url: String
        
        enum CodingKeys: CodingKey {
            case name
            case url
        }
        
        static let empty: Location = .init(
            name: "",
            url: ""
        )
    }
    
    var id = UUID()
    let info: Info
    let results: [Result]
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
    
    static let empty: RickMortyAPIModel = .init(
        info: .empty,
        results: [.empty]
    )
}




