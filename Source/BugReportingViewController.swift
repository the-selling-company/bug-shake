//
//  BugReportingViewController.swift
//  Flyp
//
//  Created by Dani Arnaout on 1/13/20.
//  Copyright © 2020 The Selling Company. All rights reserved.
//

import UIKit

class BugReportingViewController: UIViewController {

	fileprivate var screenshotImage: UIImage?

	@IBOutlet var screenshotImageView: DrawnImageView!
	@IBOutlet var descriptionTextView: UITextView!
	@IBOutlet weak var colorImageView: UIImageView!
	@IBOutlet weak var textViewPlaceholder: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		screenshotImageView.image = screenshotImage

		screenshotImageView.changedColor = { color in
			self.colorImageView.backgroundColor = color
		}
	}

	@IBAction func didTapCancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func didTapColorButton(_ sender: Any) {
		screenshotImageView.changeColor()
	}

	@IBAction func didTapBackButton(_ sender: Any) {
		screenshotImageView.back()
	}

	@IBAction func didTapResetButton(_ sender: Any) {
		screenshotImageView.reset()
	}

	@IBAction func didTapSubmitButton(_ sender: Any) {
		self.showShareSheet()
	}

	fileprivate func showShareSheet() {
		let textToShare: String = descriptionTextView.text
		var objectsToShare = [textToShare] as [Any]
		if let image = screenshotImageView.screenShot {
			objectsToShare.append(image)
		}
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		activityVC.excludedActivityTypes = [UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.print, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.copyToPasteboard]
		activityVC.popoverPresentationController?.sourceView = self.view
		self.present(activityVC, animated: true, completion: nil)
	}

	fileprivate func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}

extension BugReportingViewController: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let currentText = textView.text ?? ""
		guard let stringRange = Range(range, in: currentText) else { return false }
		let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
		textViewPlaceholder.isHidden = (updatedText.count > 0)
		return true
	}
}

extension BugReportingViewController {
	static func make(image: UIImage) -> BugReportingViewController {
		let podBundle = Bundle(for: BugReportingViewController.self)
		guard let controller = UIStoryboard(name: String(describing: BugReportingViewController.self), bundle: podBundle)
			.instantiateInitialViewController() as? BugReportingViewController else { fatalError(); }
		controller.screenshotImage = image
		return controller
	}
}
