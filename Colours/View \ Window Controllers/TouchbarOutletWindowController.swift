//
//  TouchbarOutletWindowController.swift
//  Colours
//
//  Created by Emily Blackwell on 24/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


class TouchbarOutletWindowController: NSWindowController {

	@IBOutlet weak var touchbarColourPicker: AnyObject!
	
	override func windowDidLoad() {
	
		super.windowDidLoad()
		
		//
		let viewController = self.contentViewController as! ViewController
		viewController.touchbarColourPicker = touchbarColourPicker
	}
}
