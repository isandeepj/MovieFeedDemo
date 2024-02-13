//
//  ContentView.swift
//  MovieDemo
//
//  Created by Sandeep on 11/02/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: FeedViewModel = FeedViewModel()

    private var subscriptions: Set<AnyCancellable> = []

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .idle:
                    Text("")
                        .onAppear {
                            viewModel.fetchFeeds()
                        }
                case .loading:
                    ProgressView()
                case .loaded(let feed):
                    List(feed.feed.entry) { entry in
                        NavigationLink(destination: FeedDetailView(feed: entry)) {
                               FeedView(feed: entry)
                           }

                    }
                    .listStyle(PlainListStyle())
                    Spacer()
                case .failed(let error):
                    ErrorView(error: error)
                }
            }
        }

    }

}

#Preview {
    ContentView()
}
