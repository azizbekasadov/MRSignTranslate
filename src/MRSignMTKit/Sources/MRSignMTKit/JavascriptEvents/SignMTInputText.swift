//
//  File.swift
//  MRSignMTKit
//
//  Created by Azizbek Asadov on 27.03.2025.
//

import Foundation

public let signMTURL = "https://sign.mt/?lang=en"

public protocol MRJavascriptScript {
    func makeScript() -> String
}

public enum SignMTInputText: MRJavascriptScript {
    case textInput(String)
    case textInjectMobile(String)
    case textInjectHideTextField(String)
    case hideAllButSkeleton(input: String)
    case zoom(Float)
    
    public func makeScript() -> String {
        switch self {
        case .zoom(let zoomLevel):
            let enableZoomScript = """
                var meta = document.querySelector('meta[name=viewport]');
                if (meta) {
                    meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes');
                } else {
                    meta = document.createElement('meta');
                    meta.name = 'viewport';
                    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes';
                    document.head.appendChild(meta);
                }
                document.body.style.transform = 'scale(\(zoomLevel))';
                document.body.style.transformOrigin = '0 0';
            """
            return enableZoomScript
            
        case .textInjectHideTextField(let text):
            return """
                (function() {
                    const textarea = document.getElementById('desktop');
                    if (textarea) {
                        // Hide the textarea
                        textarea.style.display = 'none';

                        // Set the value
                        textarea.value = `\(text)`;

                        // Dispatch input event to simulate user typing
                        const inputEvent = new Event('input', { bubbles: true });
                        textarea.dispatchEvent(inputEvent);

                        // Optional: focus and blur to trigger Angular/React listeners if needed
                        textarea.focus();
                        textarea.blur();
                    }
                })();
                """

        case .textInjectMobile(let text):
//            return """
//            (function () {
//                const text = "\(text)";
//
//                function injectText() {
//                    const textarea = document.getElementById('desktop');
//                    if (textarea) {
//                        textarea.value = text;
//
//                        const inputEvent = new Event('input', { bubbles: true });
//                        textarea.dispatchEvent(inputEvent);
//                    }
//                }
//
//                function isolateSignedOutput() {
//                    const output = document.querySelector('app-signed-language-output');
//                    const appRoot = document.querySelector('app-root');
//
//                    if (!output || !appRoot) return;
//
//                    // Keep only the path to output visible
//                    const keepSet = new Set();
//                    let current = output;
//                    while (current) {
//                        keepSet.add(current);
//                        current = current.parentElement;
//                    }
//
//                    Array.from(document.body.children).forEach(child => {
//                        if (child !== appRoot) {
//                            child.style.display = 'none';
//                        }
//                    });
//
//                    const walkAndHide = (el) => {
//                        Array.from(el.children).forEach(child => {
//                            if (!keepSet.has(child)) {
//                                child.style.display = 'none';
//                                walkAndHide(child);
//                            } else {
//                                walkAndHide(child);
//                            }
//                        });
//                    };
//
//                    walkAndHide(appRoot);
//
//                    // Style the output component to fill screen
//                    output.style.position = 'absolute';
//                    output.style.top = '0';
//                    output.style.left = '0';
//                    output.style.right = '0';
//                    output.style.bottom = '0';
//                    output.style.margin = 'auto';
//                    output.style.zIndex = '9999';
//                    output.style.background = 'white';
//                }
//
//                // MutationObserver in case things load late
//                const observer = new MutationObserver(() => {
//                    injectText();
//                    isolateSignedOutput();
//                });
//
//                observer.observe(document, { childList: true, subtree: true });
//
//                // Run immediately
//                injectText();
//                isolateSignedOutput();
//            })();
//            """
            return """
            (function() {
                function injectTextInto(id, text) {
                    var textarea = document.getElementById(id);
                    if (textarea) {
                        textarea.value = text;
                        var event = new Event('input', { bubbles: true });
                        textarea.dispatchEvent(event);
                    }
                }

                function isolateSignedLanguageComponent() {
                    var target = document.querySelector('app-signed-language-output');
                    if (target) {
                        document.body.innerHTML = '';
                        document.body.appendChild(target);
                    }
                }

                function tryInjectAll() {
                    const text = '\(text)';
                    injectTextInto('desktop', text);
                    injectTextInto('ion-textarea-0', text);
                }

                // Run immediately
                // isolateSignedLanguageComponent();
                tryInjectAll();

                // Set up MutationObserver if DOM not ready
                const observer = new MutationObserver(function(mutations, obs) {
                    tryInjectAll();
                    const desktopExists = document.getElementById('desktop');
                    const mobileExists = document.getElementById('ion-textarea-0');
                    if (desktopExists && mobileExists) {
                        obs.disconnect();
                    }
                });

                observer.observe(document, { childList: true, subtree: true });
            })();
            """
        case .textInput(let text):
            return """
                                var textarea = document.getElementById('desktop');
                                if (textarea) {
                                    textarea.value = '\(text)';
                                    var event = new Event('input', { bubbles: true });
                                    textarea.dispatchEvent(event);
                                }
                """
        case .hideAllButSkeleton(let text):
//            return """
//            (function() {
//                          function hideOthers() {
//                            var target = document.querySelector('app-signed-language-output');
//                            if (target) {
//                              // Iterate over all direct children of the body.
//                              var children = document.body.children;
//                              for (var i = 0; i < children.length; i++) {
//                                if (children[i] !== target) {
//                                  children[i].style.display = 'none';
//                                }
//                              }
//                              // Ensure the target is visible.
//                              target.style.display = 'block';
//                              return true;
//                            }
//                            return false;
//                          }
//                          // Try to hide immediately.
//                          if (!hideOthers()) {
//                            // If not yet available, observe for changes.
//                            var observer = new MutationObserver(function(mutations, obs) {
//                              if (hideOthers()) {
//                                obs.disconnect();
//                              }
//                            });
//                            observer.observe(document, { childList: true, subtree: true });
//                          }
//                        })();
//            """
            let combinedScript = """
            (function () {
                const injectedText = '\(text)'; // Replace this with dynamic text if needed

                function injectTextInto(id, text) {
                    const textarea = document.getElementById(id);
                    if (textarea) {
                        textarea.value = text;
                        const event = new Event('input', { bubbles: true });
                        textarea.dispatchEvent(event);
                        console.log(`✅ Injected into #${id}`);
                    }
                }

                function tryInjectAll() {
                    injectTextInto('desktop', injectedText);
                    injectTextInto('ion-textarea-0', injectedText);
                }

                function isolateSignedLanguageComponent() {
                    const output = document.querySelector('app-signed-language-output');
                    const appRoot = document.querySelector('app-root') || document.querySelector('ion-app');

                    if (!output || !appRoot) {
                        console.warn('🚫 Required elements not found.');
                        return false;
                    }

                    // Collect ancestors of the output component
                    const keepSet = new Set();
                    let current = output;
                    while (current) {
                        keepSet.add(current);
                        current = current.parentElement;
                    }

                    // Hide everything inside appRoot except for output and its ancestors
                    const walkAndHide = (element) => {
                        Array.from(element.children).forEach(child => {
                            if (!keepSet.has(child)) {
                                child.style.visibility = 'hidden'; // Use visibility instead of display
                                child.style.pointerEvents = 'none'; // prevent user interaction
                                walkAndHide(child);
                            } else {
                                walkAndHide(child);
                            }
                        });
                    };

                    walkAndHide(appRoot);

                    // Apply focus style to output component
                    Object.assign(output.style, {
                        position: 'relative',
                        zIndex: '9999',
                        background: 'white',
                        padding: '16px',
                    });

                    return true;
                }

                // Run initial isolation and text injection
                const initialized = isolateSignedLanguageComponent();
                tryInjectAll();

                // Retry if elements aren't ready yet
                if (!initialized) {
                    const observer = new MutationObserver(() => {
                        const success = isolateSignedLanguageComponent();
                        tryInjectAll();

                        const d = document.getElementById('desktop');
                        const m = document.getElementById('ion-textarea-0');
                        const o = document.querySelector('app-signed-language-output');

                        if (d && m && o && success) observer.disconnect();
                    });

                    observer.observe(document, { childList: true, subtree: true });
                }
            })();
            """
            return combinedScript
        }
    }
}

