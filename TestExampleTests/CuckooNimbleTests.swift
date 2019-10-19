//
//  CuckooNimbleTests.swift
//  TestExampleTests
//
//  Created by Hélio Mesquita on 11/10/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Cuckoo
import Nimble
import XCTest
@testable import TestExample

class CuckooNimbleTests: XCTestCase {

    var subject: HomeInteractor!
    var mockPresenter: MockHomePresenter!

    override func setUp() {
        let interactor = HomeInteractor()
        self.mockPresenter = MockHomePresenter()
        interactor.presenter = self.mockPresenter
        self.subject = interactor
    }

    func test_verifyBMI_when_has_invalid_data_on_height_field_brazilian_number_format_calls_show_invalid_data() {
        stub(mockPresenter) { (stub) in
            when(stub.showInvalidData()).thenDoNothing()
        }
        subject.verifyBMI(height: "1,72", weight: "80")

        verify(mockPresenter).showInvalidData()
    }

    func test_verifyBMI_when_has_invalid_data_on_height_field_invalid_text_calls_show_invalid_data() {
        stub(mockPresenter) { (stub) in
            when(stub.showInvalidData()).thenDoNothing()
        }
        subject.verifyBMI(height: "name", weight: "80")

        verify(mockPresenter).showInvalidData()
    }

    func test_verifyBMI_when_has_invalid_data_on_weight_field_brazilian_number_format_calls_show_invalid_data() {
        stub(mockPresenter) { (stub) in
            when(stub.showInvalidData()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "80,5")

        verify(mockPresenter).showInvalidData()
    }

    func test_verifyBMI_when_has_invalid_data_on_weight_field_invalid_text_calls_show_invalid_data() {
        stub(mockPresenter) { (stub) in
            when(stub.showInvalidData()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "80,5")

        verify(mockPresenter).showInvalidData()
    }

    func test_verifyBMI_when_the_weight_is_below_normal_calls_weight_below_normal() {
        stub(mockPresenter) { (stub) in
            when(stub.weightBelowNormal()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "53.25")

        verify(mockPresenter).weightBelowNormal()
    }

    func test_verifyBMI_when_the_weight_is_normal_min_value_calls_normal_weight() {
        stub(mockPresenter) { (stub) in
            when(stub.normalWeight()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "53.55")

        verify(mockPresenter).normalWeight()
    }

    func test_verifyBMI_when_the_weight_is_normal_max_value_calls_normal_weight() {
        stub(mockPresenter) { (stub) in
            when(stub.normalWeight()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "73.66")

        verify(mockPresenter).normalWeight()
    }

    func test_verifyBMI_when_is_overweight_min_value_calls_overweight() {
        stub(mockPresenter) { (stub) in
            when(stub.overweight()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "73.96")

        verify(mockPresenter).overweight()
    }

    func test_verifyBMI_when_is_overweight_max_value_calls_overweight() {
        stub(mockPresenter) { (stub) in
            when(stub.overweight()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "88.45")

        verify(mockPresenter).overweight()
    }

    func test_verifyBMI_when_is_obesity_min_value_calls_obesity() {
        stub(mockPresenter) { (stub) in
            when(stub.obesity()).thenDoNothing()
        }
        subject.verifyBMI(height: "1.72", weight: "88.752")

        verify(mockPresenter).obesity()
    }

}
