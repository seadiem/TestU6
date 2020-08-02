import Foundation

public class VKApiGate: NSObject {
    var selectedCountry: Country?
    var selectedCity: City?
    var selctedUniversity: University?
    
    public override init() {}
    @objc public func run() {
        print("vk gate run")
    }
    @objc public func getCountry() -> ObjCCountry {
        ObjCCountry(id: 10, title: "Albania")
    }
}
