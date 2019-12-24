//
//  ViewController + Actions.swift
//  Colours
//
//  Created by Emily Blackwell on 17/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


extension ViewController {
	
	// MARK: View Actions
	
	func readjustStackView() {
		
		// only animate our stack view if 'reduce motion' is disabled
		if #available(macOS 10.12, *), NSAccessibility.animationsEnabled {
			NSAnimationContext.runAnimationGroup { context in
				context.duration = 0.35
				context.allowsImplicitAnimation = true
				
				self.colourStackView.window?.layoutIfNeeded()
			}
		}
		
		else {
			self.colourStackView.window?.layoutIfNeeded()
		}
	}
		
	func removeColourViews() {
		
		for view in self.colourViews {
			view.remove() {
				self.readjustStackView()
			}
		}
	}
	
	func addColourViews(fromColours colours: [NSColor]) {
		
		// Remove old colour views from the stack view
		self.removeColourViews()
		
		// Create and insert new colour views into the stack view
		for (i, colour) in colours.enumerated() {
			
			let colourView = ColourView()
			colourView.colour = colour
			
			self.colourStackView.addArrangedSubview(colourView)
			self.colourViews.append(colourView)
			
			colourView.setup(delay: (TimeInterval(i) * 0.045))
		}
		
		self.readjustStackView()
	}
	
	// MARK: IB Actions
	
	@IBAction func generateColourScheme(sender: AnyObject) {
		
		let colour = self.colourWell.color
		let schemeName = self.colourScheme.stringValue.lowercased()
		
		guard let scheme = ColourScheme(rawValue: schemeName) else {
			
			self.alert(title: "err-tCSN".l,
					   message: "err-mCSN".l,
					   style: .warning)
			
			return
		}
		
		let palette = colour.colour(withColourSchemeName: scheme)
		self.addColourViews(fromColours: palette)
	}
	
	@IBAction func switchColourScheme(sender: NSMenuItem) {
		
		colourScheme.selectItem(at: sender.tag)
	}
	
	@IBAction func changeColourScheme(sender: AnyObject) {
		
		let selectedRow = colourScheme.indexOfSelectedItem
		
		//
		switch sender.tag {
			
		// forward
		case 0:
			
			if selectedRow > 0 {
				colourScheme.selectItem(at: selectedRow - 1)
			}
			
		case 1:
			
			if selectedRow < 5 {
				colourScheme.selectItem(at: selectedRow + 1)
			}
			
		default:
			break
		}
	}
	
	// MARK: Notification Centre
	
	@available (macOS 10.12.2, *)
	@objc func touchbarColourSelected(_ notification: NSNotification) {
		
		self.colourWell.color = TouchbarColourPicker.color
	}
	
	@available (macOS 10.12.2, *)
	@objc func colourSelectedOnWell(_ notification: NSNotification) {
		
		TouchbarColourPicker.color = self.colourWell.color
	}
	
	@objc func openDetailPopover(_ notification: NSNotification) {
		
		//
		let colourView = notification.object as! ColourView
		let colour = notification.userInfo![kColour] as! NSColor
		
		//
		let storyboard = NSStoryboard(name: "Main", bundle: nil)
		
		let viewController = storyboard.instantiateController(withIdentifier: kDetailID) as! ColourDetailViewController
		
		viewController.colour = colour
		
		// open the detail popover below the selected colour view
		let popover = NSPopover()

		popover.contentViewController = viewController
		popover.behavior = .transient
		
		popover.show(relativeTo: colourView.bounds,
					 of: colourView,
					 preferredEdge: .minY)
	}
}
