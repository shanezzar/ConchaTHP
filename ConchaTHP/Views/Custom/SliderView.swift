//
//  SliderView.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 29/03/2022.
//

import SwiftUI

struct SliderView: View {
    
    // MARK: - Observed Variables
    
    @Binding var offset: CGFloat
    @Binding var index: Int
    
    
    // MARK: - Variables
    
    var height: CGFloat = UIScreen.main.bounds.height/2
    var count: Int
    
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Capsule()
                .fill(.gray.opacity(0.5))
                .frame(width: 36)
            
            Capsule()
                .fill(Color.appYellow)
                .frame(width: 36, height: -offset)
            
            VStack(spacing: (height - 78)/CGFloat(count)) {
                ForEach(0..<count, id: \.self) { index in
                    Circle()
                        .fill(.white)
                        .frame(width: index % 6 == 0 ? 12 : 6, height: index % 6 == 0 ? 12 : 6)
                }
            }
            
            Circle()
                .fill(.white)
                .frame(width: 36, height: 36)
                .background(Circle().stroke(Color.appYellow.opacity(0.5), lineWidth: 36))
                .offset(y: offset + 18)
                .gesture(DragGesture().onChanged({ value in
                    if value.location.y <= 18 && value.location.y >= -(height - 18) {
                        offset = value.location.y - 18
                    }
                }))
                .onChange(of: offset) { _ in
                    calculateIndex()
                }
        }
        .frame(height: height)
        
        Spacer()
        
        VStack(spacing: 36) {
            Button {
                haptic()
                let max = (count - 1)
                index = index == max ? max : index + 1
                calculateOffset()
            } label: {
                Image(systemName: "chevron.up")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.appYellow)
                    .frame(width: 18, height: 18, alignment: .center)
                    .padding()
                    .background(.white)
                    .cornerRadius(24)
                    .shadow(color: .titleColor.opacity(0.15), radius: 16, x: 0, y: -8)
            }
            
            Button {
                haptic()
                index = index == 0 ? 0 : index - 1
                calculateOffset()
            } label: {
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.appYellow)
                    .frame(width: 18, height: 18, alignment: .center)
                    .padding()
                    .background(.white)
                    .cornerRadius(24)
                    .shadow(color: .titleColor.opacity(0.15), radius: 16, x: 0, y: 8)
            }
        }
    }
}

extension SliderView {
    
    // MARK: - Methods
    
    func calculateIndex() {
        let percent = offset/(height - 18)
        let index = floor(CGFloat((count - 1)) * abs(percent))
        self.index = Int(index)
    }
    
    func calculateOffset() {
        let screen = (height + 18)/CGFloat(count)
        offset = -screen * CGFloat(index)
    }
}
