//
//  FavouritePrimeView.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//

import SwiftUI

struct FavouritePrimeView: View {
    @EnvironmentObject var state: Store<AppState>

    var body: some View {
        List {
            ForEach(state.value.favouritePrimes,
                    id: \.self) { prime in
                Text("\(prime)")
            }.onDelete { indexSet in
                for index in indexSet {
                    state.value.removeAtIndex(index)
                }
            }
        }
        .navigationTitle("Favourite Primes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavouritePrimeView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePrimeView()
            .environmentObject(
                Store(AppState(count: 4,
                         favouritePrime: [1, 2, 3, 7])))
    }
}
