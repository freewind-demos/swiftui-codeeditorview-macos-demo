import Foundation
import LanguageSupport
import SwiftUI
import CodeEditorView

private let sampleCode = """
import Foundation

func makeTitle(name: String) -> String {
  "CodeEditorView -> \\(name)"
}

for value in ["theme", "minimap", "language"] {
  print(makeTitle(name: value))
}
"""

@main
struct CodeEditorViewDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1100, height: 760)
    }
}

private struct ContentView: View {
    @State private var text = sampleCode
    @State private var position = CodeEditor.Position()
    @State private var messages = Set<TextLocated<Message>>()
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button("加载示例") {
                    text = sampleCode
                    messages = []
                }

                Text("字符数 \(text.count)")
                    .foregroundStyle(.secondary)

                Spacer()
            }

            CodeEditor(
                text: $text,
                position: $position,
                messages: $messages,
                language: .swift()
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(16)
    }
}
