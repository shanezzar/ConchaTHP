//
//  ResultView.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 31/03/2022.
//

import SwiftUI

struct ResultView: View {
    
    // MARK: - Observed Variables
    
    @EnvironmentObject var model: ViewModel
    
    @Binding var rootActive: Int?
    
    
    // MARK: - Variables
    
    var result: [[Int:Int]]
    
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("Slider Results")
                .font(Font.custom(CustomFont.sofiaProSemiBold, size: 23))
                .multilineTextAlignment(.center)
                .foregroundColor(.titleColor)
            
            ForEach(result.indices, id: \.self) { i in
                HStack(spacing: 16) {
                    Spacer()
                    Text("Slider \(i + 1): ")
                        .font(Font.custom(CustomFont.sofiaProSemiBold, size: 18))
                        .foregroundColor(.titleColor)
                    
                    ForEach(Array(result[i].keys), id: \.self) { j in
                        Text(j.description)
                            .font(Font.custom(CustomFont.sofiaProMedium, size: 15))
                            .foregroundColor(.titleColor)
                        
                        Text(result[i][j]!.description)
                            .font(Font.custom(CustomFont.sofiaProMedium, size: 15))
                            .foregroundColor(.titleColor)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            Button {
                haptic()
                MyProgressView.show()
                model.fetch(for: .start, ["choice": "start"])
            } label: {
                Text("Start over")
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 18))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.appYellow)
                    .cornerRadius(32)
            }
            
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onChange(of: model.concha) { newValue in
            if newValue.ticks != nil {
                MyProgressView.hide()
                rootActive = 0
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(rootActive: .constant(nil), result: [[:]])
    }
}
