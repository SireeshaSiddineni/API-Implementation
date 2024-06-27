//
//  MacBookView.swift
//  MacBookInfoAPI
//
//  Created by Sireesha Siddineni on 26/06/24.
//

import SwiftUI

struct MacBookView: View {
    @StateObject private var viewModel = MacBookViewModel()
    @State private var macBookId = "7"  // Working ID is 7 and for error message Id is 6
    
    var body: some View {
        VStack {
            TextField("Enter MacBook ID", text: $macBookId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.fetchMacBook(id: macBookId)
            }) {
                Text("Fetch Details")
            }
            .padding()
            
            if let macBook = viewModel.macBook {
                VStack(alignment: .leading) {
                    Text("ID: \(macBook.id)")
                    Text("Name: \(macBook.name)")
                    Text("Year: \(macBook.data.year)")
                    Text("Price: $\(macBook.data.price, specifier: "%.2f")")
                        .foregroundColor(.green)
                    Text("CPU Model: \(macBook.data.cpuModel)")
                    Text("Hard Disk Size: \(macBook.data.hardDiskSize)")
                        .foregroundColor(.blue)
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Enter a MacBook ID and tap on Fetch Details")
                    .padding()
            }
        }
        .padding()
    }
}

struct MacBookView_Previews: PreviewProvider {
    static var previews: some View {
        MacBookView()
    }
}
