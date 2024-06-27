//
//  MacBook.swift
//  MacBookInfoAPI
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import Foundation

struct MacBook: Codable {
    let id: String
    let name: String
    let data: MacBookData
}

struct MacBookData: Codable {
    let year: Int
    let price: Double
    let cpuModel: String
    let hardDiskSize: String
    
    enum CodingKeys: String, CodingKey {
        case year
        case price
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
    }
}
