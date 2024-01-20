//
//  DetailView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import SwiftUI

struct DetailView: View {
    let rickMortyModel: RickMortyAPIModel.Result
    
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 0.9
    @State private var opacity: Double = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 50.0)
                
                Button {} label: {
                    Image(systemName: "star.fill")
                        .font(.title.bold())
                        .foregroundStyle(Color.yellow)
                }
                .position(x: geo.size.width / 9.5, y: geo.size.height / 5.5)
                .zIndex(1)
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title.bold())
                        .foregroundStyle(Color.red)
                }
                .position(x: geo.size.width / 1.1, y: geo.size.height / 5.5)
                .zIndex(1)
                
                VStack {
                    Image(.rick)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geo.size.width * 0.25, maxHeight: geo.size.height * 0.3)
                        .padding(.vertical, 5.0)
                        .padding(.horizontal)
                        .shadow(color: .black, radius: 10.0)
                        .position(x: geo.size.width / 2, y: geo.size.height / 5.5)
                    
                    VStack(alignment: .leading) {
                        Text("Name: \(rickMortyModel.name)")
                            .font(.system(.title3, design: .rounded).bold())
                        
                        Text("Status: \(rickMortyModel.status)")
                            .font(.system(.subheadline, design: .rounded))
                            .padding(.top, 10.0)
                        
                        Text("Species: \(rickMortyModel.species)")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Text("Type: \(rickMortyModel.type)")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Text("Gender: \(rickMortyModel.gender)")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Text("Origin: \(rickMortyModel.origin.name)")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Text("Location: \(rickMortyModel.location.name)")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all)
                    
                }
                .frame(maxWidth: geo.size.width * 0.95, maxHeight: geo.size.height * 0.7)
                .background {
                    Image(.gradientGreen)
                        .resizable()
                }
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .shadow(radius: 10.0)
            }
        }
        .scaleEffect(scale)
        .opacity(opacity)
        .drawingGroup()
        .background(BlurView(style: .systemThinMaterialDark))
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.easeInOut) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
    }
}

#Preview {
    DetailView(rickMortyModel: .empty)
}
