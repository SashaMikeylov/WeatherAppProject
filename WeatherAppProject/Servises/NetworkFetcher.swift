//
//  NetworkFetcher.swift
//  WeatherAppProject
//
//  Created by Александр Микейлов on 15.12.2024.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Codable>(urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    var networking: Networking
    
    init (networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed ", jsonError)
            return nil
        }
    }
    
    func fetchGenericJSONData<T: Codable>(urlString: String, response: @escaping (T?) -> Void) {
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("error recieved data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
}
