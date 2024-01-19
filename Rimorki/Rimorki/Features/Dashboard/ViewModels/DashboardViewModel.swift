//
//  DashboardViewModel.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import Combine
import Foundation

final class DashboardViewModel: Observable {
    @Published var collections: RickMortyAPIModel = .empty
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let dataSources: RickMortyAPI = .init()
    
    func fetchAllCharacters() -> Void {
        dataSources.fetchAllCharacters()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failure with: ", error)
                }
            } receiveValue: { value in
                print("Receive Value: ", value)
            }
            .store(in: &cancellables)
    }
}
