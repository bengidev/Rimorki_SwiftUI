//
//  FavoriteViewModel.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
    private let dataCD: RickMortyCD = .shared
    
    func fetchRickMortyCharacters() -> [RickMortyCDModel] {
        return dataCD.fetchRickMortyDataCD() ?? []
    }
    
    func deleteRickMortyCharacter(_ rickMorty: RickMortyAPIModel.Result) {
        dataCD.deleteRickMortyDataCD(rickMorty)
    }
    
    func convertRickMortyCDtoAPI(_ rickMorty: RickMortyCDModel) -> RickMortyAPIModel.Result {
        return .init(
            id: rickMorty.wrappedID,
            name: rickMorty.wrappedName,
            status: rickMorty.wrappedStatus,
            species: rickMorty.wrappedSpecies,
            type: rickMorty.wrappedType,
            gender: rickMorty.wrappedGender,
            origin: .init(name: rickMorty.wrappedOrigin, url: ""),
            location: .init(name: rickMorty.wrappedLocation, url: ""),
            image: rickMorty.wrappedImage,
            episodes: [],
            url: "",
            created: ""
        )
    }
}
