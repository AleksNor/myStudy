import UIKit

//4
var someDict = [1: ["a"], 2 : ["b"], 3 : ["c"]]
var dictElCount = someDict.count
var someArray = Array(repeating: dictElCount, count: dictElCount)


//Lesson 9

//1
var someString = "Swift"
let someChar: Character = "S"
var newArray = Array(repeating: String(someChar), count: someString.count)
someString = String(someChar)

//2
let name = "John Wick"
print(name[name.startIndex])
print(name[name.index(before: name.endIndex)])

//3
var whiteSet: Set = ["\u{2654}", "\u{2655}", "\u{2656}", "\u{2657}", "\u{2658}", "\u{2659}"]
var blackSet: Set = ["\u{265A}", "\u{265B}", "\u{265C}", "\u{265D}", "\u{265E}", "\u{265F}"]



