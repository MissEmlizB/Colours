//
//  ViewController + Colour Picker Delegate.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit
import FlexColorPicker


extension ViewController: ColorPickerDelegate {
	
	func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {

	}
	
	func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
		
		self.colourView.colour = selectedColor
		self.colourView.setNeedsDisplay()
	}
}
