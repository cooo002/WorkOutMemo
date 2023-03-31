/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine
import HealthKit

final class ModelData: ObservableObject {
    
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    @Published var profile = Profile.default
    @Published var workOutData: [WorkOutData]?
    var hikes: [Hike] = load("hikeData.json")

    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    init() {
        print("ModelData init")
        
        requestAccessHealthStorage{
            
            self.retrieveWorkOutData()
        }
    }
}

extension ModelData{
    
    private func requestAccessHealthStorage( _ completion: @escaping() -> Void ){
        
        HealthStorage.shared.requestAuthorizationIfNeeded{ isSuccess in
            
            switch isSuccess{
             
            case true:
                
                completion()
                
            case false:
                
                return
            }
        }
    }
    
    private func retrieveWorkOutData(){
        
        HealthStorage.shared.retrieveWorkOutData{ data in
        
            guard let unwrappingWorkOutData = data else { return }
        
            var workOutDatas: [WorkOutData] = []
            
            DispatchQueue.main.async {
            
                unwrappingWorkOutData.forEach{ data in
                 
                    let workOutData = WorkOutData(rawValue: data)
                    workOutDatas.append(workOutData)
                }
                
                self.workOutData = workOutDatas
            }
        }
    }
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
