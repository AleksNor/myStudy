import UIKit
import Foundation

//1
var distanceKM: Double = 3.2
var timeS: Int = 184
// V = S/T
var result: Double = (distanceKM * 1000.0) / (Double(timeS) / 60.0)


//2
var numOne = 111
var numTwo = 222
let numToString: String = String(numOne)+String(numTwo)
let res: Int = Int(numToString)!

//3
var someIntOne: Int8 = Int8.max
var someIntTwo: UInt8 = UInt8.max
print("\(someIntOne) \(someIntTwo)")

//4
var intOne = 5
var intTwo: Int = 10
var temp: Int
temp = intOne
intOne = intTwo
intTwo = temp
print("peremennaya number one \(intOne)")
print("peremennaya number twa \(intTwo)")

//5
let someConst: Float = 4.42
var someVar: Double = 5.567
someVar = 17.777

//6
let constOne = 18
let constTwo: Float = 16.4
let constThree = 5.7
var constSumm: Float = Float(constOne) + constTwo + Float(constThree)
var constMul: Int = constOne * Int(constTwo) * Int(constThree)
var constDis: Double = Double(constTwo).truncatingRemainder(dividingBy: constThree)
print("\(constSumm) \(constMul) \(constDis)")

//7
var a = 2
var b = 3
let resPow = (a + 4 * b) * (a - 3 * b) + Int(pow(Double(a), 2))
print(resPow)

//8
var c = 1.75
var d = 3.25
print(2 * (c + 1) * 2 + 3 * (d + 1))

//9
let length = 13
var square = length * length
var circleLength =  2 * Int(3.14 * Double(length))
var multiResult = square * circleLength

//10
var someString: String = "k"
let someChar: Character = "t"
var nomOne = 22
var nomTwo = 37
let newResult = someString + String(someChar) + String(nomOne + nomTwo)
print(newResult)

//11
print("*  *  *")
print(" ***** ")
print("  * *  ")

//12
var month = "october"
var day = 19
var year = 2021
print("\(day) \(month) \(year)")

//13
var boolOne = true
var boolTwo = false
boolOne && boolTwo
boolOne || boolTwo

//15
let myName = "Johnny"
var weight: Float = 92.3
var height: Int = 179
var imt = weight / Float(((height / 100) * (height/100)))

//18
let q = 13.4
let w = 22.7
let average: Float = Float((q + w) / 2)
