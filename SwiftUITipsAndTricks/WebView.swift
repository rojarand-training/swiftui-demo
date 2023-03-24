//
//  WebView.swift
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 24/03/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let html: String
    
    enum VideoError: Error{
       case videoUnavailable
    }
    
    init() {
        do {
            guard let fileURL = Bundle.main.url(forResource: "preview", withExtension: "mp4") else {
                throw VideoError.videoUnavailable
            }
            let data = try Data(contentsOf: fileURL)
            let base64EncodedVideo = data.base64EncodedString()
            self.html = """
                        <video controls>
                            <source type="video/mp4" src="data:video/mp4;base64,\(base64EncodedVideo)">
                        </video>
                        """
        } catch {
            self.html = "<html><body><b>Error: </b> Could not load the video</body></html>";
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.loadHTMLString(html, baseURL: nil)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator()
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
}
