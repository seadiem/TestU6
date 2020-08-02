import Foundation

@objc public protocol VKApiGateDelegate {
    func newDataGotAndNeedDisplay()
    func universityInfoGot()
} 

@objc public class VKApiGate: NSObject {
    
    let controller: VKApiGateDelegate
    public weak var searchController: VKApiGateDelegate? 
    
    var selectedCountry: Country?
    var selectedCity: City?
    var selectedUniversity: University?
    
    var countrues: [Country]
    var cities: [City]
    var universities: [University]
    
    var flow: Flow
    
    @objc public init(controller: VKApiGateDelegate) {
        self.controller = controller
        countrues = []
        cities = []
        universities = []
        flow = .countries
        super.init()
    }
    
    @objc public func initialSearch() {
        loadCountries()
    }
    
    @objc public func getSearchScreenCount() -> Int {
        switch flow {
        case .countries: return countrues.count
        case .cities: return cities.count
        case .universities: return universities.count
        }
    }
    
    @objc public func getSearchScreenModel(at index: Int) -> ObjCCellModel {
        switch flow {
        case .countries: return countrues[index].object
        case .cities: return cities[index].object
        case .universities: return universities[index].object
        }
    }
    
    @objc public func getCellMainScreen(at index: Int) -> ObjCCellModel {
        switch index {
        case 0:
            if let selected = selectedCountry { return selected.object } 
            else { return ObjCCountry(id: 0, title: "~") }
        case 1:
            if let selected = selectedCity { return selected.object } 
            else { return ObjCCity(id: 0, title: "~") }
        case 2:
            if let selected = selectedUniversity { return selected.object } 
            else { return ObjCUniversity(id: 0, title: "~") }
        default: 
            return ObjCCountry(id: 0, title: "Empty")
        }
    }
    
    @objc func tapInMainControllerAt(number: Int) {
        print("tap with number: \(number)")
        switch number {
        case 0: 
            loadCountries()
            flow = .countries
        case 1: 
            loadCityes()
            flow = .cities
        case 2: 
            loadUniversityes()
            flow = .universities
        default: break
        }
    }
    
    @objc func tapInSearchController(number: Int) {
        switch flow {
        case .countries: 
            guard countrues.isEmpty == false else { return }
            selectedCountry = countrues[number]
        case .cities:
            guard cities.isEmpty == false else { return }
            selectedCity = cities[number]
        case .universities:
            guard universities.isEmpty == false else { return }
            selectedUniversity = universities[number]
        }
        controller.newDataGotAndNeedDisplay()
    }
    
    func loadCountries() {
        print("load countries")
        VKApi().getCountries { countries in
            self.countrues = countries
            self.controller.newDataGotAndNeedDisplay()
            self.searchController?.newDataGotAndNeedDisplay()
            if countries.isEmpty == false && self.selectedCountry == nil {
                self.selectedCountry = countries[0]
            }
        }
    }
    
    func loadCityes() {
        print("load cityes")
        guard let country = selectedCountry else {
            print("no selected country")
            return 
        }
        VKApi().getCityies(country: country) { cities in
            cities.forEach { print("city: \($0)") }
            self.cities = cities
            self.controller.newDataGotAndNeedDisplay()
            self.searchController?.newDataGotAndNeedDisplay()
        }
    }
    
    func loadUniversityes() {
        guard let country = selectedCountry, let city = selectedCity else { return }
        VKApi().getUniversities(country: country, city: city) { universities in
            self.universities = universities
            self.controller.newDataGotAndNeedDisplay()
            self.searchController?.newDataGotAndNeedDisplay()
        }
    }
    
    @objc public func testRun() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500)) { 
            self.controller.newDataGotAndNeedDisplay()
        }
    }
    
    @objc public func throwToDetails() {
        
        guard var university = selectedUniversity else { return }
        print("university: \(university)")
        YandexApi(university: university).getInfo { feature in
            university.insertYandex(part: feature)
            print("inserted, university: \(university)")
            self.controller.universityInfoGot()
        }
    }
}
