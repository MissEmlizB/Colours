//
//  ColourView.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


let nColourViewTapped = NSNotification.Name(rawValue: "colourViewWasTappedNotification")

/// Tihs determines a colour view's appearance
@objc enum ColourViewShape: Int {
	case roundedRectangle = 0
	case circle = 1
}

@IBDesignable
class ColourView: UIView {

	@IBInspectable var colour: UIColor! = .systemBlue {
		didSet {
			
			// for appearance-only colour views,
			// create their shape layer minus its touch recogniser
			
			if !wasSetUp {
				self.setupAppearance()
				self.wasSetUp = true
			}
			
			// update its appearance
			self.updateAppearance()
		}
	}
	
	@IBInspectable var tappable: Bool = true
	@IBInspectable var shape: ColourViewShape = .roundedRectangle
	var shapeLayer: CAShapeLayer!
	
	var wasSetUp = false
}
