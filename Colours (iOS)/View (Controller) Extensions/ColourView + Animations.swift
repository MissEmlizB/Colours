//
//  ColourView + Animations.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 23/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


extension ColourView {
	
	func animate(reversed: Bool) {
		
		//
		let a = CATransform3DMakeScale(0.925, 0.925, 0.925)
		let b = CATransform3DMakeScale(1.0, 1.0, 1.0)
		
		// make the view bounce whenever it gets tapped
		CATransaction.begin()

		//
		let bounce = CASpringAnimation(keyPath: #keyPath(CALayer.transform))
		bounce.isRemovedOnCompletion = true
		
		if reversed {
			bounce.fromValue = a
			bounce.toValue = b
			
			self.layer.transform = b
		}
		
		else {
			bounce.fromValue = b
			bounce.toValue = a
			
			self.layer.transform = a
		}
		
		//
		bounce.run(forKey: "transform",
				   object: self.layer,
				   arguments: nil)
		
		//
		CATransaction.setAnimationDuration(bounce.settlingDuration)
		CATransaction.commit()
	}
}
