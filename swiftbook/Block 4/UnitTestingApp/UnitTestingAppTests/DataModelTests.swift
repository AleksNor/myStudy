//
//  DataModelTests.swift
//  DataModelTests
//
//  Created by Евгений Карпов on 07.12.2021.
//

import XCTest
@testable import UnitTestingApp

class DataModelTests: XCTestCase {
    //system under test
    var sut: DataModel!

    override func setUp(){
        super.setUp()
        sut = DataModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLowestVolumeShouldBeZero() {
        // given - что дано
        sut.setVolume(to: -1)
        
        // when - что произошло
        let volume = sut.volume
        
        // then - проверка результатов
        XCTAssert(volume == 0, "Lowest value should be equel zero")
    }
    
    func testHighestVolumeShouldBe100() {
        // given - что дано
        sut.setVolume(to: 101)
        
        // when - что произошло
        let volume = sut.volume
        
        // then - проверка результатов
        XCTAssert(volume == 100, "Highes value should be equel 100")
    }
    
    func testNumberOneMustBeGraterThenNumberTwo() {
        let numberOne = 2
        let numberTwo = 1
        
        let isGreater = sut.greaterThenVaule(x: numberOne, y: numberTwo)
        
        XCTAssertTrue(isGreater)
    }
    
    func testNumberOneNotBeGreaterThenNumberTwo() {
        let numberOne = 1
        let numberTwo = 2
        
        let isGreater = sut.greaterThenVaule(x: numberOne, y: numberTwo)
        
        XCTAssertFalse(isGreater)
    }
}
