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
}

public struct City: Codable {
    let id: Int
    let title: String
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

