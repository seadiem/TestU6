import Foundation

public protocol FetcherDelegate {
    func countriesGot(countries: [Country])
    func citiesGot(cityes: [City])
    func universitiesGot(universities: [University])
    func universityInfoGot(university: University)
}

public class NetworkFetcher {
    let delegate: FetcherDelegate
    public init(delegate: FetcherDelegate) {
        self.delegate = delegate
    }
    public func getCountries() { // add handler
        VKApi().getCountries { countries in
            self.delegate.countriesGot(countries: countries)
        }
    }
    public func getCities(country: Country) {
//        VKApi().getCityies(country: <#T##Country#>)
    }
    public func getUniversities(country: Country, city: City) {
 //       VKApi().getUniversities(country: <#T##Country#>, city: <#T##City#>)
    }
    public func updateFromYandex(university: University) {
        YandexApi(university: university).getInfo { features in
            
        }
    }
}
