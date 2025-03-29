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
    
    public func makeScript() -> String {
        switch self {
        case .textInjectHideTextField(let text):
//            return """
//                (function() {
//                    const textarea = document.getElementById('desktop');
//                    if (textarea) {
//                        // Hide the textarea
//                        textarea.style.display = 'none';
//
//                        // Set the value
//                        textarea.value = `\(text)`;
//
//                        // Dispatch input event to simulate user typing
//                        const inputEvent = new Event('input', { bubbles: true });
//                        textarea.dispatchEvent(inputEvent);
//
//                        // Optional: focus and blur to trigger Angular/React listeners if needed
//                        textarea.focus();
//                        textarea.blur();
//                    }
//                })();
//                """
//            return """
//    (function() {
//        // Handle the desktop textarea
//        const textarea = document.getElementById('desktop');
//        if (textarea) {
//            textarea.style.display = 'none';
//            textarea.value = `\(text)`;
//            const inputEvent = new Event('input', { bubbles: true });
//            textarea.dispatchEvent(inputEvent);
//            textarea.focus();
//            textarea.blur();
//        }
//
//        // Hide the actions row (just make it invisible)
//        const actionsRow = document.querySelector('div.actions-row');
//        if (actionsRow) {
//            actionsRow.style.opacity = '0';
//        }
//    })();
//    """
            return """
    (function() {
        // 1. Hide the desktop textarea and inject text
        const desktop = document.getElementById('desktop');
        if (desktop) {
            desktop.style.display = 'none';
            desktop.value = `\(text)`;
            const inputEvent = new Event('input', { bubbles: true });
            desktop.dispatchEvent(inputEvent);
            desktop.focus();
            desktop.blur();
        }

        // 2. Hide the actions row (set opacity to 0)
        const actionsRow = document.querySelector('div.actions-row');
        if (actionsRow) {
            actionsRow.style.opacity = '0';
        }

        // 3. Hide the ion-footer (mobile text input area)
        const footer = document.querySelector('ion-footer');
        if (footer) {
            footer.style.display = 'none';
        }
    })();
    """

        case .textInjectMobile(let text):
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
                isolateSignedLanguageComponent();
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
            return """
            (function() {
                          function hideOthers() {
                            var target = document.querySelector('app-signed-language-output');
                            if (target) {
                              // Iterate over all direct children of the body.
                              var children = document.body.children;
                              for (var i = 0; i < children.length; i++) {
                                if (children[i] !== target) {
                                  children[i].style.display = 'none';
                                }
                              }
                              // Ensure the target is visible.
                              target.style.display = 'block';
                              return true;
                            }
                            return false;
                          }
                          // Try to hide immediately.
                          if (!hideOthers()) {
                            // If not yet available, observe for changes.
                            var observer = new MutationObserver(function(mutations, obs) {
                              if (hideOthers()) {
                                obs.disconnect();
                              }
                            });
                            observer.observe(document, { childList: true, subtree: true });
                          }
                        })();
            """
        }
    }
}

//<app-signed-language-output _ngcontent-ng-c1716417655="" _nghost-ng-c2028080701=""><video _ngcontent-ng-c2028080701="" autoplay="" loop="" muted="" playsinline="" height="100%" width="100%" src="blob:https://sign.mt/4dff889f-c5d1-4f98-8b69-2ef7d8534015"></video><!----><!----><div _ngcontent-ng-c2028080701="" class="actions-row"><ion-button _ngcontent-ng-c2028080701="" fill="clear" shape="round" color="dark" class="mat-mdc-tooltip-trigger circle-icon ion-color ion-color-dark md button button-round button-clear button-has-icon-only ion-activatable ion-focusable"><ion-icon _ngcontent-ng-c2028080701="" name="download-outline" slot="icon-only" role="img" class="md"></ion-icon></ion-button><!----><ion-button _ngcontent-ng-c2028080701="" fill="clear" shape="round" color="dark" class="mat-mdc-tooltip-trigger circle-icon ion-color ion-color-dark md button button-round button-clear button-has-icon-only ion-activatable ion-focusable"><ion-icon _ngcontent-ng-c2028080701="" ios="share-outline" md="share-social-outline" slot="icon-only" role="img" class="md"></ion-icon></ion-button><!----><!----><!----><!----></div><app-viewer-selector _ngcontent-ng-c2028080701="" _nghost-ng-c3803646432=""><ion-fab _ngcontent-ng-c3803646432="" id="viewer-selector" class="md"><ion-fab-button _ngcontent-ng-c3803646432="" size="small" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-light md ion-activatable ion-focusable fab-button-small" color="light"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="git-commit"></ion-icon></ion-fab-button><!----><ion-fab-list _ngcontent-ng-c3803646432="" side="bottom" class="md fab-list-side-bottom"><ion-fab-button _ngcontent-ng-c3803646432="" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-success md fab-button-in-list ion-activatable ion-focusable" color="success"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="logo-apple-ar"></ion-icon></ion-fab-button><!----><ion-fab-button _ngcontent-ng-c3803646432="" mattooltipposition="before" class="mat-mdc-tooltip-trigger ion-color ion-color-primary md fab-button-in-list ion-activatable ion-focusable" color="primary"><ion-icon _ngcontent-ng-c3803646432="" role="img" class="md" name="accessibility"></ion-icon></ion-fab-button><!----><!----></ion-fab-list></ion-fab><!----><!----></app-viewer-selector><!----></app-signed-language-output>
