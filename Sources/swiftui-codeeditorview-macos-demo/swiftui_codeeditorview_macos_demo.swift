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
                    position = CodeEditor.Position()
                }

                Button("Duplicate 当前行 (⌘D)") {
                    duplicateCurrentLine()
                }
                .keyboardShortcut("d", modifiers: [.command])

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

    private func duplicateCurrentLine() {
        let result = duplicateCurrentLineInText(
            in: text,
            selection: position.selections.first ?? NSRange(location: 0, length: 0)
        )
        text = result.text
        position.selections = [result.selection]
    }
}

private func duplicateCurrentLineInText(in text: String, selection: NSRange) -> (text: String, selection: NSRange) {
    let nsText = text as NSString
    let location = min(selection.location, nsText.length)
    let lineRange = nsText.lineRange(for: NSRange(location: location, length: 0))
    let lineText = nsText.substring(with: lineRange)
    let insertionText =
        lineRange.upperBound == nsText.length && !lineText.hasSuffix("\n")
        ? "\n" + lineText
        : lineText
    let insertedLength = (insertionText as NSString).length
    let updatedText = nsText.replacingCharacters(
        in: NSRange(location: lineRange.upperBound, length: 0),
        with: insertionText
    )

    return (
        text: updatedText,
        selection: NSRange(location: location + insertedLength, length: selection.length)
    )
}
