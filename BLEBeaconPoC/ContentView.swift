//
//  ContentView.swift
//  BLEBeaconPoC
//
//  Created by Mitsutan on 2025/05/03.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var beaconScanner = BeaconScanner()
    @State private var isAdvertising: Bool = false
    
    private let beaconAdvertisement = BeaconAdvertisement()
    
    var body: some View {
        VStack {
            Text("スキャン状態:" + (beaconScanner.isScanning ? "ON" : "OFF"))
            Text("アドバタイズ状態:" + (isAdvertising ? "ON" : "OFF"))
            
            Button(action: {
                isAdvertising = beaconAdvertisement.startAdvertising(userId: UUID.init().uuidString)
            }) {
                Text("アドバタイズ")
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
