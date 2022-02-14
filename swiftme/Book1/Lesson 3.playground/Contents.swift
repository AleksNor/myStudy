import UIKit
import Foundation

//1
let myName = "Johnny"
var age: UInt8 = 29
let tupleOne: (name: String, age: Int)
tupleOne.name = myName
tupleOne.age = Int(age)

//2
var tupleTwo: (UInt16, UInt16, UInt16)
let a = 15, b = 33
tupleTwo = (UInt16(a), UInt16(b), UInt16(a + b))

//5
var numOne = 12
var numTwo = 21
(numOne, numTwo) = (numTwo, numOne)
numOne

//6
var tupleFour = (film: "Forest Gump", number: 13)
let film = tupleFour.film, number = tupleFour.number
typealias Man = (film: String, number: Int)
var tupleFive: Man = (film: "KVN", number: 7)
(tupleFour, tupleFive) = (tupleFive, tupleFour)
var upleSix = (tupleFour.number, tupleFive.number, (tupleFour.number - tupleFive.number))


