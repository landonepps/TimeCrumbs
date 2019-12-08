//
//  HomeView.swift
//  TimeCrumbs
//
//  Created by Landon Epps on 12/6/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit
import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            Card()
            Card()
            Card()
        }
        .background(Color("backgroundColor"))
    }
}

struct Card: View {
    
    @State var expanded = true
    @State var logTime = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("cellColor"))
                .cornerRadius(24, corners: [.topRight, .bottomRight])
                .shadow(color: Color("shadowColor"), radius: 5, x: 0, y: 5)
            HStack(spacing: 0) {
                Rectangle()
                    .frame(width: 30)
                    .foregroundColor(Color("wheat"))
                VStack(spacing: 4) {
                    HStack {
                        Text("Project 1")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        Spacer()
                    }
                    
                    if expanded {
                        TimerView()
                    } else {
                        ButtonView()
                    }
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.top, 6)
                Spacer()
            }
        }
//        .frame(height: expanded ? 400 : 140)
        .padding(.horizontal)
        .padding(.vertical, 6)
        .gesture(
            TapGesture()
                .onEnded {
                    self.expanded.toggle()
                }
        )
    }
}

struct ButtonView: View {
    var body: some View {
        HStack(spacing: 24) {
            Spacer()
            CircleButton(color: "wheat", icon: "plus", label: "LOG TIME")
            CircleButton(color: "wheat", icon: "clock", label: "START")
        }
        .padding(.trailing, 24)
    }
}

struct TimerView: View {
    @State private var taskName = ""
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(Color("lightWheat"))
                .frame(width: 170, height: 170, alignment: .center)
            HStack {
                CircleButton(color: "wheat", text: "Finish")
                Spacer()
                CircleButton(color: "wheat", text: "Resume")
            }
            .padding(.horizontal, 20)
            TextField("Task Name", text: $taskName)
                .padding()
            CircleButton(color: "wheat", text: "Save")
        }
    }
}


//struct LogTimeView: View {
//    @State private var name: String = ""
//    @State private var duration: String = ""
//    @State private var dateText = ""
//    @State private var showDatePicker = true
//    @State private var date = Date()
//
//    var body: some View {
//        VStack(spacing: 12) {
//            TextField("Placeholder", text: $name)
//            TextField("Duration", text: $duration)
//            TextField("Date", text: $dateText, onEditingChanged: { editing in
//                self.showDatePicker = editing
//            })
//            if showDatePicker {
//                DatePicker(selection: $date, displayedComponents: .date) {
//                    Text("Date")
//                }
//                .frame(width: 100, height: 100)
//             }
//        }
//        .padding(.top, 8)
//    }
//}

// Button

struct CircleButton: View {
    var color = "wheat"
    var icon = ""
    var text = ""
    var label = ""
    
    var body: some View {
        VStack(spacing: 6) {
            Button(action: { }) {
                ZStack {
                    Image("smallButton")
                        .foregroundColor(Color(color))
                    if !icon.isEmpty {
                        Image(icon)
                            .foregroundColor(Color.white)
                        
                    }
                    if !text.isEmpty {
                        Text(text)
                            .font(.system(size: 13))
                            .foregroundColor(Color.white)
                    }
                }
            }
            if !label.isEmpty {
                Text(label)
                    .font(.system(size: 16))
                    .fontWeight(.light)
            }
        }
    }
}

// MARK: - Preview

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            HomeView()
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(0)
        }
        .environment(\.colorScheme, .dark)
    }
}

// MARK: - Rounded Corners

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
