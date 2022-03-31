//
//  TestView.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 31/03/2022.
//

import SwiftUI

struct TestView: View {
    
    // MARK: - Observed Variables
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: ViewModel
    
    @Binding var rootActive: Int?
    
    @State private var action: Int? = 0
    @State private var offset: CGFloat = 0
    @State private var index: Int = 0
    
    @State private var result: [[Int:Int]] = []
    
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    haptic()
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.titleColor)
                        .padding(24)
                }
                
                Spacer()
                
                Text("Please take the test")
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.titleColor)
                    .padding(.trailing, 24)
            }
            
            if let ticks = model.concha.ticks {
                Text("Current value: \(ticks[index])")
                    .font(Font.custom(CustomFont.sofiaProMedium, size: 15))
                    .padding(.bottom, 36)
                    .onChange(of: index) { _ in
                        haptic()
                    }
            }
            
            HStack {
                Spacer()
                
                Color.clear
                    .frame(width: 24, height: 24)
                    .padding()
                
                Spacer()
                
                if let ticks = model.concha.ticks {
                    SliderView(offset: $offset, index: $index, count: ticks.count)
                }
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    haptic()
                    
                    result.append([index : model.concha.ticks![index]])
                    
                    model.fetch(for: .next, [
                        "session_id": model.concha.sessionID,
                        "choice" : index
                    ])
                } label: {
                    Text("Next")
                        .font(Font.custom(CustomFont.sofiaProSemiBold, size: 18))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background(Color.appYellow)
                        .cornerRadius(32)
                }
                .padding([.trailing, .bottom], 36)
                
                NavigationLink(destination: ResultView(rootActive: $rootActive, result: result), tag: 1, selection: $action) {
                    EmptyView()
                }
                .isDetailLink(false)
            }
            
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onChange(of: model.isLoading) { newValue in
            if newValue {
                MyProgressView.show()
            }
            else {
                MyProgressView.hide()
            }
        }
        .onChange(of: model.concha) { newValue in
            index = 0
            offset = 0
            
            if newValue.ticks == nil {
                action = 1
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(rootActive: .constant(nil))
    }
}
