//
//  PersonTests.swift
//  UnitTestingAppTests
//
//  Created by Евгений Карпов on 21.12.2021.
//

import XCTest
@testable import UnitTestingApp

class PersonTests: XCTestCase {
    
    var person: Person?
    var personWithFullName: Person?
    var image: UIImage?
    var imageData: Data?

    override func setUp() {
        super.setUp()
        person = Person(name: "Foo", phone: "Bar")
        personWithFullName = Person(name: "Foo", surname: "Bar", phone: "Baz")
        image = UIImage(systemName: "person.crop.circle")
        imageData = image?.pngData()
    }

    override func tearDown() {
        person = nil
        personWithFullName = nil
        image = nil
        imageData = nil
        super.tearDown()
    }

    func testInitPersonWithNameAndPhone() {
        XCTAssertNotNil(person)
    }
    
    func testInitPersonWithFullNameAndPhone() {
        XCTAssertNotNil(personWithFullName)
    }
    
    func testWhenGivenNameAndPhoneSetNameAndPhone() {
        XCTAssertEqual(person?.name, "Foo")
        XCTAssertEqual(person?.phone, "Bar")
    }
    
    func testWhenGivenFullNameAndPhoneSetNameAndPhone() {

        XCTAssertEqual(personWithFullName?.name, "Foo")
        XCTAssertEqual(personWithFullName?.surname, "Bar")
        XCTAssertEqual(personWithFullName?.phone, "Baz")
    }
    
    func testInitPersonWithDate() {
        XCTAssertNotNil(person?.date)
    }
    
    func testInitPersonWithImage() {
        let person = Person(name: "Foo", phone: "Bar", image: imageData)
        XCTAssertNotNil(person)
    }
    
    func testInitPersonWithFullNameAndImage() {
        let person = Person(name: "Foo", surname: "Baz", phone: "Bar", image: imageData)
        XCTAssertNotNil(person)
    }
}
