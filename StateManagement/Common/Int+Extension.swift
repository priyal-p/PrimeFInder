//
//  CheckPrime.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 12/11/22.
//
import Darwin

extension Int {
    var isPrime: Bool {
        let number = self
        if number <= 1 { return true }
        if number <= 3 { return true }
        for i in 2...Int(sqrt(Float(number))) {
            if number % i == 0 { return false }
        }
        return true
    }
}
