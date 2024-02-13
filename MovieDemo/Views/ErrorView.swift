//
//  ErrorView.swift
//  MovieDemo
//
//  Created by Sandeep on 12/02/24.
//

import SwiftUI

enum ErrorType {
    case decoding
    case noInternet
    case backend(Int)
}

struct ErrorView: View {

    let error: ErrorType

    var body: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .foregroundColor(.red)
                .padding(2)
            Group {
                switch error {
                case .decoding:
                    Text("Please contact developer")
                case .noInternet:
                    Text("Please check your internet connection")
                case .backend(let code):
                    switch code {
                    case 403:
                        Text("API limit reached, wait a second")
                    case 503:
                        Text("Service unavailable")
                    default:
                        Text("Server error code: \(code)")
                    }
                }
    

            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(error: .noInternet)
}
