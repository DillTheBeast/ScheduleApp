//
//  ContentView.swift
//  ScheduleApp
//
//  Created by Dillon Maltese on 10/19/23.
//

import SwiftUI
import Foundation


struct ContentView: View {
    let currentDate = Date()
    @AppStorage("Red") var RedData: Data = Data()
    @AppStorage("Blue") var BlueData: Data = Data()
    @AppStorage("Green") var GreenData: Data = Data()
    @AppStorage("Yellow") var YellowData: Data = Data()
    @AppStorage("Pink") var PinkData: Data = Data()
    @AppStorage("Tan") var TanData: Data = Data()
    @AppStorage("Orange") var OrangeData: Data = Data()
    @AppStorage("Purple") var PurpleData: Data = Data()
    
    //let dayA: [String] = ["Purple", "Pink", "Red", "Yellow", "Orange"]
    //let dayB: [String] = ["Green", "Blue", "Tan", "Purple", "Pink"]
    var dayA: [Data] { [PurpleData, PinkData, RedData, YellowData, OrangeData] }
    var dayB: [Data] { [GreenData, BlueData, TanData, PurpleData, PinkData] }
    var dayC: [Data] { [YellowData, RedData, OrangeData, GreenData, BlueData] }
    var dayD: [Data] { [TanData, PurpleData, PinkData, RedData, YellowData] }
    var dayE: [Data] { [OrangeData, GreenData, BlueData, TanData, PurpleData] }
    var dayF: [Data] { [PinkData, RedData, YellowData, OrangeData, GreenData] }
    var dayG: [Data] { [BlueData, TanData, PurpleData, PinkData, RedData] }
    var dayH: [Data] { [YellowData, OrangeData, GreenData, BlueData, TanData] }
    
    @State var tomorrow: Date = {
            let date = Date()
            return Calendar.current.date(byAdding: .day, value: 0, to: date)!
        }()
    
    var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: tomorrow)
        }
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text(formattedDate)
                    .foregroundColor(.white)
                Button("Go to Next Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: tomorrow) {
                        tomorrow = newDate
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Go to Previous Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: tomorrow) {
                        tomorrow = newDate
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                //            List(watched.indices, id: \.self) { index in
                //                Button(action: {
                //                    watchedSelect = watched[index]
                //                    releaseSelect = release[index]
                //                    releaseScene = true  // Toggle to show the ViewInfo scene
                //                    watchedScene = false  // Close the ViewAccount scene
                //                }) {
                //                    Text(watched[index])
                //                        .foregroundColor(.white)  // set the text color to white
                //                        .frame(maxWidth: .infinity, minHeight: 44)  // taking the full width and a minimum height
                //                        .border(Color.black)
                //                        .background(Color.black)  // set the row background to black
                //}
                //}
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
