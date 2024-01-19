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
    @Environment(\.isSearching) var isSearching: Bool
    @State private var viewModel: DashboardViewModel = .init()
    @State private var rickMortyCollections: [RickMortyAPIModel.Result] = []
    @State private var selectedPage: Int = 1
    
    private let gridItemColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appSecondary
                    .ignoresSafeArea()
                
                NavigationView {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridItemColumns) {
                            ForEach(rickMortyCollections) { item in
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
                                .frame(maxWidth: geo.size.width, maxHeight: geo.size.height * 0.06)
                                .background(Color.appPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .shadow(radius: 3.0)
                            }
                        }
                        .padding(.horizontal, 15.0)
                        .drawingGroup()
                    }
                    .searchable(text: .constant("")) {
                        //                        ForEach(searchResults, id: \.self) { result in
                        //                            Text("Are you looking for \(result)?").searchCompletion(result)
                        //                        }
                    }
                    .navigationTitle("Collections")
                    .background(Color.appSecondary)
                }
                .position(x: geo.size.width / 2, y: geo.size.height * 0.4)
                
                PaginationView(currentPage: $selectedPage, totalPages: 50)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
            }
        }
        .animation(.easeInOut, value: viewModel.rickMortyData)
        .onAppear {
            viewModel.fetchRickMortyData(withPage: selectedPage)
        }
        .onChange(of: selectedPage) { value in
            viewModel.fetchRickMortyData(withPage: value)
        }
        .onReceive(viewModel.$rickMortySortedCharacters) { value in
            rickMortyCollections = value
        }
    }
}

#Preview {
    DashboardView()
}
