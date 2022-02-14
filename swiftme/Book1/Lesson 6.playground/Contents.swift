import UIKit

//4
var someArray = [1, 2, 3, 4]
var res = someArray.remove(at: 1)
res += someArray.remove(at: 1)
someArray.insert(res, at: 1)
someArray.sort()

//5
var someArrayTwo = Array(1...100)
var emptyArray: [Int] = []
emptyArray = Array(someArrayTwo[25]...someArrayTwo[49])

//6
var charArray = Array(repeating: Character("k"), count: 5)
charArray.insert("z", at: 1)
var i: UInt8 = UInt8(charArray.count)

//7
var secondArray = someArray.dropLast()
