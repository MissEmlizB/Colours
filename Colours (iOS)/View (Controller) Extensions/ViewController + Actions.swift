//
//  ViewController + Actions.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


extension ViewController {
	
	// MARK: Notification Centre
	
	@objc func openColourPicker(_ notification: NSNotification) {
		
		guard let object = notification.object as? ColourView,
			object.tag == 10 else {
				return
		}
		
		self.performSegue(withIdentifier: vColourPicker, sender: self)
	}
	
	// MARK: IB Actions
	
	@IBAction func closeColourPicker(sender: AnyObject) {
		
		let animated = !UIAccessibility.isReduceMotionEnabled
		self.colourPicker?.dismiss(animated: animated, completion: nil)
	}
	
	@IBAction func closePaletteView(sender: AnyObject) {
		
		let animated = !UIAccessibility.isReduceMotionEnabled
		self.paletteNavController?.dismiss(animated: animated, completion: nil)
	}
}
