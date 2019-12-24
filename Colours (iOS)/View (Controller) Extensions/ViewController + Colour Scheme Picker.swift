//
//  ViewController + Colour Scheme Picker.swift
//  Colours (iOS)
//
//  Created by Emily Blackwell on 21/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import UIKit


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	
	// MARK: Data Source
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		
		return self.availableColourSchemes.count
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	// MARK: Delegate
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		
		return self.availableColourSchemes[row]
	}
}
