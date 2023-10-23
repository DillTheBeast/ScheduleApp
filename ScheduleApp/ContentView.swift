//
//  ContentView.swift
//  ScheduleApp
//
//  Created by Dillon Maltese on 10/19/23.
//

import SwiftUI
import Foundation
import Combine

extension Color {
    static let hotPink = Color(red: 255.0/255.0, green: 105.0/255.0, blue: 180.0/255.0)
}

struct ContentView: View {
    @State private var editColorsScene: Bool = false
    
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
    
    @State private var savedRed: String = ""
    @State private var savedBlue: String = ""
    @State private var savedGreen: String = ""
    @State private var savedOrange: String = ""
    @State private var savedYellow: String = ""
    @State private var savedPurple: String = ""
    @State private var savedPink: String = ""
    @State private var savedTan: String = ""
    
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
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM dd"
        return formatter.string(from: SelectedDate)
    }
    
    //Getting all of the saved color data from last opening of app
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
                Text(colorName1 + "\n8:05 - 9:10")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorFromName(name: colorName1))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                Text(colorName2 + "\n9:15 - 10:20")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorFromName(name: colorName2))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName3 + "\n10:50 - 11:55")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorFromName(name: colorName3))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName4 + "\n12:50 - 2:10")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorFromName(name: colorName4))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility
                Text(colorName5 + "\n2:15 - 3:20")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(colorFromName(name: colorName5))
                    .cornerRadius(8)
                    .foregroundColor(.white) // Assuming text will be white for visibility

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
                Button("Edit Colors") {
                    if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: SelectedDate) {
                        SelectedDate = newDate
                   }
                    print("Test")
                }
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
            print(formattedDate)
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
                return Color.white // Default color if no match is found
        }
    }

}

struct editColors: View {
    @Binding var editColorsScene: Bool
    @State private var redWord: String = ""
    @State private var blueWord: String = ""
    @State private var greenWord: String = ""
    @State private var orangeWord: String = ""
    @State private var purpleWord: String = ""
    @State private var pinkWord: String = ""
    @State private var yellowWord: String = ""
    @State private var tanWord: String = ""
    
    @State private var filloutPopup = false
    @State var red: String = ""
    @State var blue: String = ""
    @State var green: String = ""
    @State var orange: String = ""
    @State var yellow: String = ""
    @State var purple: String = ""
    @State var pink: String = ""
    @State var tan: String = ""
    
    var body: some View {
        VStack {
            Text("Enter a Red Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Red Period", text: $redWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Blue Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Blue Period", text: $blueWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Green Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Green Period", text: $greenWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Orange Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Orange Period", text: $orangeWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Yellow Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Yellow Period", text: $yellowWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Purple Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Purple Period", text: $purpleWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Pink Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Pink Period", text: $pinkWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Text("Enter a Tan Period")
                .padding()
                .foregroundColor(.white)
            TextField("Enter a Tan Period", text: $tanWord)
                .padding()
                .border(Color.white, width: 1)
                .foregroundColor(.white)
            
            Button("Save Info") {
                if redWord.isEmpty || blueWord.isEmpty || greenWord.isEmpty || orangeWord.isEmpty || yellowWord.isEmpty || purpleWord.isEmpty || pinkWord.isEmpty || tanWord.isEmpty {
                    filloutPopup = true
                } else {
                    red = redWord
                    blue = blueWord
                    green = greenWord
                    orange = orangeWord
                    yellow = yellowWord
                    purple = purpleWord
                    pink = pinkWord
                    tan = tanWord
                    editColorsScene.toggle()
                }
            }
            .padding()
            .border(Color.white, width: 1)
            .foregroundColor(.white)
            
            Button("Go Back") {
                editColorsScene.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        if filloutPopup {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    // Close popup when background is tapped
                    filloutPopup = false
                }

            VStack(spacing: 20) {
                Text("You did not fill out all of the requirements")

                Button("Close") {
                    filloutPopup = false
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .frame(width: 300, height: 200)
            .background(Color.red)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
