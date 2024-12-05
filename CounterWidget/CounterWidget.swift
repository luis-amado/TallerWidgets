//
//  CounterWidget.swift
//  CounterWidget
//
//  Created by Luis Amado on 04/12/24.
//

// Esta widget extension fue generada como la del CalendarWidget
// Es decir, no estaba seleccionado ninguno de los otros componentes de live action, control, ni configuration AppIntent

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        // En el placeholder, podemos mostrar como se ve el widget mientras no se haya cargado el valor
        SimpleEntry(date: Date(), count: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // UserDefaults nos permite guardar informacion en el dispositivo
        // Es como un hashmap donde podemos poner lo que queramos
        // La funcion `UserDefaults.standard.integer` regresa 0 si no existe el valor, entonces no nos tenemos que preocupar por eso
        let count = UserDefaults.standard.integer(forKey: "count")
        let entry = SimpleEntry(date: Date(), count: count)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Igual que la widget de frases, esta widget solo cambia cuando el usuario hace una accion
        let count = UserDefaults.standard.integer(forKey: "count")
        let entries: [SimpleEntry] = [SimpleEntry(date: .now, count: count)]
        
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let count: Int?
}

struct CounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack (spacing: 15) {
            if let count = entry.count {
                Text("\(count)")
                    .font(.title)
                    .contentTransition(.numericText())
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 50, height: 30)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
            // Para que un boton funcione en una widget, necesariamente tiene que llamar un AppIntent, no puede tener un action normal
            Button(intent: IncrementCounterIntent()) {
                Text("Increment")
            }
            .buttonStyle(.bordered)
            .disabled(entry.count == nil)
        }
    }
}

struct CounterWidget: Widget {
    let kind: String = "CounterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("Counter widget")
        .description("Example of an interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    CounterWidget()
} timeline: {
    SimpleEntry(date: .now, count: nil)
    SimpleEntry(date: .now, count: 0)
    SimpleEntry(date: .now, count: 5)
    SimpleEntry(date: .now, count: 10)
}
