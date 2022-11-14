//
//  FavouritePrimeState.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 14/11/22.
//
import SwiftUI

class FavouritePrimeState: ObservableObject {
    private var state: AppState

    init(state: AppState) {
        self.state = state
    }

    var favouritePrimes: [Int] {
        get {
            state.favouritePrimes
        }
        set {
            state.setFavourites(newValue)
        }
    }

    var activityFeed: [Activity] {
        get {
            state.activityFeed
        }
        set {
            state.setActivityFeed(newValue)
        }
    }
}
