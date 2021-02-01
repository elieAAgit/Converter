//
//  ConverterApp.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import SwiftUI

@main
struct ConverterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
