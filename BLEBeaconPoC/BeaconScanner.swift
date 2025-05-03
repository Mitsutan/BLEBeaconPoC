//
//  BeaconScanner.swift
//  BLEBeaconPoC
//
//  Created by Mitsutan on 2025/05/03.
//

import Foundation
import CoreBluetooth

class BeaconScanner: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    private var centralManager: CBCentralManager!
    
    public var isScanning: Bool = false
    
    let appUUID = UUID(uuidString: "E20A39F4-D50E-44D1-A716-110000000000")!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isScanning = true
            print("Bluetooth is powered on")
            
            let appUUIDData = withUnsafeBytes(of: appUUID.uuid) { Data($0) }
            
            centralManager.scanForPeripherals(withServices: [CBUUID(data: appUUIDData)], options: nil)
        } else {
            isScanning = false
            print("Bluetooth is not powered on")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown")")
        
        if let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
            print("Manufacturer Data: \(manufacturerData)")
            
            
        }
    }
    
    
    
    
}
