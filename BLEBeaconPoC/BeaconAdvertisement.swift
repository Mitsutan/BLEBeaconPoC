//
//  BeaconAdvertisement.swift
//  BLEBeaconPoC
//
//  Created by Mitsutan on 2025/05/03.
//

import Foundation
import CoreBluetooth

class BeaconAdvertisement: NSObject, CBPeripheralManagerDelegate {
    
    private var peripheralManager: CBPeripheralManager!
    
    let appUUID = UUID(uuidString: "E20A39F4-D50E-44D1-A716-110000000000")!
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("Peripheral manager is powered on.")
        }
    }
    
    func startAdvertising(userId: String) -> Bool {
        
        guard peripheralManager.state == .poweredOn else {
            print("Peripheral manager is not powered on.")
            return false
        }
        
        let appUUIDData = withUnsafeBytes(of: appUUID.uuid) { Data($0) }
        
        var advertisementData: [String: Any] = [
            CBAdvertisementDataManufacturerDataKey: [CBUUID(string: userId)],
            CBAdvertisementDataServiceUUIDsKey: appUUIDData
        ]
        
        advertisementData[CBCentralManagerScanOptionAllowDuplicatesKey as String] = true
        
        
        peripheralManager.startAdvertising(advertisementData)
        return true
    }
        
}
