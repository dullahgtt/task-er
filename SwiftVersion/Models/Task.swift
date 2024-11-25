struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var deadline: Date
    var timePerDay: TimeInterval // in minutes
    var isCompleted: Bool
    var totalTimeNeeded: TimeInterval // in minutes
    
    init(title: String, deadline: Date, timePerDay: TimeInterval, totalTimeNeeded: TimeInterval) {
        self.id = UUID()
        self.title = title
        self.deadline = deadline
        self.timePerDay = timePerDay
        self.isCompleted = false
        self.totalTimeNeeded = totalTimeNeeded
    }
    
    static func preview() -> Task {
        Task(title: "Sample Task", 
             deadline: Date().addingTimeInterval(86400),
             timePerDay: 30,
             totalTimeNeeded: 120)
    }
} 