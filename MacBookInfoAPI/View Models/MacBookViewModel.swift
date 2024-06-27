//
//  MacBookViewModel.swift
//  MacBookInfoAPI
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import Foundation
import Combine

class MacBookViewModel: ObservableObject {
    @Published var macBook: MacBook?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let macBookService: MacBookService
    
    // Default initializer
    init(macBookService: MacBookService = MacBookService()) {
        self.macBookService = macBookService
    }
    
    func fetchMacBook(id: String) {
        macBookService.fetchMacBook(id: id)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { macBook in
                self.macBook = macBook
            }
            .store(in: &cancellables)
    }
}
