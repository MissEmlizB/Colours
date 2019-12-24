//
//  AppDelegate.swift
//  Colours
//
//  Created by Emily Blackwell on 16/12/2019.
//  Copyright © 2019 Emily Blackwell. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var session: URLSession!

	static func getURLSession() -> URLSession {
		
		let delegate = NSApp.delegate as! AppDelegate
		return delegate.session
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		// Insert code here to initialize your application
		session = URLSession(configuration: .ephemeral)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

