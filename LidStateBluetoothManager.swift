import IOKit
import IOKit.pwr_mgt
import Foundation
import IOBluetooth


class LidStateBluetoothManager {

    private var lastState: Bool?
    private var timer: Timer?

    func isLidClosed() -> Bool? {
        let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPMrootDomain"))
        guard service != 0 else {
            print("Failed to find IOPMrootDomain")
            return nil
        }
        defer { IOObjectRelease(service) }

        let key = "AppleClamshellState" as CFString
        guard let property = IORegistryEntryCreateCFProperty(service, key, kCFAllocatorDefault, 0)?.takeRetainedValue() else {
            print("Failed to get lid state")
            return nil
        }

        return (property as? NSNumber)?.boolValue
    }

    
    func disconnectAllBluetoothDevices() {
     guard let pairedDevices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] else {
        print("No paired devices found")
        return
     }
    
     for device in pairedDevices {
        if device.isConnected() {
            device.closeConnection()
            // print("Disconnected: \(device.name)")
        }
     }
}


    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkLidState()
        }
        RunLoop.current.add(timer!, forMode: .common)
        print("Monitoring lid state.")
    }

    private func checkLidState() {
        guard let currentState = isLidClosed() else {
            print("Failed to detect lid state")
            return
        }

        if lastState != currentState {

            if currentState == true {
                disconnectAllBluetoothDevices()
            }
            // print("Lid is now \(currentState ? "closed" : "open")")
            lastState = currentState
        }
    }
}


let monitor = LidStateBluetoothManager()
monitor.startMonitoring()


RunLoop.main.run()