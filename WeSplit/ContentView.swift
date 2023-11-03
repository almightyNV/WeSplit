//
//  ContentView.swift
//  WeSplit
//
//  Created by Nishant Vilkar on 01/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(noOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipAmount = (checkAmount/100) * tipSelection
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        
        let total = checkAmount + ((checkAmount/100)*Double(tipPercentage))
        
        return total
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.numberPad)
                    .focused($amountIsFocused)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                    
                Picker("Number of People", selection: $noOfPeople) {
                    ForEach(2..<51) {
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section("Total Bill Amount") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .backgroundStyle(.orange)
        }
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
