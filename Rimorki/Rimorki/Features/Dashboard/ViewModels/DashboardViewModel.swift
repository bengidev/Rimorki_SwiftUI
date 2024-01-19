//
//  DashboardViewModel.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import Combine
import Foundation

final class DashboardViewModel: ObservableObject {
    @Published var rickMortyData: RickMortyAPIModel = .empty
    @Published var rickMortyCharactersCount: Int = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let dataSources: RickMortyAPI = .init()
    
    func fetchRickMortyData(withPage page: Int = 1) -> Void {
        dataSources.fetchAllCharacters(withPage: page)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Failure with: ", error)
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                rickMortyData = value
                rickMortyCharactersCount = rickMortyData.results.count
            }
            .store(in: &cancellables)
    }
    
    func fetchAllSortedCharacters() -> [RickMortyAPIModel.Result] {
        return rickMortyData.results.sorted { $0.name < $1.name }
    }
}
