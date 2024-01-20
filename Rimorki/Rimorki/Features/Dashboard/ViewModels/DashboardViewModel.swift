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
    @Published var rickMortySortedCharacters: [RickMortyAPIModel.Result] = []
    
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
                rickMortySortedCharacters = value.results.sorted { $0.name < $1.name}
            }
            .store(in: &cancellables)
    }
    
    func filterRickMortyCharacters(with value: String) -> [RickMortyAPIModel.Result] {
        return rickMortySortedCharacters.filter { $0.name.contains(value) }
    }
}
