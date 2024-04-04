//
//  NewContentView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/6/24.
//

import SwiftUI

struct ScheduleView: View {
    // Hardcoded employees for the example
    let employees = [
        Employee(name: "Alice", workDays: [.monday, .tuesday, .wednesday, .thursday,.saturday]),
        Employee(name: "Bob", workDays: [.wednesday, .thursday, .friday]),
    ]
    let shopOpenDays: Set<DayOfWeek> = [.monday, .tuesday, .wednesday, .thursday, .friday]
    
    var body: some View {
        ScrollView {
            MonthView(employees: employees, month: "January", shopOpenDays: shopOpenDays)
            MonthView(employees: employees, month: "February", shopOpenDays: shopOpenDays)
            // Add more months as needed
        }
    }
}


#Preview {
    ScheduleView()
}
