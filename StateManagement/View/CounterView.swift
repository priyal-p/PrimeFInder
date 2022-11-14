//
//  CounterView.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//
import SwiftUI

struct CounterView: View {
    @EnvironmentObject var state: Store<AppState>
    @State private var presentingModal: Bool = false
    @State private var isAlertPresented: Bool = false
    @State private var alertNthPrime: Int?
    @State private var isNthPrimeButtomDisabled: Bool = false

    var body: some View {
        VStack {
            HStack {
                Button("-") {
                    state.value.setCount(state.value.count - 1)
                }
                Text("\(state.value.count)")
                    .foregroundColor(self.state.value.count.isPrime ? .green : .red)
                Button("+") {
                    state.value.setCount(state.value.count + 1)
                }
            }
            Button("Is this prime?") {
                presentingModal = true
            }
            .sheet(isPresented: $presentingModal,
                    onDismiss: {
                presentingModal = false
            }) {
                ModalView(
                    presentedAsModal: $presentingModal,
                    number: state.value.count)
            }

            Button("What is \(ordinal(state.value.count)) prime?",
                   action: nthPrimeButtonAction)
            .disabled(isNthPrimeButtomDisabled)
            .alert("\(ordinal(state.value.count)) Prime",
                   isPresented: $isAlertPresented) {
                Button("Dismiss") {
                    isAlertPresented = false
                }
            } message: {
                Text("\(ordinal(state.value.count)) prime is \(alertNthPrime ?? 0)")
            }

        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .navigationBarTitleDisplayMode(.inline)
    }

    func nthPrimeButtonAction() {
        isNthPrimeButtomDisabled = true
        nthPrime(state.value.count) { prime in
            alertNthPrime = prime
            isAlertPresented = true
            isNthPrimeButtomDisabled = false
        }
    }

    func ordinal(_ n: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(for: n) ?? ""
    }

    func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) {
        WolframAlphaClient()
            .wolframAlpha(query: "prime \(n)") { response in
                callback(
                    response
                        .flatMap {
                            $0.queryresult?
                                .pods?
                                .first(where: {$0.primary == .some(true)})?
                                .subpods?
                                .first?
                                .plaintext
                        }
                        .flatMap(Int.init))
            }
    }
}
