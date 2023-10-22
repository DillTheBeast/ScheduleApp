//
//  ContentView.swift
//  ScheduleApp
//
//  Created by Dillon Maltese on 10/19/23.
//

import SwiftUI
import Foundation
import Combine


struct ContentView: View {
    @State private var found = 0
    @State private var day = "";
    @State private var csvData: [[String]] = []
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    @State private var colorName1: String = ""
    @State private var colorName2: String = ""
    @State private var colorName3: String = ""
    @State private var colorName4: String = ""
    @State private var colorName5: String = ""
    
    @AppStorage("Red") var RedData: Data = Data()
    @AppStorage("Blue") var BlueData: Data = Data()
    @AppStorage("Green") var GreenData: Data = Data()
    @AppStorage("Yellow") var YellowData: Data = Data()
    @AppStorage("Pink") var PinkData: Data = Data()
    @AppStorage("Tan") var TanData: Data = Data()
    @AppStorage("Orange") var OrangeData: Data = Data()
    @AppStorage("Purple") var PurpleData: Data = Data()
    
    let dayA: [String] = ["Purple", "Pink", "Red", "Yellow", "Orange"]
    let dayB: [String] = ["Green", "Blue", "Tan", "Purple", "Pink"]
    let dayC: [String] = ["Yellow", "Red", "Orange", "Green", "Blue"]
    let dayD: [String] = ["Tan", "Purple", "Pink", "Red", "Yellow"]
    let dayE: [String] = ["Orange", "Green", "Blue", "Tan", "Purple"]
    let dayF: [String] = ["Pink", "Red", "Yellow", "Orange", "Green"]
    let dayG: [String] = ["Blue", "Tan", "Purple", "Pink", "Red"]
    let dayH: [String] = ["Yellow", "Orange", "Green", "Blue", "Tan"]
    
    @State var SelectedDate: Date = {
        let date = Date()
        return Calendar.current.date(byAdding: .day, value: 0, to: date)!
    }()
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: SelectedDate)
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text(formattedDate)
                    .foregroundColor(.white)
                Text("\(found)")
                    .foregroundColor(.white)
                Text("\(day)")
                    .foregroundColor(.white)
                // Create a box with the text and background color
                Text(colorName1 + "\n8:05 - 9:10")
                    .padding()
                    .background(colorFromName(name: colorName1))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                Text(colorName2)
                    .padding()
                    .background(colorFromName(name: colorName2))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName3)
                    .padding()
                    .background(colorFromName(name: colorName3))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName4)
                    .padding()
                    .background(colorFromName(name: colorName4))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName5)
                    .padding()
                    .background(colorFromName(name: colorName5))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility

                Button("Go to Next Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectedDate) {
                        SelectedDate = newDate
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Go to Previous Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: SelectedDate) {
                        SelectedDate = newDate
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
//                Button("Edit Colors") {
////                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectedDate) {
////                        SelectedDate = newDate
////                    }
//                    print("Test")
//                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .onAppear {
                fetchData()
            }
            .onChange(of: csvData) { _ in
                Schedule()
            }
        }
    }
    func fetchData() {
        let url = URL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vS3-6MgEPFUcHbLfa7q97_I6BI8CJvLZA0FDPxMwKOEFKYZs1GAw_4CRt6oOIWhMEITpOKzYrW2u7Ef/pub?gid=0&single=true&output=csv")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let csvString = String(data: data, encoding: .utf8) {
                let rows = csvString.components(separatedBy: "\n")
                DispatchQueue.main.async {
                    self.csvData = rows.map { $0.components(separatedBy: ",") }
                    // Optionally, you can call the Schedule() function here if needed:
                    self.Schedule()
                }
            }
        }.resume()
        
    }
    func Schedule() {
        for (index, row) in csvData.enumerated() {
            if let firstColumnValue = row.first, firstColumnValue == formattedDate {
                print("Match found in row!")
                found = index + 1
                day = csvData[found - 1][1]
                break
            }
        }
        if day == "dayA" {
            colorName1 = dayA[0]
            colorName2 = dayA[1]
            colorName3 = dayA[2]
            colorName4 = dayA[3]
            colorName5 = dayA[4]
        } else if day == "dayB" {
            colorName1 = dayB[0]
            colorName2 = dayB[1]
            colorName3 = dayB[2]
            colorName4 = dayB[3]
            colorName5 = dayB[4]
        } else if day == "dayC" {
            colorName1 = dayC[0]
            colorName2 = dayC[1]
            colorName3 = dayC[2]
            colorName4 = dayC[3]
            colorName5 = dayC[4]
        } else if day == "dayD" {
            colorName1 = dayD[0]
            colorName2 = dayD[1]
            colorName3 = dayD[2]
            colorName4 = dayD[3]
            colorName5 = dayD[4]
        } else if day == "dayE" {
            colorName1 = dayE[0]
            colorName2 = dayE[1]
            colorName3 = dayE[2]
            colorName4 = dayE[3]
            colorName5 = dayE[4]
        } else if day == "dayF" {
            colorName1 = dayF[0]
            colorName2 = dayF[1]
            colorName3 = dayF[2]
            colorName4 = dayF[3]
            colorName5 = dayF[4]
        } else if day == "dayG" {
            colorName1 = dayG[0]
            colorName2 = dayG[1]
            colorName3 = dayG[2]
            colorName4 = dayG[3]
            colorName5 = dayG[4]
        } else if day == "dayH" {
            colorName1 = dayH[0]
            colorName2 = dayH[1]
            colorName3 = dayH[2]
            colorName4 = dayH[3]
            colorName5 = dayH[4]
        }

        
    }
    func colorFromName(name: String) -> Color {
        switch name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
            case "purple":
                return Color.purple
            case "pink":
                return Color.pink
            case "red":
                return Color.red
            case "yellow":
                return Color.yellow
            case "orange":
                return Color.orange
            case "green":
                return Color.green
            case "blue":
                return Color.blue
            case "tan":
                return Color(UIColor.brown) // Assuming you want to use brown for tan
            // Add more cases as needed
            default:
                return Color.white // Default color if no match is found
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
