//
//  ColourView + Animations.swift
//  Colours
//
//  Created by Emily Blackwell on 23/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


extension ColourView {
	
	// MARK: Main Animation
	
	func animate(a: CGFloat, b: CGFloat, reversed: Bool, duration: CFTimeInterval, completion: (() -> ())? = nil) {
		
		// only play animations if the 'reduce motion' setting is disabled
		guard NSAccessibility.animationsEnabled else {
			
			completion?()
			return
		}
		
		CATransaction.begin()
		
		CATransaction.setCompletionBlock {
			completion?()
		}
		
		// transform animation //
		
		let animation = CASpringAnimation(keyPath:
			#keyPath(CALayer.transform))
		
		//
		animation.isRemovedOnCompletion = true
		
		let from = CATransform3DMakeScale(a, a, a)
		let to = CATransform3DMakeScale(b, b, b)
		
		animation.fromValue = from
		animation.toValue = to
		
		// opacity animation //
		
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration * 0.5)

		let opacity = CABasicAnimation(keyPath:
			#keyPath(CALayer.opacity))
		
		//
		opacity.isRemovedOnCompletion = true
		
		if reversed {
			
			opacity.fromValue = 1.0
			opacity.toValue = 0.0
			
			self.layer!.opacity = 0.0
		}
		
		else {

			opacity.fromValue = 0.0
			opacity.toValue = 1.0
			
			self.layer!.opacity = 1.0
		}
	
		opacity.run(forKey: "opacity",
					object: self.layer!,
					arguments: [:])
		
		CATransaction.commit()
	
		//
		self.layer!.transform = to
		
		animation.run(forKey: "transform",
					  object: self.layer!,
					  arguments: [:])

		//
		CATransaction.setAnimationDuration(animation.settlingDuration)
		CATransaction.commit()
	}
	
	// MARK: Interaction Animation
	
	func interactionAnimation(reversed: Bool, a: Float = 0.5, b: Float = 1.0) {
		
		guard NSAccessibility.animationsEnabled else {
			return
		}
		
		CATransaction.begin()
	
		let hover = CABasicAnimation(keyPath:
			#keyPath(CALayer.opacity))
		
		hover.isRemovedOnCompletion = true
		
		//
		
		if reversed {
			
			hover.fromValue = b
			hover.toValue = a
			
			self.layer!.opacity = a
		}
		
		else {
			
			hover.fromValue = a
			hover.toValue = b
			
			self.layer!.opacity = b
		}
		
		//
		hover.run(forKey: "transform",
				  object: self.layer!,
				  arguments: nil)
		
		CATransaction.setAnimationDuration(0.25)
		CATransaction.commit()
	}
}
