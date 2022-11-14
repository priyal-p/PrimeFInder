//
//  AppState.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//

import SwiftUI

struct AppState: Codable {
    private(set) var count: Int = 0
    private(set) var favouritePrimes: [Int]
    private(set) var loggedInUser: User? = nil
    private(set) var activityFeed: [Activity] = []
    let userDefaultsKey = "AppState"

    enum CodingKeys: CodingKey {
        case count
        case favouritePrimes
        case activityFeed
    }

    init(count: Int = 0,
         favouritePrime: [Int] = [],
         activityFeed: [Activity] = []) {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let decoded = try? JSONDecoder().decode(AppState.self,
                                                       from: data) {
                self.count = decoded.count
                self.favouritePrimes = decoded.favouritePrimes
                self.activityFeed = decoded.activityFeed
                return
            }
        }
        self.count = count
        self.favouritePrimes = favouritePrime
        self.activityFeed = activityFeed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self,
                                     forKey: .count)
        favouritePrimes = try container.decode([Int].self,
                                               forKey: .favouritePrimes)
        activityFeed = try container.decode([Activity].self,
                                            forKey: .activityFeed)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count,
                             forKey: .count)
        try container.encode(favouritePrimes,
                             forKey: .favouritePrimes)
        try container.encode(activityFeed,
                             forKey: .activityFeed)
    }

    mutating func setFavourites(_ newValue: [Int]) {
        favouritePrimes = newValue
    }

    mutating func setActivityFeed(_ newValue: [Activity]) {
        activityFeed = newValue
    }

    mutating func setCount(_ newValue: Int) {
        count = newValue
    }

    mutating func removeFavouritePrime(_ number: Int) {
        let favouriteIndex = favouritePrimes.firstIndex(of: number)
        removeAtIndex(favouriteIndex ?? 0)
    }

    mutating func removeAtIndex(_ index: Int) {
        let number = favouritePrimes.remove(at: index)
        activityFeed.append(.init(timestamp: Date(),
                                  type: .removedFavouritePrime(number)))
    }

    mutating func addFavouritePrime(_ number: Int) {
        favouritePrimes.append(number)
        activityFeed.append(.init(timestamp: Date(),
                                  type: .addedFavouritePrime(number)))
    }
}
