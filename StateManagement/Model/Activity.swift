//
//  Activity.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 14/11/22.
//
import Foundation

struct Activity: Codable {
    let timestamp: Date
    let type: ActivityType

    enum ActivityType: Codable {
        case addedFavouritePrime(Int)
        case removedFavouritePrime(Int)

        enum CodingKeys: String, CodingKey {
            case addedFavouritePrime = "add"
            case removedFavouritePrime = "remove"
        }
    }

    var description: String {
        switch type {
        case .removedFavouritePrime(let number):
            return "Removed \(number)"
        case .addedFavouritePrime(let number):
            return "Added \(number)"
        }
    }
}
