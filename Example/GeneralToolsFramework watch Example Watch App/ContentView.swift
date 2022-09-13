//
//  ContentView.swift
//  GeneralToolsFramework watch Example Watch App
//
//  Created by Zandor Smith on 13/09/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
