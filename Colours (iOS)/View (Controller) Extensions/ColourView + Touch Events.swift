//
//  ColourView + Touch Events.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


extension ColourView {
	
	@objc func colourViewWasTapped(_ recogniser: UITapGestureRecognizer) {
		
		guard self.tappable else {
			return
		}
		
		if recogniser.state == .ended {

			NotificationCenter.default.post(name: nColourViewTapped,
											object: self,
											userInfo: nil)
			
			//
			self.animate(reversed: true)
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard self.tappable else {
			return
		}
		
		super.touchesBegan(touches, with: event)
		self.animate(reversed: false)
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard self.tappable else {
			return
		}
		
		super.touchesEnded(touches, with: event)
		self.animate(reversed: true)
	}
}
