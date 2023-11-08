//
//  RideRequestContentView.swift
//  Yuber
//
//  Created by Honnier on 7/11/23.
//

import SwiftUI


struct RideRequestContentView: View {
    @State var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.vertical,8)
            //header
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8, height: 8)
                }
                
                VStack{
                    HStack{
                        Text("Current location")
                            .frame(height: 32)
                            .padding(.trailing)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(locationViewModel.pickupTime ?? "searching..")
                            .frame(height: 32)
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom)
                    HStack{
                        if let location = locationViewModel.selectedRideLocation {
                            Text(location.title)
                                .frame(height: 32)
                                .padding(.trailing)
                                .foregroundColor(.gray)
                        }
                    
                        Spacer()
                        Text(locationViewModel.dropoffTime ?? "searching..")
                            .frame(height: 32)
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading,8)
            }
            .padding(.horizontal)
            
            Divider().padding(.vertical)
            
            //ride
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame( maxWidth: .infinity,  alignment: .leading)
            
            ScrollView(.horizontal){
                HStack (spacing:12){
                    ForEach(RideType.allCases,id: \.self){ ride in
                        VStack(alignment: .leading){
                            Image(ride.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading,spacing: 4){
                                Text(ride.description)
                                    .font(.system(size:14,weight: .semibold))
                                Text(locationViewModel.computeRideType(forType: ride).toCurrency())
                                    .font(.system(size:14,weight: .semibold))
                            }
                            .foregroundColor(ride == selectedRideType ? .white : Color.theme.primaryTextColor)
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .background(ride == selectedRideType ? Color(.systemBlue) : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(ride == selectedRideType ? 1.2 : 1.0 )
                        .cornerRadius(10)
                        .onTapGesture{
                            withAnimation(.spring()){
                                selectedRideType = ride
                            }
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
            
           //payment option
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height:50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical,8)
            
            //request ride button
            Button{}label:{
                Text("CONFIRM RIDE")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 50)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom,30)
            }
        }
        

    }
        
}

struct RideRequestContentView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestContentView()
    }
}
