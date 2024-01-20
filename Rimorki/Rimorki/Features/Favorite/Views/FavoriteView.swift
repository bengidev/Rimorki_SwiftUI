//
//  FavoriteView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import Kingfisher
import SwiftUI

struct FavoriteView: View {
    private let viewModel: FavoriteViewModel = .init()
    @State private var rickMortyCollections: [RickMortyCDModel] = []
    @State private var convertedRickMortyModel: RickMortyAPIModel.Result = .empty
    @State private var isFavoriteModel: Bool = false
    @State private var isSheetPresented: Bool = false
    @State private var searchText = ""
    
    private var searchResults: [RickMortyCDModel] {
        if searchText.isEmpty {
            return rickMortyCollections
        } else {
            return rickMortyCollections.filter { $0.wrappedName.contains(searchText) }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {
                    ForEach(searchResults) { item in
                        Button {
                            DispatchQueue.main.async {
                                convertedRickMortyModel = viewModel.convertRickMortyCDtoAPI(item)
                                isFavoriteModel = item.isFavorite
                                
                                isSheetPresented.toggle()
                            }
                        } label: {
                            HStack {
                                let url = URL(string: item.wrappedImage)!
                                let processor = DownsamplingImageProcessor(size: geo.size)
                                |> RoundCornerImageProcessor(cornerRadius: 10.0)
                                
                                KFImage.url(url)
                                    .placeholder({ Image.init(systemName: "hourglass") })
                                    .setProcessor(processor)
                                    .loadDiskFileSynchronously()
                                    .cacheMemoryOnly()
                                    .fade(duration: 0.25)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack (alignment: .leading) {
                                    Text(item.wrappedName)
                                        .font(.system(.footnote, design: .rounded).bold())
                                    
                                    Text("Status: \(item.wrappedStatus)")
                                        .font(.system(.caption, design: .rounded))
                                }
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: geo.size.height * 0.08)
                            .background(Color.appPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .shadow(radius: 3.0)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0))
                        .listRowBackground(Color.appSecondary)
                    }
                }
                .searchable(text: $searchText)
                .listBackgroundColor(.appSecondary)
                .navigationTitle("Your Favorites")
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                rickMortyCollections = viewModel.fetchRickMortyCharacters()
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            DetailView(rickMortyModel: convertedRickMortyModel, isFavoriteModel: isFavoriteModel)
        }
    }
}

#Preview {
    FavoriteView()
}

