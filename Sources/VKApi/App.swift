
// Тестовый Апп
public class App {
    
    
    public init() {

    }
    
    public func run() {
        VKApi().getCityies(country: Country(id: 2, title: "test")) { result in
            result.forEach { print("city: \($0)") }
        }
    }
}
