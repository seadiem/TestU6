import Foundation

public struct VKApi {
    
    enum Metods: String {
        case countries = "database.getCountries"
        case cities = "database.getCities"
        case universities = "database.getUniversities"
    }
    
    public init() {}
    let accessToken = "e722fa0de722fa0de722fa0d52e751b3acee722e722fa0db807d5d5bc3ad0befbb05436"
    var begin: String { "https://api.vk.com/method/" }
    var end: String { "access_token=" + accessToken + "&" + "v=5.122" }
    var getCountriesURL: String { 
        begin + Metods.countries.rawValue + "?" + "need_all=1" + "&" + end 
    }
    func getCitiesURL(country: Country) -> String {
        begin + Metods.cities.rawValue + "?" + "country_id=\(country.id)" + "&" + "need_all=1" + "&" + end 
    }
    func getCitiesURL(country: Int) -> String {
        begin + Metods.cities.rawValue + "?" + "country_id=\(country)" + "&" + "need_all=0" + "&" + "offset=0" + "&" + "count=100" + "&" + end 
    }
    func getUniversitiesURL(country: Country, city: City) -> String {
        begin + Metods.universities.rawValue + "?" + "country_id=\(country.id)" + "&" + "city_id=\(city.id)" + "&" + "need_all=0" + "&" + end 
    }
    func getCountries(handler: @escaping ([Country]) -> Void) {
        let url = URL(string: getCountriesURL)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(Response<Country>.self, from: data!)
                handler(response.response.items)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    public func getCityies(country: Country, handler: @escaping ([City]) -> Void) {
        let url = URL(string: getCitiesURL(country: country))!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(Response<City>.self, from: data!)
                handler(response.response.items)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    public func getUniversities(country: Country, city: City, handler: @escaping ([University]) -> Void) {
        let url = URL(string: getUniversitiesURL(country: country, city: city))!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(Response<University>.self, from: data!)
                handler(response.response.items)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    public func checkApi() {
    }
}
