//
//  RideRequestView.swift
//  Yuber
//
//  Created by Honnier on 6/11/23.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 1
}

struct RideRequestBottomSheetView: View {
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    let maxHeight: CGFloat
    let minHeight: CGFloat
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    //MARK: LIFECYCLE
    init(isOpen: Binding<Bool>, maxHeight: CGFloat) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self._isOpen = isOpen
    }
    
    
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                RideRequestContentView()
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    withAnimation {
                        state = value.translation.height
                    }
                    
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
            
        }
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestBottomSheetView(isOpen: .constant(true), maxHeight: 50)
    }
}
