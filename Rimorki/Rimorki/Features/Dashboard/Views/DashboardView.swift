//
//  DashboardView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import Combine
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
                                    
                                    VStack (alignment: .leading) {
                                        Text(item.name)
                                            .font(.system(.subheadline, design: .rounded).bold())
                                        
                                        Text("Status: \(item.status)")
                                            .font(.system(.footnote, design: .rounded))
                                    }
                                    
                                    Spacer()
                                }
                                .frame(width: .infinity, height: geo.size.height * 0.06)
                                .background(Color.appPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                        }
                        .padding(.horizontal, 15.0)
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
        .onReceive(viewModel.$rickMortyData) { value in
            rickMortyCollections = value.results
        }
    }
}

#Preview {
    DashboardView()
}
