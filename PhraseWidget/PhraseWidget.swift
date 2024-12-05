//
//  PhraseWidget.swift
//  PhraseWidget
//
//  Created by Luis Amado on 04/12/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entries: [SimpleEntry] = [SimpleEntry(date: .now, configuration: configuration)]

        return Timeline(entries: entries, policy: .never)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct PhraseWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.configuration.phrase)
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
        }
        .containerBackground(entry.configuration.background.toColor().gradient, for: .widget)
    }
}

struct PhraseWidget: Widget {
    let kind: String = "PhraseWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PhraseWidgetEntryView(entry: entry)
        }
    }
}

#Preview(as: .systemSmall) {
    PhraseWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent(phrase: "Dream big", background: .blue))
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent(phrase: "Be better than yesterday", background: .red))
    SimpleEntry(date: .now, configuration: ConfigurationAppIntent(phrase: "Taller iOS", background: .green))
}
