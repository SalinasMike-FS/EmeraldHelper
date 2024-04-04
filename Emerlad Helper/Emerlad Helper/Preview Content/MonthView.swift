//
//  MonthView.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/6/24.
//

import SwiftUI

struct lonthView: View {
    let employees: [Employee]
    var month: String
    let daysInMonth = 30 // Simplification for example
    let shopOpenDays: Set<DayOfWeek>

    var body: some View {
        VStack {
            Text(month)
                .font(.headline)
            ForEach(0..<daysInMonth, id: \.self) { day in
                DayView(day: day + 1, employees: employeesForDay(day: day + 1))
            }
        }
    }
    
    func employeesForDay(day: Int) -> [Employee] {
        // This is a simplification. You would need to calculate the actual day of the week for each day
        // and filter employees based on their workDays and your shopOpenDays.
        return employees.filter { $0.workDays.contains(.monday) } // Example logic
    }
}



