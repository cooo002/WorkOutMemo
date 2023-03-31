/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of all of the landmarks.
*/

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    enum Tab {
        case featured
        case list
        case workout
    }

    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "figure.step.training")
                }
                .tag(Tab.featured)

            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            
            WorkOutList()
                .tabItem {
                    Label("WorkOut", systemImage: "list.bullet")
                }
                .tag(Tab.workout)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
