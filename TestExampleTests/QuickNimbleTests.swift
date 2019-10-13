//
//  QuickNimbleTests.swift
//  TestExampleTests
//
//  Created by Hélio Mesquita on 11/10/19.
//  Copyright © 2019 Hélio Mesquita. All rights reserved.
//

import Quick
import Nimble

@testable import TestExample

class QuickNimbleTests: QuickSpec {

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

    override func spec() {
        super.spec()

        describe("HomeInteractor") {
            beforeEach {
                let interactor = HomeInteractor()
                self.dummyHomePresenter = DummyHomePresenter()
                interactor.presenter = self.dummyHomePresenter
                self.subject = interactor
            }

            describe("#verifyBMI") {

                context("when has invalid data") {
                    context("on height field") {
                        context("brazilian number format") {
                            it("calls show invalid data") {
                                self.subject.verifyBMI(height: "1,72", weight: "80")

                                expect(self.dummyHomePresenter.hasCalledShowInvalidData).to(beTrue())
                            }
                        }
                        context("invalid text") {
                            it("calls show invalid data") {
                                self.subject.verifyBMI(height: "name", weight: "80")

                                expect(self.dummyHomePresenter.hasCalledShowInvalidData).to(beTrue())
                            }
                        }

                    }
                    context("on weight field") {
                        context("brazilian number format") {
                            it("calls show invalid data") {
                                self.subject.verifyBMI(height: "1.72", weight: "80,5")

                                expect(self.dummyHomePresenter.hasCalledShowInvalidData).to(beTrue())
                            }
                        }
                        context("invalid text") {
                            it("calls show invalid data") {
                                self.subject.verifyBMI(height: "1.72", weight: "name")

                                expect(self.dummyHomePresenter.hasCalledShowInvalidData).to(beTrue())
                            }
                        }
                    }
                }

                context("when the weight is below normal") {
                    it("calls weight below normal") {
                        self.subject.verifyBMI(height: "1.72", weight: "53.25")

                        expect(self.dummyHomePresenter.hasCalledWeightBelowNormal).to(beTrue())
                    }
                }

                context("when the weight is normal") {
                    context("min value") {
                        it("calls normal weight") {
                            self.subject.verifyBMI(height: "1.72", weight: "53.55")

                            expect(self.dummyHomePresenter.hasCalledNormalWeight).to(beTrue())
                        }
                    }
                    context("max value") {
                        it("calls normal weight") {
                            self.subject.verifyBMI(height: "1.72", weight: "73.66")

                            expect(self.dummyHomePresenter.hasCalledNormalWeight).to(beTrue())
                        }
                    }
                }

                context("when is overweight") {
                    context("min value") {
                        it("calls overweight") {
                            self.subject.verifyBMI(height: "1.72", weight: "73.96")

                            expect(self.dummyHomePresenter.hasCalledOverweight).to(beTrue())
                        }
                    }
                    context("max value") {
                        it("calls overweight") {
                            self.subject.verifyBMI(height: "1.72", weight: "88.45")

                            expect(self.dummyHomePresenter.hasCalledOverweight).to(beTrue())
                        }
                    }
                }

                context("when is obesity") {
                    context("min value") {
                        it("calls obesity") {
                            self.subject.verifyBMI(height: "1.72", weight: "88.752")

                            expect(self.dummyHomePresenter.hasCalledObesity).to(beTrue())
                        }
                    }
                }
            }
        }
    }
}
