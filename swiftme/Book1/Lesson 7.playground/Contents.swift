import UIKit

var taskSet1 = Set(1...10)
var taskSet2 = Set(5...15)
var taskSet3 = taskSet1.intersection(taskSet2)
var taskSet4 = taskSet1.symmetricDifference(taskSet2)
var count: UInt8 = UInt8(taskSet4.count)

