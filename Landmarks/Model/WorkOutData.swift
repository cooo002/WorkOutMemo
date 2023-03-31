//
//  WorkOutData.swift
//  WorkOutMemo
//
//  Created by 김재석 on 2023/03/30.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import SwiftUI
import HealthKit

struct WorkOutData: Hashable, Identifiable{
    
    var id: Int
    var rawValue: HKWorkout?
    var startDate: Date?
    var endDate: Date?
    
    init( rawValue: HKWorkout ){
        
        let workOutData = rawValue
        
        self.rawValue = workOutData
        self.startDate = workOutData.startDate
        self.endDate = workOutData.endDate
        self.id = Int(arc4random())
    }
    
    var timeOfWorkOut: String{
        
        let timeOfWorkOut = "\(startDate)~\(endDate)"
        
        return timeOfWorkOut
    }
}
