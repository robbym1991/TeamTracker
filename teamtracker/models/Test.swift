//
//  Test.swift
//  teamtracker
//
//  Created by Robby Michels on 07-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation

//example model can be deleted later in the project.
class Test {
    private let test: String
    private var test2: Int
    
    init(test: String, test2: Int) {
        self.test = test
        self.test2 = test2
    }
    
    func getTest() -> String {
        return test
    }
    
    func setTest(test2: Int) {
        self.test2 = test2
    }
}
