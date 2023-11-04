//
//  ContentView.swift
//  ScheduleApp
//
//  Created by Dillon Maltese on 10/19/23.
//

import SwiftUI
import Foundation
import Combine

//Making color for pink in rgb because normal pink is too close to red
extension Color {
    static let hotPink = Color(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0)
}

struct ContentView: View {
    @State private var editColorsScene: Bool = false
    
    @State private var found = 0
    @State private var day = "";
    @State private var csvData: [[String]] = []
    @State private var colorName1: String = ""
    @State private var colorName2: String = ""
    @State private var colorName3: String = ""
    @State private var colorName4: String = ""
    @State private var colorName5: String = ""
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    @AppStorage("Red") var RedData: Data = Data()
    @AppStorage("Blue") var BlueData: Data = Data()
    @AppStorage("Green") var GreenData: Data = Data()
    @AppStorage("Yellow") var YellowData: Data = Data()
    @AppStorage("Pink") var PinkData: Data = Data()
    @AppStorage("Tan") var TanData: Data = Data()
    @AppStorage("Orange") var OrangeData: Data = Data()
    @AppStorage("Purple") var PurpleData: Data = Data()
    
    @State private var savedRed: String = ""
    @State private var savedBlue: String = ""
    @State private var savedGreen: String = ""
    @State private var savedOrange: String = ""
    @State private var savedYellow: String = ""
    @State private var savedPurple: String = ""
    @State private var savedPink: String = ""
    @State private var savedTan: String = ""
    
    //Schedule in days using variables of what period you have for each color
    var dayA: [String] {
        return [savedPurple, savedPink, savedRed, savedYellow, savedOrange]
    }
    var dayB: [String] {
        return [savedGreen, savedBlue, savedTan, savedPurple, savedPink]
    }
    var dayC: [String] {
        return [savedYellow, savedRed, savedOrange, savedGreen, savedBlue]
    }
    var dayD: [String] {
        return [savedTan, savedPurple, savedPink, savedRed, savedYellow]
    }
    var dayE: [String] {
        return [savedOrange, savedGreen, savedBlue, savedTan, savedPurple]
    }
    var dayF: [String] {
        return [savedPink, savedRed, savedYellow, savedOrange, savedGreen]
    }
    var dayG: [String] {
        return [savedBlue, savedTan, savedPurple, savedPink, savedRed]
    }
    var dayH: [String] {
        return [savedYellow, savedOrange, savedGreen, savedBlue, savedTan]
    }
    
    //Schedule in days using Strings with the word of each color
    var DayA: [String] = ["Purple", "Pink", "Red", "Yellow", "Orange"]
    var DayB: [String] = ["Green", "Blue", "Tan", "Purple", "Pink"]
    var DayC: [String] = ["Yellow", "Red", "Orange", "Green", "Blue"]
    var DayD: [String] = ["Tan", "Purple", "Pink", "Red", "Yellow"]
    var DayE: [String] = ["Orange", "Green", "Blue", "Tan", "Purple"]
    var DayF: [String] = ["Pink", "Red", "Yellow", "Orange", "Green"]
    var DayG: [String] = ["Blue", "Tan", "Purple", "Pink", "Red"]
    var DayH: [String] = ["Yellow", "Orange", "Green", "Blue", "Tan"]
    
    //Getting the date selected
    @State var SelectedDate: Date = {
        let date = Date()
        return Calendar.current.date(byAdding: .day, value: 0, to: date)!
    }()
    
