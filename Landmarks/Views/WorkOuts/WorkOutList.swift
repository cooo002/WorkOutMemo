//
//  WorkOutList.swift
//  WorkOutMemo
//
//  Created by 김재석 on 2023/03/30.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct WorkOutList: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var workOutData: [WorkOutData]{
        
        return modelData.workOutData ?? []
    }
    var body: some View {
        
        NavigationView{
            List{
                ForEach(workOutData){ data in
                   
                    NavigationLink{
                        WorkOutDetail()
                    } label: {
                        WorkOutRow(workOutData: data)
                    }
                }
            }
        }
        .navigationTitle("WorkOutList")
    }
}

struct WorkOutList_Previews: PreviewProvider {
    static var previews: some View {
        WorkOutList().environmentObject(ModelData())
    }
}
