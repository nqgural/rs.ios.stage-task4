import Foundation

public extension Int {
    
    var roman: String? {
        if (self<=0 || self>3999) {return nil}
        
        var num = self
        let numbers: [Int: String] = [
            1000: "M",
            900: "CM",
            500: "D",
            400: "CD",
            100: "C",
            90: "XC",
            50: "L",
            40: "XL",
            10: "X",
            9: "IX",
            5: "V",
            4: "IV",
            1: "I",
        ]
        var result = String()
        let keysArray = Array(numbers.keys).sorted { $0 > $1  }
        
        repeat {
            for key in keysArray {
                    if (num - key >= 0) {
                        result += String(numbers[key]!)
                        num -= key
                        break
                    }
            }
        } while (num != 0)
    
        return result
    }
}
