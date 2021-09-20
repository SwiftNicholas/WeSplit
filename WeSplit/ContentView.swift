//
//  ContentView.swift
//  WeSplit
//
//  Created by Nicholas Verrico on 9/19/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Input Properties
    
    // Must be string to handle text field
    @State private var checkAmount = ""
    
    // Minimum value of 2 set here
    @State private var numberOfPeople = 2
    
    // Default selected Tip to 15 percent
    @State private var selectedTipPercentage = 2
    
    // Standard tip percentages
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // MARK: - Calculations
    var currentTip: Double {return Double(tipPercentages[selectedTipPercentage])}
    var orderAmount: Double {return Double(checkAmount) ?? 0}
    var peopleCount: Double {return Double(numberOfPeople + 2)}
    var tipValue: Double {return (orderAmount/100) * currentTip }
    var total: Double {return orderAmount + tipValue}
    var totalPerPerson: Double {return total/peopleCount}
    
    
    // MARK: - BEGIN VIEW
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Check Amount
                // Input field for the amount of the meal
                Section(header: Text("Check amount")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                
                // MARK: - Tip Selection
                Section(header: Text("How much tip do you want to leave?")){
                    VStack{
                        Picker("Tip percentage", selection: $selectedTipPercentage){
                            ForEach(0..<tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        Picker("Tip amount", selection: $selectedTipPercentage){
                            
                            ForEach(0..<tipPercentages.count) {
                                let percentageValue = (orderAmount/100) * Double(tipPercentages[$0])
                                switch percentageValue {
                                case 0:
                                    Text("")
                                default:
                                    Text("$\(percentageValue, specifier: "%.2f")")
                                }
                                
                               
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                    }
                }
                
                // MARK: - Number of People
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                
                // MARK: - Total
                Section(header: Text("Grand Total")){
                    Text("$\(total, specifier: "%.2f")")
                }
                
                // MARK: - Per Person Split
                Section(header: Text("Amount owed per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
