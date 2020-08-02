import Foundation


struct Response<Body: Codable>: Codable {
    let response: Bodies<Body>
}

struct Bodies<Body: Codable>: Codable {
    let count: Int
    let items: [Body]
}

public struct Country: Codable {
    let id: Int
    let title: String
    var object: ObjCCountry { ObjCCountry(id: id, title: title) }
}

public struct City: Codable {
    let id: Int
    let title: String
    var object: ObjCCity { ObjCCity(id: id, title: title) }
}

public struct University: Codable {
    let id: Int
    let title: String
    var coordinates: SIMD2<Double>?
    var description: String?
    var address: String?
    var url: URL?
    mutating func insertYandex(part: Yandex.Feature) {
        coordinates = [part.geometry.coordinates[0], part.geometry.coordinates[1]]
        description = part.properties.description
        address = part.properties.CompanyMetaData.address
        url = URL(string: part.properties.CompanyMetaData.url)
    }
    var object: ObjCUniversity { ObjCUniversity(id: id, title: title) }
}

// Bridge to Objective-C

@objc public protocol ObjCCellModel {
    var subtitle: String { get }
    var title: String { get }
}


@objc public class ObjCCountry: NSObject, ObjCCellModel {
    @objc public let id: Int
    @objc public let title: String
    @objc public var subtitle: String = "COUNTRY"
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    @objc public func getTitle() -> String { title }
    @objc public func printTitle() { 
        print("title: \(title)")
    }
}

@objc public class ObjCCity: NSObject, ObjCCellModel {
    @objc public let id: Int
    @objc public let title: String
    @objc public var subtitle: String = "CITY"
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    @objc public func getTitle() -> String { title }
    @objc public func printTitle() { 
        print("title: \(title)")
    }
}

@objc public class ObjCUniversity: NSObject, ObjCCellModel {
    @objc public let id: Int
    @objc public let title: String
    @objc public var subtitle: String = "UNYVERSITY"
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    @objc public func getTitle() -> String { title }
}

// Yandex

struct Yandex {

    struct Response: Codable {
        let features: [Feature]
    }
    
    struct Feature: Codable {
        let geometry: Geometry
        let properties: Properties
    }
    
    struct Geometry: Codable {
        let coordinates: [Double]
    }
    
    struct Properties: Codable {
        let CompanyMetaData: Company
        let description: String
    }
    
    struct Company: Codable {
        let address: String
        let name: String
        let url: String
    }
    
}

