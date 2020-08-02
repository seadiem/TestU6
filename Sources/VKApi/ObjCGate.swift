import Foundation

public class FetchGate: NSObject {
    func run() {
        print("run")
    }
}

public struct TestGate {
    public init() {}
    public func run() {
        let gate = FetchGate()
        gate.run()
    }
}
