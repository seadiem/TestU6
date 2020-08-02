import MapKit
import Dispatch

struct MapWork {
    var search: MKLocalSearch? 
    mutating func searchCoordinates(name: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55, longitude: 37), 
                                            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        search = MKLocalSearch(request: request)
        print("searching")
        search?.start { (response, error) in
            print("search done")
            print("response: \(response as Any)")
            print("error: \(error as Any)")
        }
    }
}
