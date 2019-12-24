//
//  ColourView.swift
//  Colours
//
//  Created by Emily Blackwell on 17/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


@IBDesignable
class ColourView: NSView {
	
	@IBInspectable var clickable: Bool = true
	
	@IBInspectable var colour: NSColor = .black {
		didSet {
			self.toolTip = hex(forColour: self.colour)
		}
	}
	
	var isHighlighted: Bool = false
	
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		
		//
		let highContrastEnabled = NSAccessibility.highContrastMode

        // Draw a simple filled rectangle with the given colour
		let path = NSBezierPath(roundedRect: self.bounds,
								xRadius: 8, yRadius: 8)
		
		self.colour.setFill()
		path.fill()
		
		// draw an outline in increased contrast mode
		if !self.isHighlighted && highContrastEnabled {
			
			path.lineWidth = 4.0
			
			self.colour.shadow(withLevel: 0.5)?.setStroke()
			path.stroke()
		}
		
		// draw a selection outline in reduced motion and/or increased contrast mode
		guard !NSAccessibility.animationsEnabled || highContrastEnabled else {
			return
		}
		
		// highlighting outline
		if self.isHighlighted {
			
			path.lineWidth = 8.0
			path.lineJoinStyle = .round
			path.lineCapStyle = .butt
			
			NSColor.controlColour.setStroke()
			path.stroke()
		}
    }
	
	func setup(delay: TimeInterval = 0.0) {
		
		self.wantsLayer = true
		
		self.layerContentsPlacement = .scaleAxesIndependently
		self.layerContentsRedrawPolicy = .onSetNeedsDisplay
		
		self.layer!.anchorPoint = CGPoint(x: 0.5, y: -0.5)
		
		// animation //
		
		guard animationIsEnabled() else {
			return
		}
		
		self.layer!.opacity = 0.0
		
		// delay our animation (if a delay was provided, ofc)
		Timer.scheduledTimer(timeInterval: delay,
							 target: self,
							 selector: #selector(appear(_:)),
							 userInfo: nil,
							 repeats: false)
	}

	/// Use this animation when you add the colour view to a superview.
	@objc func appear(_ sender: AnyObject) {
		
		self.animate(a: 0.0, b: 1.0, reversed: false, duration: 0.9) {
			
			DispatchQueue.main.async {
				self.setNeedsDisplay(self.bounds)
			}
		}
	}
	
	/// Use this to animate the removal of this colour view from its superview.
	func remove(completion: (() -> ())? = nil) {
		
		// stop any running animations before continuing
		self.layer!.removeAllAnimations()
				
		self.animate(a: 1.0, b: 0.0, reversed: true, duration: 0.65) {
			self.removeFromSuperview()
			completion?()
		}
	}
}
