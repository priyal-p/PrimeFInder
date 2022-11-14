//
//  Store.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//
import Foundation

class Store<T: Encodable>: ObservableObject {
    @Published var value: T {
        didSet {
            save(self.value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    var storageKey: String {
        return String(describing: T.self)
    }

    func save(_ newValue: T) {
        if let encoded = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
}
