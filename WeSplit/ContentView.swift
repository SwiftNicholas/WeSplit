//
//  ContentView.swift
//  WeSplit
//
//  Created by Nicholas Verrico on 9/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    // Minimum value of 2 set here
    @State private var numberOfPeople = 2
    @State private var selectedTipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var tipSelectionValue: Double {return Double(tipPercentages[selectedTipPercentage])}
    
    var orderAmount: Double {return Double(checkAmount) ?? 0}
    var peopleCount: Double {return Double(numberOfPeople + 2)}
    var tipValue: Double {return (orderAmount/100) * tipSelectionValue }
    var total: Double {return orderAmount + tipValue}
    
    var totalPerPerson: Double {return total/peopleCount}
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Check amount")) {
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("How much tip do you want to leave?")){
                
                VStack{
                
                Picker("Tip percentage", selection: $selectedTipPercentage){
                    ForEach(0..<tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker("Tip amount", selection: $selectedTipPercentage){
                    ForEach(0..<tipPercentages.count) {_ in
                        Text("$\(tipValue, specifier: "%.2f")")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                }
            }
            Section {
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2 ..< 100){
                        Text("\($0) people")
                    }
                }
            }
            
            Section(header: Text("Grand Total")){
                Text("$\(total, specifier: "%.2f")")
            }
            
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
