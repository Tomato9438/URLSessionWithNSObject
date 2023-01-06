//
//  ViewController.swift
//  URLSessionCrazyMonkey
//
//  Created by Tomato on 2021/11/14.
//

import UIKit

class HomeViewController: UIViewController, ConnectMeDelegate {
	// MARK: - Variables
	
	
	// MARK: - IBOutlet
	@IBOutlet weak var sendButton: UIButton!
	@IBOutlet weak var connectButton: UIButton!
	
	
	// MARK: - IBAction
	let sessionConfiguration = URLSessionConfiguration.default
	@IBAction func sendTapped(_ sender: UIButton) {
		let urlStr = "https://www.google.com"
		let connectMe = ConnectMe(url: urlStr, waitTime: 5.0, senderIndex: 0)
		connectMe.connectMeDelegate = self
		connectMe.checkConnection()
		
		/*
		let urlStr = "https://www.google.com"
		if let url = URL(string: urlStr) {
			var request = URLRequest(url: url)
			request.timeoutInterval = 5.0
			let session = URLSession(configuration: sessionConfiguration)
			session.dataTask(with: request) { data, response, error in
				if let error = error {
					print("error: \(error.localizedDescription)")
				} else {
					if let httpResponse = response as? HTTPURLResponse {
						let statusCode = httpResponse.statusCode
						if statusCode == 200 {
							print("good")
						} else {
							print("bad")
						}
					}
				}
			}.resume()
		}
		*/
	}
	
	@IBAction func connectTapped(_ sender: UIButton) {
		let urlStr = "https://www.apple.com"
		let connectMe = ConnectMe(url: urlStr, waitTime: 5.0, senderIndex: 1)
		connectMe.connectMeDelegate = self
		connectMe.checkConnection()
	}
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	
	// MARK: - Protocol
	func connectMeDidFail(error: String) {
		print("failing: \(error)")
	}
	
	func connectMeDidConnect(sender: Int) {
		print("good sender: \(sender)")
	}
}

