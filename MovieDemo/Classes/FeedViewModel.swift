//
//  FeedViewModel.swift
//  MovieDemo
//
//  Created by Sandeep on 12/02/24.
//

import Foundation
import Combine
import Alamofire

final class FeedViewModel: ObservableObject {

    // MARK: - Published properties

    @Published private(set) var state = PageState.idle

    // MARK: - Properties

    enum PageState {
        case idle
        case loading
        case failed(ErrorType)
        case loaded(FeedResponse)
    }

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Methods

   func fetchFeeds() {
       self.state = .loading
       FeedAdapter.topMovies()
           .sink(receiveCompletion: { [weak self] completion in
               guard let self = self else { return }
               switch completion {
               case .failure(let error):
                   if let afError = error as? AFError {
                       if let code = afError.responseCode {
                           self.state = .failed(.backend(code))
                       } else if afError.isSessionTaskError {
                           self.state = .failed(.noInternet)
                       } else if afError.isResponseSerializationError {
                           self.state = .failed(.decoding)
                       } else {
                           self.state = .failed(.backend(404))
                       }
                   } else {
                       self.state = .failed(.backend(404))
                   }
               case .finished:
                   break
               }
           }, receiveValue: { [weak self] value in
               guard let self = self else { return }
               self.state = .loaded(value)
           })
           .store(in: &subscriptions)
   }
}
