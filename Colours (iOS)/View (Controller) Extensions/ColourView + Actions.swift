//
//  ColourView + Actions.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 24/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


extension ColourView {
	
	// MARK: Actions
	
	func setup() {
		
		guard !self.wasSetUp && self.tappable else {
			return
		}
		
		// detect taps in this view
		let recogniser = UITapGestureRecognizer(target: self, action: #selector((colourViewWasTapped(_:))))
				
		self.addGestureRecognizer(recogniser)
		
		//
		self.setupAppearance()
		
		//
		self.wasSetUp = true
		self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
	}
	
	// MARK: Appearance
	
	func setupAppearance() {
		
		var path: UIBezierPath!
			
		switch shape {
				
			case .roundedRectangle:
				path = UIBezierPath(roundedRect: self.bounds,
									byRoundingCorners: .allCorners,
									cornerRadii: CGSize(width: 32, height: 32))
				
			case .circle:
				path = UIBezierPath(ovalIn: self.bounds)
		}
		
		self.shapeLayer = CAShapeLayer()
		
		self.shapeLayer.path = path.cgPath
		self.shapeLayer.lineWidth = 2.0
		
		self.updateAppearance()
		self.layer.addSublayer(self.shapeLayer)
		
		// respond appropriately to any changes to the user's accessibility settings
		NotificationCenter.default.addObserver(self, selector: #selector(accessibilityContrastChanged(_:)), name: UIAccessibility.darkerSystemColorsStatusDidChangeNotification, object: nil)
	}
	
	func updateOutline() {
		
		// add a subtle outline in high contrast mode
		if UIAccessibility.isDarkerSystemColorsEnabled {
			self.shapeLayer.strokeColor = self.colour.shadow(withLevel: 0.5)?.cgColor
		}
		
		else {
			self.shapeLayer.strokeColor = nil
		}
	}
	
	func updateAppearance() {
		
		CATransaction.begin()
		CATransaction.setAnimationDuration(0)
		
		self.shapeLayer.fillColor = self.colour.cgColor
		self.updateOutline()
		
		CATransaction.commit()
	}
	
	// MARK: Notification Centre
	
	@objc func accessibilityContrastChanged(_ notification: NSNotification) {
		
		self.updateOutline()
	}
}
