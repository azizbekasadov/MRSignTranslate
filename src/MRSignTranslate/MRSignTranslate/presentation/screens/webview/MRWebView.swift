//
//  MRWebView.swift
//  MRSignTranslate
//
//  Created by Azizbek Asadov on 24.03.2025.
//

import SwiftUI
import WebKit
import Observation
import MRSignMTKit
import MRSignMTArchitecture

typealias MRTextInjection = (() -> String)
typealias MRWebJavascript = (() -> String)

@Observable
final class MRWebViewViewModel {
    var textToInject: String = ""
    var customJavaScript: String = ""
    
    init(
        textToInject: String,
        customJavaScript: String
    ) {
        self.textToInject = textToInject
        self.customJavaScript = customJavaScript
    }
}

struct MRWebViewFactory: ViewFactory {
    private let type: MRWebView.SourceType
    private let viewModel: MRWebViewViewModel
    
    init(
        type: MRWebView.SourceType,
        viewModel: MRWebViewViewModel
    ) {
        self.type = type
        self.viewModel = viewModel
    }
    
    func make() -> AnyView {
        AnyView(
            NavigationStack(
                root: {
                    MRWebView(
                        source: self.type,
                        viewModel: self.viewModel
                    )
            })
            .cornerRadius(32, corners: .allCorners)
        )
    }
}

extension MRWebViewFactory {
    
    @ViewBuilder
    static func signMT() -> some View {
        SignMTView()
    }
    
    struct SignMTView: View {
        @Environment(\.dismiss) private var dismiss

        var body: some View {
            NavigationStack {
                MRWebViewFactory.init(
                    type: .remote(url: signMTURL.url!),
                    viewModel: .init(
                        textToInject: "",
                        customJavaScript: SignMTInputText
                            .textInjectMobile("")
                            .makeScript()
                    )
                )
                .make()
//                .scaledToFit()
//                .frame(width: 1272, height: 768)
            }
            .navigationTitle("Translator")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                    }
                }
            }
        }
    }
}

struct MRWebView: UIViewRepresentable {
    enum SourceType {
        case local(
            folder: String,
            indexFile: String = "index.html",
            bundle: Bundle = .main
        )
        case remote(url: URL)
    }

    let source: SourceType
    let viewModel: MRWebViewViewModel

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"

        webView.navigationDelegate = context.coordinator
        loadContent(webView)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // Check if either textToInject or customJavaScript has changed.
        if viewModel.textToInject != context.coordinator.lastInjectedText ||
            viewModel.customJavaScript != context.coordinator.lastInjectedCustomJS {
            
            context.coordinator.lastInjectedText = viewModel.textToInject
            context.coordinator.lastInjectedCustomJS = viewModel.customJavaScript
            
            // Build the JavaScript to execute.
            let javascript: String
            if !viewModel.customJavaScript.isEmpty {
                javascript = viewModel.customJavaScript
            } else {
                javascript = """
                var textarea = document.getElementById('desktop');
                if (textarea) {
                    textarea.value = '\(viewModel.textToInject)';
                    var event = new Event('input', { bubbles: true });
                    textarea.dispatchEvent(event);
                }
                """
            }
            
            webView.evaluateJavaScript(javascript) { result, error in
                if let error = error {
                    print("Error injecting javascript: \(error.localizedDescription)")
                } else {
                    print("Javascript injected successfully.")
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    private func loadContent(_ webView: WKWebView) {
        switch source {
        case let .local(folder, indexFile, bundle):
            if let path = bundle.path(forResource: indexFile, ofType: "html", inDirectory: folder) {
                let url = URL(fileURLWithPath: path)
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            } else {
                print("Error: Could not find \(indexFile) in folder \(folder)")
            }
        case .remote(let url):
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: - Coordinator

    class Coordinator: NSObject, WKNavigationDelegate {
        let viewModel: MRWebViewViewModel
        // Store the last injected text and custom JavaScript.
        var lastInjectedText: String = ""
        var lastInjectedCustomJS: String = ""
        
        init(viewModel: MRWebViewViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Perform the initial injection once the page loads.
            lastInjectedText = viewModel.textToInject
            lastInjectedCustomJS = viewModel.customJavaScript
            
            let javascript: String
            if !viewModel.customJavaScript.isEmpty {
                javascript = viewModel.customJavaScript
            } else {
                javascript = """
                var textarea = document.getElementById('desktop');
                if (textarea) {
                    textarea.value = '\(viewModel.textToInject)';
                    var event = new Event('input', { bubbles: true });
                    textarea.dispatchEvent(event);
                }
                """
            }
            
            webView.evaluateJavaScript(javascript) { result, error in
                if let error = error {
                    print("Error injecting javascript on load: \(error.localizedDescription)")
                } else {
                    print("Initial javascript injected successfully.")
                }
            }
        }
    }
}
