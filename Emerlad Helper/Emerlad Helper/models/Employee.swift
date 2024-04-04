//
//  Employee.swift
//  Emerlad Helper
//
//  Created by Natividad Michael Salinas II on 3/6/24.
//

import Foundation
import SwiftUI


struct Employee: Identifiable {
    var id: String { name }
    let name: String
    let workDays: Set<DayOfWeek> // Using a set for faster lookup
}

enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}
func firstDayOfWeekInMonth(month: String, year: Int) -> DayOfWeek {
    // This function should be implemented to return the actual first day of the week for the given month
    // For demonstration purposes, let's assume January 2024 starts on a Sunday
    return month == "January" ? .sunday : .monday
}

struct DayView: View {
    var day: Int
    var employees: [Employee]

    var body: some View {
        VStack {
            Text("\(day)")
                .font(.subheadline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(employees) { employee in
                        Text(employee.name)
                            .font(.system(size: 12)) // Make font size smaller if needed
                            .padding(.horizontal, 2)
                    }
                }
            }
        }
    }
}

struct MonthView: View {
    let employees: [Employee]
    var month: String
    let daysInMonth = 31 // Simplification for example
    let shopOpenDays: Set<DayOfWeek>

    // Define the columns for your grid. Adjust .flexible() for your desired appearance
    private let columns: [GridItem] = Array(repeating: .init(.flexible(minimum:30)), count: 7)

    var body: some View {
           VStack {
               Text(month)
                   .font(.headline)
               LazyVGrid(columns: columns, spacing: 20) {
                   // Generate the correct number of leading blank days for alignment
                   let firstDayOffset = DayOfWeek.allCases.firstIndex(of: firstDayOfWeekInMonth(month: month, year: 2024)) ?? 0
                   ForEach(0..<firstDayOffset, id: \.self) { _ in
                       Text("").frame(minHeight: 50) // Empty text for alignment
                   }
                   ForEach(1...daysInMonth, id: \.self) { day in
                       DayView(day: day, employees: employeesForDay(day: day)).frame(minHeight: 50)
                   }
               }
           }
       }
       
       // Adjust this function to calculate the correct day of the week based on the date
       func employeesForDay(day: Int) -> [Employee] {
           // This function should determine the actual day of the week for the given day and filter employees accordingly.
           // For demonstration, we just return all employees
           return employees
       }
}
