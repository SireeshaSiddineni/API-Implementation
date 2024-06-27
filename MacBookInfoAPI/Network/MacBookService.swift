//
//  MacBookService.swift
//  MacBookInfoAPI
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import Foundation
import Combine

class MacBookService {
    private let baseUrl = "https://api.restful-api.dev/objects/" //API from -https://restful-api.dev
    
    func fetchMacBook(id: String) -> AnyPublisher<MacBook, Error> {
        guard let url = URL(string: "\(baseUrl)\(id)") else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MacBook.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
