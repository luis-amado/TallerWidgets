//
//  AppIntent.swift
//  PhraseWidget
//
//  Created by Luis Amado on 04/12/24.
//

import WidgetKit
import AppIntents
import SwiftUI

enum WidgetColor: String, AppEnum  {
    case blue
    case green
    case red
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Color"
    static var caseDisplayRepresentations: [WidgetColor : DisplayRepresentation] = [
        .blue: "Blue",
        .green: "Green",
        .red: "Red"
    ]
    
    func toColor() -> Color {
        switch(self) {
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        }
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Phrase", default: "Work hard")
    var phrase: String
    
    @Parameter(title: "Background Color", default: .blue)
    var background: WidgetColor
    
    init(phrase: String, background: WidgetColor) {
        self.phrase = phrase
        self.background = background
    }
    
    init() {}
}
