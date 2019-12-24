//
//  Cocoa Extensions.swift
//  Colours
//
//  Created by Emily Blackwell on 18/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


// MARK: Shortcuts

let AlertDefaultButtons = ["Ok"]

extension NSViewController {
	
	/// Show an alert modal to the user.
	/// - Parameter title: What is this alert about?
	/// - Parameter message: Add more details about the alert's subject here.
	/// - Parameter style: How crucial is this alert?
	/// - Parameter buttons: What options does the user have to deal with this alert? (optional)
	/// - Parameter completion: What happens when the user selects an action? (optional)
	
	func alert(title: String, message: String, style: NSAlert.Style, buttons: [String]? = nil, completion: ((NSApplication.ModalResponse) -> ())? = nil) {
		
		let alertModal = NSAlert()
		
		//
		alertModal.messageText = title
		alertModal.informativeText = message
		alertModal.alertStyle = style
		
		if let buttons = buttons {
			// add custom alert buttons
			for button in buttons {
				alertModal.addButton(withTitle: button)
			}
		}
		
		else {
			// use our default "Ok" if no custom titles were provided
			alertModal.addButton(withTitle: "Ok")
		}
		
		//
		let response = alertModal.runModal()
		completion?(response)
	}
}

// MARK: Localisation

extension String {
	
	/// Localised version of this string
	var l: String {
		get {
			return NSLocalizedString(self, comment: "")
		}
	}
}

// MARK: Accessibility

/// Checks if the user has 'reduced motion' disabled in their preferences
func animationIsEnabled() -> Bool {
	
	if #available(macOS 10.12, *) {
		guard NSWorkspace.shared.accessibilityDisplayShouldReduceMotion else {
			return true
		}
	}
	
	return false
}

// MARK: Accessibility

extension NSAccessibility {
	
	/// Checks if the user has 'increase contrast' enabled in their preferences
	static var highContrastMode: Bool {
		get {
			return NSWorkspace.shared.accessibilityDisplayShouldIncreaseContrast
		}
	}
	
	/// Checks if the user has 'reduce motion' disabled in their preferences
	static var animationsEnabled: Bool {
		get {
			
			if #available(macOS 10.12, *) {
				guard NSWorkspace.shared.accessibilityDisplayShouldReduceMotion else {
					return true
				}
			}
			
			return false
		}
	}
}
