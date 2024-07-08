//
//  ContentView.swift
//  GeneralToolsFramework Example visionOS
//
//  Created by Zandor Smith on 08/07/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
