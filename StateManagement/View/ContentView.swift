//
//  ContentView.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 09/11/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var state = Store(AppState())
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Counter View") {
                    CounterView()
                }
                NavigationLink("Favourites View") {
                    FavouritePrimeView()
                }
                NavigationLink("Activity Feed") {
                    ActivityFeedView()
                }
            }
            .navigationTitle("State Management")
        }
        .environmentObject(state)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: Store(AppState()))
    }
}
