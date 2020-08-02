import Foundation

struct YandexApi {
    let apikey = "5ddcba5c-de63-4d19-857f-8649f2af08b7"
    let begin = "https://search-maps.yandex.ru/v1/"
    let name: String
    var ansiname: String { name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! }
    var string: String { begin + "?" + "apikey=\(apikey)" + "&" + "text=\(ansiname)" + "&" + 
                        "lang=ru_RU" + "&" + "format=json" + "&" + "type=biz" + "&" + "results=1" }
    
    init(university: University) {
        name = university.title 
    }
    func getInfo(handler: @escaping (Yandex.Feature) -> Void) {
        print(ansiname)
        let url = URL(string: string)!
        print(url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let response = try JSONDecoder().decode(Yandex.Response.self, from: data!)
                guard response.features .isEmpty == false else { return }
                handler(response.features[0])
            } catch let error {
                print(error)
            }
//            ParseHardYandexResponse().explore(response: data!)
        }.resume()
    }
    
}

struct ParseHardYandexResponse {
    
    func explore(response: Data) {
        do {
            let z = try JSONSerialization.jsonObject(with: response)
            if let t = z as? [String: Any] {
                t.keys.forEach { print("key: \($0)") }
                if let features = t["features"] as? [Any] {
                    features.forEach { print("feature: \($0)") }
                }                
            }
        } catch let error {
            print(error)
        }
    }
    
    
}
