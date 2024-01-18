//
//  FavoriteView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import SwiftUI

struct FavoriteView: View {
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        HStack {
                            Image(.rick)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: geo.size.width * 0.07)
                                .padding(.vertical, 5.0)
                                .padding(.horizontal)
                                .shadow(color: .black, radius: 10.0)
                                .drawingGroup()
                            
                            VStack (alignment: .leading) {
                                Text("Name: Rick")
                                    .font(.system(.headline, design: .rounded).bold())
                                
                                Text("Status: Alive")
                                    .font(.system(.subheadline, design: .rounded))
                            }
                            
                            Spacer()
                        }
                        .frame(width: .infinity, height: geo.size.height * 0.08)
                        .background(Color.appPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0))
                        .listRowBackground(Color.appSecondary)
                    }
                }
                .listBackgroundColor(.appSecondary)
                .navigationTitle("Your Favorites")
            }
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text("Are you looking for \(result)?").searchCompletion(result)
                }
            }
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    FavoriteView()
}

