//
//  WorkOutRow.swift
//  WorkOutMemo
//
//  Created by 김재석 on 2023/03/30.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import HealthKit
import Foundation

struct WorkOutRow: View {
    
    var workOutData: WorkOutData
    
    var body: some View {
        HStack{
            Image(systemName: "figure.strengthtraining.traditional")
            Text(workOutData.timeOfWorkOut)
        }
    }
}

struct WorkOutRow_Previews: PreviewProvider {
    
    static let temptHKWorkOutData = HKWorkout(
        activityType: .crossTraining,
        start: Date(),
        end: Date(),
        duration: 23000.000,
        totalEnergyBurned: nil,
        totalDistance: nil,
        device: nil,
        metadata: nil
    )
    static let workOutData =  WorkOutData(rawValue: temptHKWorkOutData)
    
    static var previews: some View {
    
        WorkOutRow(workOutData: workOutData)
    }
}
