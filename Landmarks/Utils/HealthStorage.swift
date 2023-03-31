//
//  HealthStorage.swift
//  Landmarks
//
//  Created by 김재석 on 2023/03/30.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import HealthKit

final class HealthStorage{
    
    static let shared = HealthStorage()
    private let store = HKHealthStore()
    private let typesToShare: Set = [
        HKQuantityType.workoutType()
    ]
    
    let typesToRead: Set = [
        HKQuantityType.quantityType(forIdentifier: .heartRate)!,
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
        HKObjectType.activitySummaryType(),
        HKQuantityType.workoutType()
    ]
    
    
}

extension HealthStorage{
    
    func requestAuthorizationIfNeeded( _ completion: @escaping( Bool ) -> Void  ){
        
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Do Not Access HealthDataAvailable")
            completion(false)
            
            return
        }
        
        store.requestAuthorization(
            toShare: typesToShare,
            read: typesToRead
        ) { isSuccess, error in
            
            if let error = error {
                
                completion(false)
                
            } else {
                
                completion(true)
                
            }
        }
    }
    
    func retrieveWorkOutData( _ completion: @escaping([HKWorkout]?) -> Void ){
        print("retrieveWorkOutData start...!")
        
        var workOutData: [HKWorkout] = []
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) { (_, results, error) in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                let sample = results as? [HKWorkout]
                
                completion(sample ?? nil)
            }
        
        store.execute(query)
    }
}

