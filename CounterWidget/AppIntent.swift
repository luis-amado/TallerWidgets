//
//  AppIntent.swift
//  TallerDeWidgets
//
//  Created by Luis Amado on 04/12/24.
//

import Foundation
import AppIntents

struct IncrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Counter"
    
    func perform() async throws -> some IntentResult {
        // Leer el valor actual, y guardarlo incrementando uno
        let count = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(count + 1, forKey: "count")
        
        return .result()
    }
}
