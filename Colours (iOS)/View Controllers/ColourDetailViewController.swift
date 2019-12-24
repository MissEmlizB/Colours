//
//  ColourDetailViewController.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 22/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit
import Hero

class ColourDetailViewController: UIViewController {

	@IBOutlet weak var colourView: ColourView!
	@IBOutlet weak var colourNameLabel: UILabel!
	@IBOutlet weak var rgbLabel: UILabel!
	@IBOutlet weak var hexLabel: UILabel!
	@IBOutlet weak var progressIndicator: UIActivityIndicatorView!
	
	weak var cell: PaletteCellCollectionViewCell?
	
	var dataTask: URLSessionDataTask?
	var colour: UIColor!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let rgbRepresentation = rgb(forColour: self.colour)
		let hexRepresentation = hex(forColour: self.colour)
		
		colourView.colour = self.colour
		colourView.setupAppearance()
		
		rgbLabel.text = rgbRepresentation
		hexLabel.text = hexRepresentation
		
		//
		let session = AppDelegate.getURLSession()
		
		self.dataTask = name(forColour: self.colour, usingSession: session) { name in
			
			DispatchQueue.main.async {
				self.setName(name: name)
			}
		}
    }
}