//<app-signed-language-output _ngcontent-ng-c1716417655="" _nghost-ng-c2028080701=""><video _ngcontent-ng-c2028080701="" autoplay="" loop="" muted="" playsinline="" height="100%" width="100%" src="blob:https://sign.mt/4dff889f-c5d1-4f98-8b69-2ef7d8534015"></video><!----><!----><div _ngcontent-ng-c2028080701="" class="actions-row"><ion-button _ngcontent-ng-c2028080701="" fill="clear" shape="round" color="dark" class="mat-mdc-tooltip-trigger circle-icon ion-color ion-color-dark md button button-round button-clear button-has-icon-only ion-activatable ion-focusable"><ion-icon _ngcontent-ng-c2028080701="" name="download-outline" slot="icon-only" role="img" class="md"></ion-icon></ion-button><!----><ion-button _ngcontent-ng-c2028080701="" fill="clear" shape="round" color="dark" class="mat-mdc-tooltip-trigger circle-icon ion-color ion-color-dark md button button-round button-clear button-has-icon-only ion-activatable ion-focusable"><ion-icon _ngcontent-ng-c2028080701="" ios="share-outline" md="share-social-outline" slot="icon-only" role="img" class="md"></ion-icon></ion-button><!----><!----><!----><!----></div><app-viewer-selector _ngcontent-ng-c2028080701="" _nghost-ng-c3803646432=""><ion-fab _ngcontent-ng-c3803646432="" id="viewer-selector" class="md"><ion-fab-button _ngcontent-ng-c3803646432="" size="small" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-light md ion-activatable ion-focusable fab-button-small" color="light"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="git-commit"></ion-icon></ion-fab-button><!----><ion-fab-list _ngcontent-ng-c3803646432="" side="bottom" class="md fab-list-side-bottom"><ion-fab-button _ngcontent-ng-c3803646432="" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-success md fab-button-in-list ion-activatable ion-focusable" color="success"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="logo-apple-ar"></ion-icon></ion-fab-button><!----><ion-fab-button _ngcontent-ng-c3803646432="" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-primary md fab-button-in-list ion-activatable ion-focusable" color="primary"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="accessibility"></ion-icon></ion-fab-button><!----><!----></ion-fab-list></ion-fab><!----><!----></app-viewer-selector><!----></app-signed-language-output>
