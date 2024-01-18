//
//  DashboardView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedItem: Int = 0
    let timer = Timer.publish(every: 4.0, on: .main, in: .common).autoconnect()
    
    init() {
        // Hide the default UITabBar appearance
        //
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appPrimary
                    .ignoresSafeArea()
                
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
                                            .shadow(radius: 10.0)
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
                                selectedItem =  (selectedItem + 1) % 6
                            }
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: geo.size.height * 0.3
                    )
                    .padding(.horizontal, 10.0)
                    .background(Color.appSecondary)
                    
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 10.0)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
