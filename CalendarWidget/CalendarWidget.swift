//
//  CalendarWidget.swift
//  CalendarWidget
//
//  Created by Luis Amado on 04/12/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct CalendarWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date.formatted(.dateTime.weekday(.wide)))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.red)
            Text(entry.date.formatted(.dateTime.day()))
                .font(.system(size: 65))
                .fontWeight(.bold)
                .contentTransition(.numericText())
        }
    }
}

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CalendarWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Calendar Widget")
        .description("See the day of the month.")
    }
}

#Preview(as: .systemSmall) {
    CalendarWidget()
} timeline: {
    SimpleEntry(date: .now)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 1, to: .now)!)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 3, to: .now)!)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 5, to: .now)!)
    SimpleEntry(date: Calendar.current.date(byAdding: .day, value: 6, to: .now)!)
}
