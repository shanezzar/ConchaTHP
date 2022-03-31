//
//  WelcomeView.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 29/03/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    // MARK: - Observed Variables
    
    @StateObject private var model = ViewModel()
    @State private var active: Int? = 0
    
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                Text("CONCHA LABS")
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 28))
                    .foregroundColor(.titleColor)
                    .padding(.top, 36)
                
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 60)
                    
                Button {
                    haptic()
                    active = 1
                } label: {
                    Text("Let's start")
                        .font(Font.custom(CustomFont.sofiaProSemiBold, size: 18))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background((model.isLoading || !model.errorMessage.isEmpty) ? Color.gray.opacity(0.5) : Color.appYellow)
                        .cornerRadius(32)
                }
                .disabled((model.isLoading || !model.errorMessage.isEmpty))
                
                if model.isLoading {
                    ProgressView()
                        .padding(.vertical, 36)
                }
                
                if !model.isLoading && model.errorMessage != "" {
                    Text(model.errorMessage)
                        .font(Font.custom(CustomFont.sofiaProSemiBold, size: 15))
                        .foregroundColor(.titleColor)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding([.horizontal, .top], 24)
                    
                    Button {
                        haptic()
                        if model.concha.ticks != nil {
                            model.fetch(for: .start, ["choice": "start"])
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .cornerRadius(36)
                            .padding()
                    }
                }
                
                NavigationLink(destination: TestView(rootActive: $active), tag: 1, selection: $active) {
                    EmptyView()
                }
                .isDetailLink(false)
            }
            
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .task {
            if model.concha.ticks == nil {
                model.fetch(for: .start, ["choice": "start"])
            }
        }
        .environmentObject(model)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
