//
//  ColourDetailView + Actions.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 22/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit
import Hero


extension ColourDetailViewController {
	
	func setName(name: String?) {
		
		//
		progressIndicator.stopAnimating()
		colourNameLabel.isHidden = false
		
		//
		guard let name = name else {
			
			let text = NSLocalizedString("err-cnu", comment: "")
			colourNameLabel.text = text
			
			return
		}
		
		//
		colourNameLabel.text = name
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		
		super.viewWillDisappear(animated)
		self.dataTask?.cancel()
	}
	
	// MARK: IB Actions
	
	@IBAction func dismissVC(sender: AnyObject) {
		
		self.dismiss(animated: !UIAccessibility.isReduceMotionEnabled) {
			self.cell?.colourView.hero.id = ""
			self.cell?.colourLabel.hero.id = ""
		}
	}
	
	@IBAction func interactiveDismiss(sender: UIPanGestureRecognizer) {
		
		let translation = sender.translation(in: self.view)
		
		let yp = abs((translation.y) / (self.view.bounds.height / 2))
		let xp = abs((translation.x) / (self.view.bounds.width / 2))
		
		//
		switch sender.state {
			
		case .began:
			
			self.dismiss(animated: !UIAccessibility.isReduceMotionEnabled,
						 completion: nil)
			
		case .changed:
			
			let translation = CGPoint(x: colourView.frame.origin.x - xp,
									  y: colourView.frame.origin.y + translation.y)
			
			// allow the user to interact with the transition
			Hero.shared.update((xp + yp) / 2)
			Hero.shared.apply(modifiers: [.translate(translation)], to: colourView)
			
		case .ended:
			
			// depending on their progress, either finish or cancel the transition
			if yp > 0.25 || xp > 0.55 {
				
				Hero.shared.finish()
				self.cell?.colourView.hero.id = ""
				self.cell?.colourLabel.hero.id = ""
			}
			
			else {
				Hero.shared.cancel()
			}
			
		case .failed, .cancelled:
			Hero.shared.cancel()
			
		default:
			break
		}
	}
}
