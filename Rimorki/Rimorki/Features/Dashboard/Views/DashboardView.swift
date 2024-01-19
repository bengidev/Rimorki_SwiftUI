//
//  DashboardView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.isSearching) var isSearching: Bool
    @State private var selectedItem: Int = 0
    @State private var currentPage = 1
    
    private var wikiCollections: [String] = []
    private var gridItemColumns: [GridItem] {
        if wikiCollections.count <= 10 {
            return [GridItem(.flexible())]
        }
        
        return [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    }
    
    private let totalPages = 20
    private let timer = Timer.publish(every: 4.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appSecondary
                    .ignoresSafeArea()
                
                NavigationView {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: gridItemColumns) {
                            ForEach(1...10, id: \.self) { item in
                                HStack {
                                    Image(.rick)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.all, 5.0)
                                        .shadow(color: .black, radius: 3.0)
                                        .drawingGroup()
                                    
                                    VStack (alignment: .leading) {
                                        Text("RickRickRickRickRickRick")
                                            .font(.system(.subheadline, design: .rounded).bold())
                                        
                                        Text("Status: Alive")
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
                
                PaginationView(currentPage: $currentPage, totalPages: totalPages)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
            }
        }
    }
}

#Preview {
    DashboardView()
}
