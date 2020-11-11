//
//  WhereAmIRunning.swift
//  Flyp
//
//  Created by Dani Arnaout on 1/14/20.
//  Copyright © 2020 The Selling Company. All rights reserved.
//

import Foundation

struct WhereAmIRunning {

	// MARK: Public

	func isRunningInTestFlightEnvironment() -> Bool {
		if isSimulator() {
			return false
		} else {
			if isAppStoreReceiptSandbox() && !hasEmbeddedMobileProvision() {
				return true
			} else {
				return false
			}
		}
	}

	func isRunningInAppStoreEnvironment() -> Bool {
		if isSimulator() {
			return false
		} else {
			if isAppStoreReceiptSandbox() || hasEmbeddedMobileProvision() {
				return false
			} else {
				return true
			}
		}
	}

	// MARK: Private

	private func hasEmbeddedMobileProvision() -> Bool {
		if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
			return true
		}
		return false
	}

	private func isAppStoreReceiptSandbox() -> Bool {
		if isSimulator() {
			return false
		} else {
			if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL {
				let appStoreReceiptLastComponent = appStoreReceiptURL.lastPathComponent
				if appStoreReceiptLastComponent == "sandboxReceipt" {
					return true
				}
			}
			return false
		}
	}

	private func isSimulator() -> Bool {
		#if arch(i386) || arch(x86_64)
		return true
		#else
		return false
		#endif
	}

}
