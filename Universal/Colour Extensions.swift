//
//  Colour Extensions.swift
//  Colours
//
//  Created by Emily Blackwell on 17/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

#if os(macOS)

import Cocoa
typealias Colour = NSColor

#elseif os(iOS)

import UIKit
typealias Colour = UIColor

// apparently, UIKit doesn't have Cocoa's colour blending functions
extension UIColor {
	
	/// Get this colour's red, green, and blue components
	var UIRGB: [CGFloat] {
        get {
            var red:	CGFloat = 0.0
            var green:	CGFloat = 0.0
            var blue:	CGFloat = 0.0
            
            self.getRed(&red,
						green: &green,
						blue: &blue,
						alpha: nil)
            
            return [red, green, blue]
        }
    }
	
	/// Mix two colours together
	/// - Parameter a: The main colour
	/// - Parameter b: The colour to add
	/// - Parameter factor: How much of b should be added to a (0.0 - 1.0)
	func mix(a: UIColor, b: UIColor, factor: CGFloat) -> UIColor {
		
		let strengthB = factor.withBoundaries(min: 0.0, max: 1.0)
		let strengthA = 1.0 - strengthB
        
        let aRGB = a.UIRGB
        let bRGB = b.UIRGB
		        
		// blend the colours together (factor determines B's strength)
        let frgb = zip(aRGB, bRGB)
			.map { ($0 * strengthA) + ($1 * strengthB) }
				
		//
        let mixedColour = UIColor(red: frgb[0],
								  green: frgb[1],
								  blue: frgb[2],
								  alpha: 1.0)
        
        return mixedColour
    }
	
	/// Get a lighter variant of this colour
	/// - Parameter level: How much white should be added to this colour
    func highlight(withLevel level: CGFloat) -> UIColor! {
        
        return self.mix(a: self, b: .white, factor: level)
    }
	
	/// Get a darker variant of this colour
	/// - Parameter level: How much black should be added to this colour
    func shadow(withLevel level: CGFloat) -> UIColor! {
        
        return self.mix(a: self, b: .black, factor: level)
    }
	
	/// Get this colour's brightness value
	var brightnessComponent: CGFloat {
        get {
            var brightness: CGFloat = 0.0
            
            self.getHue(nil,
                        saturation: nil,
                        brightness: &brightness,
                        alpha: nil)
            
            return brightness
        }
    }
}

#endif


/// This decides how the generator picks colours for its palette
enum ColourScheme: String {
	case monochromatic = "monochromatic"
	case complementary = "complementary"
	case splitComplementary = "split complementary"
	case triadic = "triadic"
	case tetradic = "tetradic"
	case analogous = "analogous"
}


extension Colour {
	
	// MARK: Colour Properties
	
	#if os(macOS)
	
	/// This property returns the user's selected accent colour in macOS Mojave or later;
	/// or the standard system blue colour in earlier versions.
	static var controlColour: NSColor {
		get {
			if #available(macOS 10.14, *) {
				return .controlAccentColor
			} else {
				return .systemBlue
			}
		}
	}
	
	#endif
	
	/// Get this colour's hue, saturation, lightness, and alpha properties.
	/// This returns four zeroes if colourspace conversation fails.
	var hsla: [CGFloat] {
		get {
			
			#if os(macOS)
			
			// Convert colour to the RGB colourspace in macOS.
			guard let colour = self.usingColorSpaceName(.deviceRGB) else {
				return [0.0, 0.0, 0.0, 0.0]
			}
			
			#else
			let colour = self
			#endif

			//
			var hue: 			CGFloat = 0.0
			var saturation: 	CGFloat = 0.0
			var lightness: 		CGFloat = 0.0
			var alpha:			CGFloat = 0.0
			
			//
			colour.getHue(&hue,
						  saturation: &saturation,
						  brightness: &lightness,
						  alpha: &alpha)
			
			//
			return [hue, saturation, lightness, alpha]
		}
	}
	
	/// Get this colour's red, green, blue components
	/// this returns three zeroes, if colourspace conversion fails
	var rgb: [CGFloat] {
		get {
			
			#if os(macOS)
			
			guard let colour = self.usingColorSpace(.deviceRGB) else {
				return [0, 0, 0]
			}
			
			//
			return [
				colour.redComponent,
				colour.greenComponent,
				colour.blueComponent
			]
			
			#elseif os(iOS)
			
			return self.UIRGB
			
			#endif
		}
	}
	
	/// This function creates a new HSL colour based on a given offset.
	/// - Parameter offset: Offset from the original hue
	func colour(withHueOffset offset: CGFloat) -> Colour {
		
		let hsla = self.hsla
		let angle = fmod(hsla[0] + offset, 1)
		
		return Colour(hue: angle,
					   saturation: hsla[1],
					   brightness: hsla[2],
					   alpha: hsla[3])
	}
	
	// MARK: Colour Schemes
	// https://bit.ly/34woUwF
	
	/// This generates a palette consisting of the various tones and shades of the same colour
	var monochromatic: [Colour] {
		get {
			var colours: [Colour] = []
			
			for level in 1 ..< 7 {
				
				let level = CGFloat(level) / 7
				
				guard let colourA = self.highlight(withLevel: level),
					let colourB = self.shadow(withLevel: level) else {
						continue
				}
				
				colours.append(colourA)
				colours.append(colourB)
			}
			
			return colours.sorted {
				return $0.brightnessComponent < $1.brightnessComponent
			}
		}
	}
	
	/// This generates a two-colour palette consisting of opposite colours on the colour wheel
	var complementary: [Colour] {
		get {
			return [
				self,
				colour(withHueOffset: 0.5)
			]
		}
	}
	
	/// This generates a three-colour palette consisting of the base colour and two adjacent colours on the colour wheel.
	var splitComplementary: [Colour] {
		get {
			return [
				self,
				colour(withHueOffset: 0.416),
				colour(withHueOffset: 0.583)
			]
		}
	}
	
	/// This generates a three-colour palette using evenly-spaced colours on the colour wheel.
	var triadic: [Colour] {
		get {
			return [
				self,
				colour(withHueOffset: 0.333),
				colour(withHueOffset: 0.666)
			]
		}
	}
	
	/// This generates a four-colour palette using two complementary pairs.
	var tetradic: [Colour] {
		get {
			return [
				self,
				colour(withHueOffset: 0.25),
				self.complementary[1],
				colour(withHueOffset: 0.75)
			]
		}
	}
	
	/// This generates  three-colour palette using colours that are next to one another on the colour wheel.
	var analogous: [Colour] {
		get {
			return [
				self,
				colour(withHueOffset: -0.0833),
				colour(withHueOffset: 0.0833)
			]
		}
	}
	
	/// This function returns an array of colours based on a given colour scheme name
	/// - Parameter name: complementary, tetradic, etc.
	func colour(withColourSchemeName scheme: ColourScheme) -> [Colour] {
		
		switch scheme {
		case .monochromatic:
			return self.monochromatic
			
		case .complementary:
			return self.complementary
			
		case .splitComplementary:
			return self.splitComplementary
			
		case .triadic:
			return self.triadic
			
		case .tetradic:
			return self.tetradic
			
		case .analogous:
			return self.analogous
		}
	}
}
