import Foundation

public class FetchGate: NSObject {
    public func run() {
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
