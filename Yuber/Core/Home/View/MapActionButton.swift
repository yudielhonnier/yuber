//
//  MapActionButton.swift
//  Yuber
//
//  Created by Honnier on 5/11/23.
//

import SwiftUI

struct MapActionButton: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel :LocationSearchViewModel
    
    var body: some View {
        Button{
            withAnimation(.spring()){
               actionForState(mapState )
            }
        }label:{
            Image(systemName:imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("DEBBUG: NO INPUT")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected ,.polylineAdded:
            mapState = .noInput
            viewModel.selectedRideLocation = nil
        }
    }
    
    func imageNameForState(_ state : MapViewState)-> String {
        switch state{
        case .noInput:
           return "line.3.horizontal"
        case .searchingForLocation,.locationSelected,.polylineAdded:
            return "arrow.left"
      
        }
    }
}

struct MapActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapActionButton(mapState: .constant(.noInput))
    }
}
