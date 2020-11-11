//
//  UIImage+Screenshot.swift
//  Flyp
//
//  Created by Dani Arnaout on 1/13/20.
//  Copyright © 2020 The Selling Company. All rights reserved.
//

import UIKit

extension UIImage {
	func captureScreenshot() -> UIImage? {
		var screenshotImage: UIImage?
		let layer = UIApplication.shared.keyWindow!.layer
		let scale = UIScreen.main.scale
		UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		layer.render(in: context)
		screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return screenshotImage
	}
}
