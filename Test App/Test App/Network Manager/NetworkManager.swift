//
//  NetworkManager.swift
//  Test App
//
//  Created by Владимир on 19.01.2022.
//

import Foundation

class NetworkManager {
    
    let networkRequest = NetworkRequest.shared
    static let shared = NetworkManager()
    
    private init() {}
    
    func getUsersData(urlString: String, response: @escaping ([ResultsUsers]?) -> Void) {    //get Data and decode them
        networkRequest.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode([ResultsUsers]?.self, from: data)
                    response(albums)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func getAlbumsData(urlString: String, response: @escaping ([ResultsAlbums]?) -> Void) {   // same for albums
        networkRequest.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode([ResultsAlbums]?.self, from: data)
                    response(albums)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }

}
