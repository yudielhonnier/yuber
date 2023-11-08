//
//  HomeView.swift
//  Yuber
//
//  Created by Honnier on 5/11/23.
//


import SwiftUI

struct HomeView: View {
    @State private var isOpen: Bool = false
    @State  var mapState : MapViewState = .noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState ==  .noInput {
                    LocationSearchActivationView()
                        .padding(.top,75)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                            
                        }}
                
                MapActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if mapState == .locationSelected  || mapState == .polylineAdded {
                RideRequestBottomSheetView(isOpen: $isOpen, maxHeight: 530)
                    .transition(.move( edge:.bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        }
    }   
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
