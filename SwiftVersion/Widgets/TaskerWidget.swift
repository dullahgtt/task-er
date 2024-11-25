import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: Date(), tasks: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
        let entry = TaskEntry(date: Date(), tasks: TaskManager().tasks)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = TaskEntry(date: Date(), tasks: TaskManager().tasks)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct TaskEntry: TimelineEntry {
    let date: Date
    let tasks: [Task]
}

struct TaskerWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today's Tasks")
                .font(.headline)
                .padding(.bottom, 4)
            
            ForEach(entry.tasks.prefix(3)) { task in
                HStack {
                    Text(task.title)
                        .lineLimit(1)
                    Spacer()
                    Text("\(Int(task.timePerDay))m")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
            }
            
            if entry.tasks.isEmpty {
                Text("No tasks for today")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

@main
struct TaskerWidget: Widget {
    let kind: String = "TaskerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Tasker")
        .description("View your daily tasks")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
} 