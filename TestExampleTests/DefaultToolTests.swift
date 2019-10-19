//
//  DefaultToolTests.swift
//  DefaultToolTests
//
//  Created by Hélio Mesquita on 11/10/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import XCTest
@testable import TestExample

class DefaultToolTests: XCTestCase {

    class DummyHomePresenter: HomePresentationLogic {
        var hasCalledShowInvalidData = false
        var hasCalledWeightBelowNormal = false
        var hasCalledNormalWeight = false
        var hasCalledOverweight = false
        var hasCalledObesity = false

        func showInvalidData() { hasCalledShowInvalidData = true }
        func weightBelowNormal() { hasCalledWeightBelowNormal = true }
        func normalWeight() { hasCalledNormalWeight = true }
        func overweight() { hasCalledOverweight = true }
        func obesity() { hasCalledObesity = true }
    }

    var subject: HomeInteractor!
    var dummyHomePresenter: DummyHomePresenter!

    override func setUp() {
        let interactor = HomeInteractor()
        self.dummyHomePresenter = DummyHomePresenter()
        interactor.presenter = self.dummyHomePresenter
        self.subject = interactor
    }

    func test_verifyBMI_when_has_invalid_data_on_height_field_brazilian_number_format_calls_show_invalid_data() {
        self.subject.verifyBMI(height: "1,72", weight: "80")

        XCTAssertTrue(dummyHomePresenter.hasCalledShowInvalidData)
    }

    func test_verifyBMI_when_has_invalid_data_on_height_field_invalid_text_calls_show_invalid_data() {
        subject.verifyBMI(height: "name", weight: "80")

        XCTAssertTrue(dummyHomePresenter.hasCalledShowInvalidData)
    }

    func test_verifyBMI_when_has_invalid_data_on_weight_field_brazilian_number_format_calls_show_invalid_data() {
        subject.verifyBMI(height: "1.72", weight: "80,5")

        XCTAssertTrue(dummyHomePresenter.hasCalledShowInvalidData)
    }

    func test_verifyBMI_when_has_invalid_data_on_weight_field_invalid_text_calls_show_invalid_data() {
        subject.verifyBMI(height: "1.72", weight: "80,5")

        XCTAssertTrue(dummyHomePresenter.hasCalledShowInvalidData)
    }

    func test_verifyBMI_when_the_weight_is_below_normal_calls_weight_below_normal() {
        subject.verifyBMI(height: "1.72", weight: "53.25")

        XCTAssertTrue(dummyHomePresenter.hasCalledWeightBelowNormal)
    }

    func test_verifyBMI_when_the_weight_is_normal_min_value_calls_normal_weight() {
        subject.verifyBMI(height: "1.72", weight: "53.55")

        XCTAssertTrue(dummyHomePresenter.hasCalledNormalWeight)
    }

    func test_verifyBMI_when_the_weight_is_normal_max_value_calls_normal_weight() {
        subject.verifyBMI(height: "1.72", weight: "73.66")

        XCTAssertTrue(dummyHomePresenter.hasCalledNormalWeight)
    }

    func test_verifyBMI_when_is_overweight_min_value_calls_overweight() {
        subject.verifyBMI(height: "1.72", weight: "73.96")

        XCTAssertTrue(dummyHomePresenter.hasCalledOverweight)
    }

    func test_verifyBMI_when_is_overweight_max_value_calls_overweight() {
        subject.verifyBMI(height: "1.72", weight: "88.45")

        XCTAssertTrue(dummyHomePresenter.hasCalledOverweight)
    }


    func test_verifyBMI_when_is_obesity_min_value_calls_obesity() {
        subject.verifyBMI(height: "1.72", weight: "88.752")

        XCTAssertTrue(dummyHomePresenter.hasCalledObesity)
    }

}
