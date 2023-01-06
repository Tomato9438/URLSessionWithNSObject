//
//  ConnectMe.swift
//  URLSessionCrazyMonkey
//
//  Created by Tomato on 2021/11/14.
//

import UIKit

protocol ConnectMeDelegate {
	func connectMeDidFail(error: String)
	func connectMeDidConnect(sender: Int)
}

class ConnectMe: NSObject {
	var connectMeDelegate: ConnectMeDelegate?
	
	var url: String
	var waitTime: Double
	var senderIndex: Int
	init(url: String, waitTime: Double, senderIndex: Int) {
		self.url = url
		self.waitTime = waitTime
		self.senderIndex = senderIndex
	}
	
	func checkConnection() {
		completionCheckConnection { done, error in
			if done {
				self.connectMeDelegate?.connectMeDidConnect(sender: self.senderIndex)
			} else {
				self.connectMeDelegate?.connectMeDidFail(error: error)
			}
		}
	}
	
	func completionCheckConnection(completionHandler: @escaping (Bool, String) -> (Void)) -> Void {
		if let url = URL(string: url) {
			var request = URLRequest(url: url)
			request.timeoutInterval = waitTime
			let sessionConfiguration = URLSessionConfiguration.default
			let session = URLSession(configuration: sessionConfiguration)
			session.dataTask(with: request) { data, response, error in
				if let error = error {
					self.connectMeDelegate?.connectMeDidFail(error: error.localizedDescription)
					//print("error: \(error.localizedDescription)")
					completionHandler(false, error.localizedDescription)
				} else {
					if let httpResponse = response as? HTTPURLResponse {
						let statusCode = httpResponse.statusCode
						if statusCode == 200 {
							completionHandler(true, "good")
						} else {
							completionHandler(false, "http status error")
						}
					}
				}
			}.resume()
			/*
			var urlRequest = URLRequest(url: url)
			urlRequest.timeoutInterval = waitTime
			let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
				if let error = error {
					self.connectMeDelegate?.connectMeDidFail()
					print("error: \(error.localizedDescription)")
					completionHandler(true, error.localizedDescription)
				} else {
					if let httpResponse = response as? HTTPURLResponse {
						let statusCode = httpResponse.statusCode
						if statusCode == 200 {
							completionHandler(true, "")
						} else {
							completionHandler(true, "status error")
						}
					}
				}
			}
			task.resume()
			*/
		}
	}
}
