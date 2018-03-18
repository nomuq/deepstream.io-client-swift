//
//  DeepstreamIOSpec.swift
//  DeepstreamIO
//
//  Created by Satish Babariya on 04/10/16.
//  Copyright © 2017 satishbabariya. All rights reserved.
//

import Quick
import Nimble
@testable import DeepstreamIO

class DeepstreamIOSpec: QuickSpec {

    override func spec() {

        describe("DeepstreamIOSpec") {
            it("works") {
                expect(DeepstreamIO.name) == "DeepstreamIO"
            }
        }

    }

}
