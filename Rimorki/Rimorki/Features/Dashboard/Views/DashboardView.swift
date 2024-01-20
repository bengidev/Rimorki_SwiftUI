//
//  DashboardView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import Combine
import Kingfisher
import SwiftUI

struct DashboardView: View {
    @State private var viewModel: DashboardViewModel = .init()
    @State private var rickMortyCollections: [RickMortyAPIModel.Result] = []
    @State private var selectedRickMortyModel: RickMortyAPIModel.Result = .empty
    @State private var selectedPage: Int = 1
    @State private var searchText = ""
    @State private var isSheetPresented = false
    
    @State private var gridItemColumns: [GridItem] = []
    
    private var searchResults: [RickMortyAPIModel.Result] {
        if searchText.isEmpty {
            return rickMortyCollections
        } else {
            return viewModel.filterRickMortyCharacters(with: searchText)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appSecondary
                    .ignoresSafeArea()
                
                NavigationView {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridItemColumns) {
                            ForEach(searchResults) { item in
                                Button {
                                    DispatchQueue.main.async {
                                        selectedRickMortyModel = item
                                        
                                        if !selectedRickMortyModel.name.isEmpty {
                                            isSheetPresented.toggle()
                                        }
                                    }
                                } label: {
                                    HStack {
                                        let url = URL(string: item.image)!
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
                                            Text(item.name)
                                                .font(.system(.footnote, design: .rounded).bold())
                                            
                                            Text("Status: \(item.status)")
                                                .font(.system(.caption, design: .rounded))
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height * 0.055)
                                    .background(Color.appPrimary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                    .shadow(radius: 3.0)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 15.0)
                        .drawingGroup()
                    }
                    .searchable(text: $searchText)
                    .navigationTitle("Collections")
                    .background(Color.appSecondary)
                }
                .position(x: geo.size.width / 2, y: geo.size.height * 0.4)
                
                PaginationView(currentPage: $selectedPage, totalPages: 50)
                    .frame(maxWidth: .infinity, maxHeight: 0)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
            }
        }
        .navigationViewStyle(.stack)
        .animation(.easeInOut, value: viewModel.rickMortyData)
        .onAppear {
            DispatchQueue.main.async {
                viewModel.fetchRickMortyData(withPage: selectedPage)
            }
        }
        .onChange(of: selectedPage) { value in
            DispatchQueue.main.async {
                viewModel.fetchRickMortyData(withPage: value)
            }
        }
        .onReceive(viewModel.$rickMortySortedCharacters) { value in
            DispatchQueue.main.async {
                rickMortyCollections = value
                
                if value.count <= 10 {
                    gridItemColumns = [
                        GridItem(.flexible()),
                    ]
                } else {
                    gridItemColumns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ]
                }
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            DetailView(rickMortyModel: selectedRickMortyModel) { isFavorite in
                DispatchQueue.main.async {
                    viewModel.addRickMortyCharacter(selectedRickMortyModel, isFavorite: isFavorite)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
