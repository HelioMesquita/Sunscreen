//
//  HomeInteractor.swift
//  TestExample
//
//  Created by Hélio Mesquita on 11/10/19.
//  Copyright (c) 2019 Hélio Mesquita. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//
// This tag below is used to create the testable files from the Cuckoo pod
// CUCKOO_TESTABLE

import UIKit

protocol HomeBusinessLogic {
    func verifyBMI(height: String?, weight: String?)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {

    var presenter: HomePresentationLogic?
    let worker: HomeWorker

    init(worker: HomeWorker = HomeWorker()) {
        self.worker = worker
    }

    func verifyBMI(height: String?, weight: String?) {
        guard let height = Double(height ?? ""), let weight = Double(weight ?? "") else {
            presenter?.showInvalidData()
            return
        }

        let bmiResult = weight/(height * height)

        switch bmiResult {
        case ..<18:
            presenter?.weightBelowNormal()
        case 18.1...24.9:
            presenter?.normalWeight()
        case 25...29.9:
            presenter?.overweight()
        case 30...:
            presenter?.obesity()
        default:
            presenter?.showInvalidData()
        }
    }

}
