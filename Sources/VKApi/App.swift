public class App {
    
    let delegate: Delegate
    let fetcher: NetworkFetcher
    
    public init() {
        delegate = Delegate()
        fetcher = NetworkFetcher(delegate: delegate)
    }
    
    public func run() {
        fetcher.getCountries()
        fetcher.getCities(country: delegate.countries![4])
        fetcher.getUniversities(country: delegate.countries![4], city: delegate.cityes![3])
        let university = delegate.university!
        print(university)
    }
}

class Delegate: FetcherDelegate {
    
    var countries: [Country]?
    var cityes: [City]?
    var universities: [University]?
    var university: University?
    
    func universityInfoGot(university: University) {
        self.university = university
    }
    func universitiesGot(universities: [University]) {
        self.universities = universities
    }
    func countriesGot(countries: [Country]) {
//        countries.forEach { print("country: \($0)") }
        self.countries = countries
    }
    func citiesGot(cityes: [City]) {
//        cityes.forEach { print("city: \($0)") }
        self.cityes = cityes
    }
}
