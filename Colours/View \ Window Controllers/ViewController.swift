//
//  ViewController.swift
//  Colours
//
//  Created by Emily Blackwell on 16/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
	
	@IBOutlet weak var colourStackView: NSStackView!
	@IBOutlet weak var colourWell: NSColorWell!
	@IBOutlet weak var colourScheme: NSComboBox!
	
	var colourViews: [ColourView] = []

	override func viewDidLoad() {
		super.viewDidLoad()
	
		//
		NotificationCenter.default.addObserver(self, selector: #selector((openDetailPopover(_:))), name: nColourViewSelected, object: nil)
	}
	
	// MARK: Touchbar Colour Picker
	
	weak var touchbarColourPicker: AnyObject! {
		didSet {
			
			// touch bar colour picker
			if #available(macOS 10.12.2, *) {
				
				let picker = touchbarColourPicker as! NSColorPickerTouchBarItem
				
				// update our colour well if the user picks a colour from the touch bar
				picker.target = self
				picker.action = #selector((touchbarColourSelected(_:)))
				
				// colours picked from the colour well will update the touch bar, as well
				NotificationCenter.default.addObserver(self, selector: #selector(colourSelectedOnWell(_:)), name: NSColorPanel.colorDidChangeNotification, object: nil)
			}
		}
	}
	
	@available (macOS 10.12.2, *)
	var TouchbarColourPicker: NSColorPickerTouchBarItem {
		get {
			return touchbarColourPicker as! NSColorPickerTouchBarItem
		}
	}
}

