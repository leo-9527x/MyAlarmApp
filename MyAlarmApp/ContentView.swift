//
//  ContentView.swift
//  MyAlarmApp
//
//  Created by Leo on 7/25/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var alarmDate = Date()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                print("Notification access granted")
            } else {
                print("Notification access denied")
            }
        }
    }

    var body: some View {
        VStack {
            DatePicker("Set Alarm", selection: $alarmDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
            
            Button("Set Alarm") {
                scheduleAlarm()
            }
        }
    }
    
    func scheduleAlarm() {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Wake up!"
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents([.hour,.minute,], from: alarmDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

