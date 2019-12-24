//
//  Colour Name Info.swift
//  Colours
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

#if os(macOS)

import Cocoa

#elseif os(iOS)

import UIKit

#endif


// Colour identification by 'The Color API'
// https://www.thecolorapi.com

fileprivate let ColourAPIURL = "https://www.thecolorapi.com/id"

	
/// Get the closest name for a colour (requires an active internet connection)
/// - Parameter colour: Hmm, I wonder what this parameter could be...
/// - Parameter session: The URL session to use for our data task.
/// - Parameter completion: The block to call when the name becomes available (optional).
func name(forColour colour: Colour, usingSession session: URLSession, completion: ((String?) -> ())? = nil) -> URLSessionDataTask? {
	
	guard let url = apiURL(forColour: colour) else {
		
		completion?(nil)
		return nil
	}
	
	//	
	let request = URLRequest(url: url,
							 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
							 timeoutInterval: 30)
	
	//
	let task = session.dataTask(with: request) { data, _, error in
		
		guard let data = data, error == nil else {
			completion?(nil)
			return
		}
		
		// get the colour name from the response object
		let response = try? JSONSerialization
			.jsonObject(with: data, options: .allowFragments) as? [String: Any]
		
		let nameDict = response?["name"] as? [String: Any]
		let name = nameDict?["value"] as? String
		
		//
		completion?(name)
	}
	
	//
	task.resume()
	
	return task
}

/// Get a URL to use for a name identification request.
/// - Parameter colour: The colour to use
func apiURL(forColour colour: Colour) -> URL? {
	
	let hexRepresentation = hex(forColour: colour, withSymbol: false)
	
	//
	var components = URLComponents(string: ColourAPIURL)
	
	let hexParameter = URLQueryItem(name: "hex", value: hexRepresentation)
	components?.queryItems = [hexParameter]
	
	return components?.url
}

/// Get the hexadecimal value for a colour. (#rrggbb)
/// - Parameter colour: The colour to
func hex(forColour colour: Colour, withSymbol ws: Bool = true) -> String {
	
	// convert its components into their hexadecimal representations
	let rgb: String = colour.rgb
		.map { $0 * 255 }
		.map { $0.hexadecimalRepresentation }
		.joined()
	

	//
	return "\(ws ? "#" : "")\(rgb)"
}

/// Shows a colour in this format: rgb(r, g, b)
/// - Parameter colour: The colour to use
func rgb(forColour colour: Colour) -> String {
	
	let rgb = colour.rgb
		.map { String(Int($0 * 255)) }
		.joined(separator: ", ")
	
	return "rgb(\(rgb))"
}
