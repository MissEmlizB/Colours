//
//  CG Extensions.swift
//  Colours
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import CoreGraphics


extension CGFloat {
	
	/// Returns the hexadecimal representation of this thing. (surprised pikachu)
	var hexadecimalRepresentation: String {
		get {
			
			// Does it need a zero prefix?
			let nz = self < 16
			let hexString = String(Int(self), radix: 16)
			
			return (nz ? "0" : "") + hexString
		}
	}
	
	/// Restrict this float's value range.
	/// - Parameter min: The lowest value this float can have.
	/// - Parameter max: The highest value this float can have.
	func withBoundaries(min: CGFloat, max: CGFloat) -> CGFloat {
		
		var float = self
		
		if float < min {
			float = min
		}
		
		if float > max {
			float = max
		}
		
		return float
	}
}
