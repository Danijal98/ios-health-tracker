import CoreBluetooth
import SwiftUI

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var isBluetoothEnabled = false
    private var centralManager: CBCentralManager?

    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            self.isBluetoothEnabled = (central.state == .poweredOn)
        }
    }
}
