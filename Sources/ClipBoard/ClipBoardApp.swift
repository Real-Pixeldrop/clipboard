import SwiftUI
import AppKit

@main
struct ClipBoardApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var clipboardManager = ClipboardManager()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide dock icon
        NSApp.setActivationPolicy(.accessory)

        // Check for updates (background, non-blocking)
        UpdateChecker.shared.checkForUpdates()

        // Create menu bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "ClipBoard")
        }

        // Start monitoring clipboard
        clipboardManager.startMonitoring()

        // Build menu
        updateMenu()

        // Update menu periodically
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            if self?.clipboardManager.hasChanges ?? false {
                self?.updateMenu()
                self?.clipboardManager.hasChanges = false
            }
        }
    }

    func updateMenu() {
        let menu = NSMenu()

        if clipboardManager.history.isEmpty {
            let emptyItem = NSMenuItem(title: "Aucun élément copié", action: nil, keyEquivalent: "")
            emptyItem.isEnabled = false
            menu.addItem(emptyItem)
        } else {
            for (index, item) in clipboardManager.history.enumerated() {
                let truncated = item.prefix(50)
                let displayText = "\(index + 1). \(truncated)\(item.count > 50 ? "..." : "")"
                let menuItem = NSMenuItem(title: displayText, action: #selector(copyItem(_:)), keyEquivalent: "")
                menuItem.target = self
                menuItem.tag = index
                menu.addItem(menuItem)
            }
        }

        menu.addItem(NSMenuItem.separator())

        let clearItem = NSMenuItem(title: "Effacer l'historique", action: #selector(clearHistory), keyEquivalent: "")
        clearItem.target = self
        menu.addItem(clearItem)

        let quitItem = NSMenuItem(title: "Quitter", action: #selector(quitApp), keyEquivalent: "q")
        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    @objc func copyItem(_ sender: NSMenuItem) {
        let index = sender.tag
        guard index < clipboardManager.history.count else { return }
        let text = clipboardManager.history[index]
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }

    @objc func clearHistory() {
        clipboardManager.history.removeAll()
        clipboardManager.saveHistory()
        updateMenu()
    }

    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
