//
//  ContentView.swift
//  EmployeeExample3
//
//  Created by Nicholas Rios on 4/24/23.
//

import SwiftUI

class Employee {
    var name: String
    var id: String
   
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}
 
class HourlyEmployee: Employee {
    var hourlyRate: Double
    var hoursWorked: Double
   
    init(name: String, id: String, hourlyRate: Double, hoursWorked: Double) {
        self.hourlyRate = hourlyRate
        self.hoursWorked = hoursWorked
        super.init(name: name, id: id)
    }
   
    func calculatePay() -> Double {
        return hourlyRate * hoursWorked
    }
}
 
class SalariedEmployee: Employee {
    var salary: Double
    var bonus: Double
   
    init(name: String, id: String, salary: Double, bonus: Double) {
        self.salary = salary
        self.bonus = bonus
        super.init(name: name, id: id)
    }
    
    func calculatePay() -> Double {
        var monthlySalary = (salary + bonus) / 12.0
        return monthlySalary
    }
}
struct ContentView: View {
    @State private var name = ""
    @State private var id = ""
    @State private var hourlyRate = ""
    @State private var hoursWorked = ""
    @State private var salary = ""
    @State private var bonus = ""
    @State private var showPaymentAlert = false
    @State private var payment = ""
    
    var body: some View {
        VStack {
            Text("Employee Information")
                .font(.title)
                .padding()
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("ID", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Text("Hourly Employee")
                .font(.headline)
            
            HStack {
                TextField("Hourly Rate", text: $hourlyRate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Hours Worked", text: $hoursWorked)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Text("Salaried Employee")
                .font(.headline)
            
            HStack {
                TextField("Salary", text: $salary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Bonus", text: $bonus)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Button(action: {
                if var hourlyRate = Double(hourlyRate), var hoursWorked = Double(hoursWorked) {
                    /* HOURLY EMPLOYEE */
                    var employee = HourlyEmployee(name: name, id: id, hourlyRate: hourlyRate, hoursWorked: hoursWorked) // creating hourly employee object
                    var payment = employee.calculatePay() // calculates the pay for a hourly employee object and saves in payment var
                    self.showPaymentAlert = true // enables the popup

                    self.payment = String(format: "%.2f", payment) // formats the payment to two decimal places
                } else if var salary = Double(salary), var bonus = Double(bonus) {
                    /* SALARIED EMPLOYEE */
                    var employee = SalariedEmployee(name: name, id: id, salary: salary, bonus: bonus) // creating salaried employee object
                    var payment = employee.calculatePay() // calculates the pay for a salaried employee object
                    self.showPaymentAlert = true // enables the popup
                    self.payment = String(format: "%.2f", payment) // formats the payment to two decimal places
                }
            }) {
                Text("Calculate Payment")
                    .frame(width: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                    .imageScale(.medium)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                
            }
            .padding()
            .alert(isPresented: $showPaymentAlert) {
                Alert(
                    title: Text("Monthly Payment Information"),
                    message: Text("$\(payment)")
                )
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
