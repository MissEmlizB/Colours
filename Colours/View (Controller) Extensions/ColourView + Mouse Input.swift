//
//  ColourView + Mouse Input.swift
//  Colours
//
//  Created by Emily Blackwell on 17/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


let nColourViewSelected = NSNotification.Name(rawValue: "colourViewWasSelected")
let kColour = "colour"

extension ColourView {
	
	// MARK: Tracking Area
	
	override func updateTrackingAreas() {
		
		let options: NSTrackingArea.Options =
			[.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
		
		let trackingArea = NSTrackingArea(rect: self.bounds,
										  options: options,
										  owner: self,
										  userInfo: nil)
		
		self.addTrackingArea(trackingArea)
	}
	
	// MARK: Mouse Events
	
	override func mouseEntered(with event: NSEvent) {
		
		guard self.clickable else {
			return
		}
		
		//
		self.interactionAnimation(reversed: true)
		
		self.isHighlighted = true
		self.setNeedsDisplay(self.bounds)
		
		NSCursor.pointingHand.set()
	}
	
	override func mouseExited(with event: NSEvent) {
		
		guard self.clickable else {
			return
		}
		
		//
		self.interactionAnimation(reversed: false)
		
		self.isHighlighted = false
		self.setNeedsDisplay(self.bounds)
		
		NSCursor.arrow.set()
	}
	
	override func mouseDown(with event: NSEvent) {
		
		guard self.clickable else {
			return
		}
		
		self.interactionAnimation(reversed: true, a: 0.35, b: 0.5)
	}
	
	override func mouseUp(with event: NSEvent) {
		
		guard self.clickable else {
			return
		}
		
		self.interactionAnimation(reversed: false, a: 0.35, b: 0.5)
		
		NotificationCenter.default.post(name: nColourViewSelected,
										object: self,
										userInfo: [kColour: self.colour])
	}
}
