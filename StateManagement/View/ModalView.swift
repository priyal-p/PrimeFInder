//
//  ModalView.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//

import SwiftUI

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @EnvironmentObject var state: Store<AppState>

    var number: Int
    var body: some View {
        let favouriteIndex = state.value.favouritePrimes.firstIndex(of: number)
        let isFavourite = favouriteIndex == nil
        Text(number.isPrime ?
             "\(number) is prime 🎉" :
                "\(number) is not prime 😓")
        Button(isFavourite ?
               "Save as a favourite prime" :
                "Remove from favourite items") {
            if isFavourite {
                state.value.addFavouritePrime(number)
            } else {
                state.value.removeFavouritePrime(number)
            }
        }.disabled(!number.isPrime)
    }
}
