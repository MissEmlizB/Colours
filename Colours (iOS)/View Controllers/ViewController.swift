//
//  ViewController.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit
import FlexColorPicker
import Hero


let vColourPicker = "To Colour Picker"
let vPalette = "To Generated Palette"

class ViewController: UIViewController {
	
	@IBOutlet weak var colourView: ColourView!
	@IBOutlet weak var colourSchemePicker: UIPickerView!
	
	weak var colourPicker: DefaultColorPickerViewController?
	weak var paletteNavController: UINavigationController?
	
	let availableColourSchemes: [String] = [
		"Monochromatic",
		"Complementary",
		"Split Complementary",
		"Triadic",
		"Tetradic",
		"Analogous"
	]

	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		//
		colourSchemePicker.dataSource = self
		colourSchemePicker.delegate = self
		
		//
		colourView.setup()
		
		//
		NotificationCenter.default.addObserver(self, selector: #selector(openColourPicker(_:)), name: nColourViewTapped, object: nil)
	}

	// MARK: Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == vColourPicker {
			
			let colour = self.colourView.colour!
			let destination = segue.destination as! DefaultColorPickerViewController
			
			//
			destination.delegate = self
			destination.selectedColor = colour
			
			destination.hero.isEnabled = true
			
			// colour picker animation
			if UIAccessibility.isReduceMotionEnabled {
				
				destination.hero.modalAnimationType = .fade
			}
			
			else {
				
				destination.view.hero.modifiers = [.cascade]
				
				destination.colorPalette.hero.modifiers =
					[.fade, .scale(0.5)]
						
				destination.colorPreview.hero.modifiers =
					[.fade, .translate(x: 0.0, y: -50.0)]
						
				destination.brightnessSlider.hero.modifiers =
					[.fade, .translate(x: -100, y: 0.0)]
			}
			
			self.colourPicker = destination
		}
		
		else if segue.identifier == vPalette {
			
			//
			let destination = segue.destination as! UINavigationController
			let controller = destination.topViewController as! GeneratedPaletteCollectionViewController
			
			//
			let schemeRow = colourSchemePicker.selectedRow(inComponent: 0)
			let schemeName = self.availableColourSchemes[schemeRow]
			
			controller.title = "\(schemeName) Palette"
			
			//
			self.paletteNavController = destination
			
			// create and pass the selected palette to our destination
			let colourScheme = ColourScheme(rawValue: schemeName.lowercased())!
			
			let palette = colourView.colour!
				.colour(withColourSchemeName: colourScheme)
			
			//
			controller.colours = palette
		}
	}
}

