//
//  ColourDetailViewController.swift
//  Colours
//
//  Created by Emily Blackwell on 17/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


let kDetailID = "Colour Detail"

class ColourDetailViewController: NSViewController {
	
	@IBOutlet weak var colourView: ColourView!
	@IBOutlet weak var colourNameLabel: NSTextField!
	@IBOutlet weak var hexColourLabel: NSTextField!
	@IBOutlet weak var rgbColourLabel: NSTextField!
	@IBOutlet weak var processingIndicator: NSProgressIndicator!
	
	weak var dataTask: URLSessionDataTask?
	var colour: NSColor!

    override func viewDidLoad() {
        
		super.viewDidLoad()
		
		//
		colourView.colour = colour
		
		// colour information
		let hexRepresentation = hex(forColour: colour)
		let rgbRepresentation = rgb(forColour: colour)
		
		hexColourLabel.stringValue = hexRepresentation
		rgbColourLabel.stringValue = rgbRepresentation
		
		//
		self.setNameLabel(name: "")
		
		// Identify its name using 'The Color API'
		
		processingIndicator.isHidden = false
		processingIndicator.startAnimation(self)
		
		//
		let session = AppDelegate.getURLSession()
		
		self.dataTask = name(forColour: colour, usingSession: session) { name in
			
			DispatchQueue.main.async {
				self.setNameLabel(name: name ?? "err-cnu".l)
			}
		}
    }
	
	override func viewWillDisappear() {
		
		super.viewWillDisappear()
		
		// cancel any running tasks
		self.dataTask?.cancel()
	}
	
	// MARK: Name Label
	
	func setNameLabel(name: String?) {
		
		//
		processingIndicator.isHidden = true
		processingIndicator.stopAnimation(self)

		//
		colourNameLabel.isHidden = (name == nil)
		colourNameLabel.stringValue = name ?? ""
	}
}
