//
//  GeneratedPaletteCollectionViewController.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit
import Hero


private let reuseIdentifier = "colourCell"
let vDetail = "To Colour Detail"

class GeneratedPaletteCollectionViewController: UICollectionViewController {
	
	var colours: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Data Source

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
		return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return self.colours.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PaletteCellCollectionViewCell
    
        // Configure the cell
		let colour = self.colours[indexPath.item]
		
		cell.colourView.colour = colour
		cell.colourLabel.text = hex(forColour: colour)
		
		// cell animation
		if UIAccessibility.isReduceMotionEnabled {
			cell.hero.modifiers = []
		}
		
		else {
			cell.hero.modifiers = [.fade, .scale(0.5)]
		}
    
        return cell
    }
	
	// MARK: Delegate
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let reducedMotionIsEnabled = UIAccessibility.isReduceMotionEnabled
		
		//
		let cell = collectionView.cellForItem(at: indexPath) as! PaletteCellCollectionViewCell
		
		cell.colourView.hero.id = "colourView"
		cell.colourLabel.hero.id = "hexLabel"

		//
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let detailVC = storyboard.instantiateViewController(withIdentifier: "Colour Detail") as! ColourDetailViewController
		
		//
		let colour = self.colours[indexPath.item]
		detailVC.colour = colour
		detailVC.cell = cell

		// transition animation
		
		if reducedMotionIsEnabled {
			detailVC.hero.isEnabled = false
			detailVC.hero.modalAnimationType = .fade
		}
		
		else {
			detailVC.hero.isEnabled = true
			detailVC.hero.modalAnimationType = .auto
		}
		
		//
		self.present(detailVC, animated: !reducedMotionIsEnabled)
	}
}

extension GeneratedPaletteCollectionViewController: UICollectionViewDelegateFlowLayout {

	// MARK: Layout
	// https://bit.ly/34Lmdag
	
	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		
		let aspectRatio: CGFloat = 268 / 265
		
		let width = self.view.frame.width / 4
		let height = width * aspectRatio
		
		print("\(width)x\(height)")
		
		return CGSize(width: width, height: height)
	}
}
