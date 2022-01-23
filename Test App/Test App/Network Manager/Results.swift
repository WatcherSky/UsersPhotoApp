//
//  ResultsData.swift
//  Evaluation Test App
//
//  Created by Владимир on 02.10.2021.
//

import Foundation

struct ResultsUsers: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case id = "id"
    }
    let name: String
    let username: String
    let id: Int
}

struct ResultsAlbums: Codable {
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
    }
    let albumId: Int
    let id: Int
    let title: String
    let url: String
}
