import AppKit
import Foundation

class ClipboardManager: ObservableObject {
    @Published var history: [String] = []
    var hasChanges = false
    private var lastChangeCount: Int = 0
    private var timer: Timer?
    private let maxItems = 10
    private let storageFile: URL

    init() {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDir = appSupport.appendingPathComponent("ClipBoard")
        try? FileManager.default.createDirectory(at: appDir, withIntermediateDirectories: true)
        storageFile = appDir.appendingPathComponent("history.json")
        loadHistory()
    }

    func startMonitoring() {
        lastChangeCount = NSPasteboard.general.changeCount
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkClipboard()
        }
    }

    private func checkClipboard() {
        let currentCount = NSPasteboard.general.changeCount
        guard currentCount != lastChangeCount else { return }
        lastChangeCount = currentCount

        guard let text = NSPasteboard.general.string(forType: .string),
              !text.isEmpty else { return }

        // Don't add duplicates at the top
        if history.first == text { return }

        // Remove if already exists elsewhere
        history.removeAll { $0 == text }

        // Insert at top
        history.insert(text, at: 0)

        // Keep max items
        if history.count > maxItems {
            history = Array(history.prefix(maxItems))
        }

        hasChanges = true
        saveHistory()
    }

    func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            try? data.write(to: storageFile)
        }
    }

    func loadHistory() {
        guard let data = try? Data(contentsOf: storageFile),
              let saved = try? JSONDecoder().decode([String].self, from: data) else { return }
        history = saved
    }
}
