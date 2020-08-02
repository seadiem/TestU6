import Foundation
import VKApi

struct Runner {
    
    func runListener() {
        var command = ""
        while command != "end" {
            print("input command:")
            guard let line = readLine() else { continue }
            command = line
        }
        print("end commands")
    }
    
    func run() { 
//        let app = App() // Эта функция никогда не завершается, поэтому инстанс App всегда находится в памяти
//        app.run()
        runListener()
    }
}