    //Getting the date to compare to the datasheet
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: SelectedDate)
    }
    //Geting the date to display nicely
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM dd"
        return formatter.string(from: SelectedDate)
    }

    var currentDaySchedule: [String] {
        switch day {
        case "dayA":
            return DayA
        case "dayB":
            return DayB
        case "dayC":
            return DayC
        case "dayD":
            return DayD
        case "dayE":
            return DayE
        case "dayF":
            return DayF
        case "dayG":
            return DayG
        case "dayH":
            return DayH
        default:
            return [] // Default to an empty list if no match is found
        }
    }

    init() {
        if let savedRed = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Red") ?? Data()) {
            RedData = UserDefaults.standard.data(forKey: "Red") ?? Data()
        }
        if let savedBlue = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Blue") ?? Data()) {
            BlueData = UserDefaults.standard.data(forKey: "Blue") ?? Data()
        }
        if let savedGreen = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Green") ?? Data()) {
            GreenData = UserDefaults.standard.data(forKey: "Green") ?? Data()
        }
        if let savedOrange = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Orange") ?? Data()) {
            OrangeData = UserDefaults.standard.data(forKey: "Orange") ?? Data()
        }
        if let savedTan = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Tan") ?? Data()) {
            TanData = UserDefaults.standard.data(forKey: "Tan") ?? Data()
        }
        if let savedPurple = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Purple") ?? Data()) {
            PurpleData = UserDefaults.standard.data(forKey: "Purple") ?? Data()
        }
        if let savedPink = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Pink") ?? Data()) {
            PinkData = UserDefaults.standard.data(forKey: "Pink") ?? Data()
        }
        if let savedYellow = try? JSONDecoder().decode([String].self, from: UserDefaults.standard.data(forKey: "Yellow") ?? Data()) {
            YellowData = UserDefaults.standard.data(forKey: "Yellow") ?? Data()
        }

    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text(displayDate)
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                Text("\(day)")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                // Create a box with the text and background color
                display()

                Button("Go to Next Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectedDate) {
                        SelectedDate = newDate
                        Schedule()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Go to Previous Day") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: SelectedDate) {
                        SelectedDate = newDate
                        Schedule()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            fetchData()
        }
        .onChange(of: csvData) { _ in
            Schedule()
        }
        .background(Color.black)
    }
    func display() -> some View {
        List(0..<currentDaySchedule.count, id: \.self) { index in
            HStack {
                Spacer() // This spacer will push the content to the center
                Text(currentDaySchedule[index])
                    .font(.system(size: 35))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 30) // Add vertical padding to fill the space
                Spacer() // This spacer will keep the content in the center
            }
            .background(self.colorFromName(name: currentDaySchedule[index]))
            .listRowInsets(EdgeInsets()) // Removes default padding from list row
            .listRowBackground(self.colorFromName(name: currentDaySchedule[index])) // Color the entire row
        }
        .listStyle(.plain)
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
        var foundMatch = false
        for (index, row) in csvData.enumerated() {
            if let firstColumnValue = row.first, firstColumnValue == formattedDate {
                foundMatch = true
                found = index + 1
                day = csvData[found - 1][1]
                break
            }
        }

        if !foundMatch {
            // Handle the case where no schedule data is available for the selected date
            day = "No Schedule Available"
        }
        if day == "dayA" {
            colorName1 = DayA[0]
            colorName2 = DayA[1]
            colorName3 = DayA[2]
            colorName4 = DayA[3]
            colorName5 = DayA[4]
        } else if day == "dayB" {
            colorName1 = DayB[0]
            colorName2 = DayB[1]
            colorName3 = DayB[2]
            colorName4 = DayB[3]
            colorName5 = DayB[4]
        } else if day == "dayC" {
            colorName1 = DayC[0]
            colorName2 = DayC[1]
            colorName3 = DayC[2]
            colorName4 = DayC[3]
            colorName5 = DayC[4]
        } else if day == "dayD" {
            colorName1 = DayD[0]
            colorName2 = DayD[1]
            colorName3 = DayD[2]
            colorName4 = DayD[3]
            colorName5 = DayD[4]
        } else if day == "dayE" {
            colorName1 = DayE[0]
            colorName2 = DayE[1]
            colorName3 = DayE[2]
            colorName4 = DayE[3]
            colorName5 = DayE[4]
        } else if day == "dayF" {
            colorName1 = DayF[0]
            colorName2 = DayF[1]
            colorName3 = DayF[2]
            colorName4 = DayF[3]
            colorName5 = DayF[4]
        } else if day == "dayG" {
            colorName1 = DayG[0]
            colorName2 = DayG[1]
            colorName3 = DayG[2]
            colorName4 = DayG[3]
            colorName5 = DayG[4]
        } else if day == "dayH" {
            colorName1 = DayH[0]
            colorName2 = DayH[1]
            colorName3 = DayH[2]
            colorName4 = DayH[3]
            colorName5 = DayH[4]
        }

        
    }
    func colorFromName(name: String) -> Color {
        switch name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
            case "purple":
                return Color.purple
            case "pink":
                return Color.hotPink
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
                return Color.black // Default color if no match is found
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
