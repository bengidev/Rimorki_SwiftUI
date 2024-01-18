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
        
    private let timer = Timer.publish(every: 4.0, on: .main, in: .common).autoconnect()
    
    init() {
         // Hide the default UITabBar appearance
         //
         UITabBar.appearance().isHidden = true
     }

     var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appSecondary
                     .ignoresSafeArea()

                ScrollView {
                    VStack {
                         VStack(spacing: 0) {
                             Text("Featured")
                                 .font(.system(.title, design: .rounded).bold())
                                 .frame(maxWidth: .infinity, alignment: .leading)

                             TabView(selection: $selectedItem) {
                                 ForEach(1...5, id: \.self) { view in
                                     ZStack {
                                         Image(.gradientGreen)
                                             .resizable()

                                         HStack(spacing: 0) {
                                             Image(.rick)
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fit)
                                                 .frame(maxWidth: geo.size.width * 0.25)
                                                 .padding(.vertical, 5.0)
                                                 .padding(.horizontal)
                                                 .shadow(color: .black, radius: 10.0)
                                                 .drawingGroup()

                                             VStack (alignment: .leading) {
                                                 Text("Name: Rick")
                                                     .font(.system(.headline, design: .rounded).bold())
                                                     .padding(.top, 10.0)

                                                 Text("Status: Alive")
                                                     .font(.system(.subheadline, design: .rounded))

                                                 Text("Species: Alive")
                                                     .font(.system(.subheadline, design: .rounded))

                                                 Text("Type: Alive")
                                                     .font(.system(.subheadline, design: .rounded))

                                                 Text("Gender: Male")
                                                     .font(.system(.subheadline, design: .rounded))

                                                 Spacer()
                                             }
                                             .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                             .padding(.horizontal)
                                         }
                                     }
                                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                                     .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                 }
                             }
                             .tabViewStyle(PageTabViewStyle())
                             .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                             .padding(.vertical, 10.0)
                             .padding(.horizontal, 5.0)
                             .onReceive(timer) { _ in
                                 withAnimation {
                                     selectedItem = (selectedItem + 1) % 6
                                 }
                             }
                         }
                         .frame(width: .infinity, height: geo.size.height * 0.3)
                         .padding(.horizontal, 10.0)
                         .background(Color.appSecondary)

                         VStack {
                             Text("Collections")
                                 .font(.system(.title, design: .rounded).bold())
                                 .frame(maxWidth: .infinity, alignment: .leading)

                             HStack {
                                 Image(systemName: "magnifyingglass").foregroundColor(.gray)
                                 TextField("Search", text: .constant(""))
                                     .font(.system(.title3, design: .rounded))
                                 Image(systemName: "trash").foregroundColor(.gray)
                             }
                             .padding(.all, 10.0)
                             .background(Color.gray.opacity(0.3))
                             .cornerRadius(10.0)

                             List {
                                 ForEach(1..<100) { index in
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
                                     .listRowBackground(Color.gray.opacity(0.5))
                                 }
                                 .swipeActions(edge: .leading) {
                                     Button {

                                     } label: {
                                         Image(systemName: "star.slash")
                                     }
                                 }
                                 .swipeActions(edge: .trailing) {
                                     Button {

                                     } label: {
                                         Image(systemName: "trash.fill")
                                     }
                                 }
                             }
                             .id(UUID())
                             .listStyle(.plain)
                             .clipShape(RoundedRectangle(cornerRadius: 10.0))
                         }
                         .frame(width: .infinity, height: geo.size.height * 0.65)
                         .padding(.all, 10.0)
                    }
                }
             }
         }
     }
}

#Preview {
    DashboardView()
}
