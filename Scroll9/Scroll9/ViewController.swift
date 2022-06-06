//
//  ViewController.swift
//  Scroll9
//
//  Created by Don Mag on 7/20/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class ThisViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let text = "A line break challenge \nInvestigating a bug where the text in the last line is incorrect when numberOfLines is limited to for example 3. Very strange indeed. Peculiar. What to do about this? What am I missing?"
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineBreakMode = .byTruncatingTail //.byWordWrapping works, but not what I want.
		
		let attributedString = NSAttributedString(string: text, attributes: [
			.paragraphStyle: paragraphStyle
		])
		
		let label = UILabel()
		label.attributedText = attributedString
		label.numberOfLines = 3 //0 works, but is not what I want.
		
		label.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(label)
		
		if #available(iOS 11.0, *) {
			let g = view.safeAreaLayoutGuide
			label.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0).isActive = true
			label.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0).isActive = true
			label.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0).isActive = true
		} else {
			guard let g = view else { return }
			label.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0).isActive = true
			label.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0).isActive = true
			label.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0).isActive = true
		}
		
		if #available(iOS 13.0, *) {
			createBarButtonAppearence(.red, textColor: .yellow)
		} else {
			// Fallback on earlier versions
		}
	}
	
	@available(iOS 13.0, *)
	private func createBarButtonAppearence(_ color: UIColor, textColor: UIColor)  -> UINavigationBarAppearance {
		let appearance = UINavigationBarAppearance()
		appearance.titleTextAttributes = [.foregroundColor: textColor]
		appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = color
		
		let back = UIBarButtonItemAppearance()
		back.normal.backgroundImage = UIImage(named: "white_back_arrow")
		appearance.backButtonAppearance = back
		return appearance
	}
}

class ViewController: UIViewController {
	@IBOutlet var v1: UIImageView!
	@IBOutlet var v2: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let test: [String] = [
			"1 hello helloSwift Swi Apple le",
			"2 I want a string",
			"3 i want a string",
			"4 I want a function to receive the above inputs and return a String",
			"5 i want a function to receive the above inputs and return a String",
			"6 abc aBc Abc abc ABC aabc",
			"7 droid android otherdroid and android and otherdroid",
		]

		test.forEach { s in
			let rs = parseString(s)
			print("Orig:", s)
			print("Ret :", rs)
			print()
		}
		
		if let img1 = UIImage(named: "t"),
		   let img2 = UIImage(named: "t.fill")
		{
			v1.image = img1
			v2.image = img2
		}
		return()
//		if let s = Bundle.main.path(forResource: "t.fill", ofType: "png"),
//		   let v = UIImage.init(contentsOfFile: s)
//		{
//			v2.image = v
//		}
		
		
	}

	func parseString(_ str: String) -> String {
		
		// split the string into an array of "words" (no spaces)
		var a1: [String] = str.components(separatedBy: " ").removingDuplicates()
		
		// an array to hold the unique words
		var a2: [String] = []
		
		// for each word
		for i in 0..<a1.count {
			// remove the word from the array
			let word = a1.remove(at: i)
			// filter the remaining array by elements containing word
			let n = a1.filter { $0.contains(word) }
			// if no elements contain word
			if n.count == 0 {
				// append it to array of unique words
				a2.append(word)
			}
			// put the word back into the full array
			a1.insert(word, at: i)
		}
		
		return a2.joined(separator: "-")
	}

	func parseString(_ str: String, caseSensitive: Bool) -> String {
		
		// split the string into an array of "words" (no spaces)
		let aOrig: [String] = str.components(separatedBy: " ").removingDuplicates()
		
		var a1: [String] = []
		if caseSensitive {
			a1 = str.lowercased().components(separatedBy: " ").removingDuplicates()
		} else {
			a1 = aOrig.removingDuplicates()
		}
		
		// an array to hold the unique words
		var a2: [String] = []

		// for each word
		for i in 0..<a1.count {
			// remove the word from the array
			let word = a1.remove(at: i)
			// filter the remaining array by elements containing word
			let n = a1.filter { $0.contains(word) }
			// if no elements contain word
			if n.count == 0 {
				// append it to array of unique words
				a2.append(aOrig[i])
			}
			// put the word back into the full array
			a1.insert(word, at: i)
		}

		return a2.joined(separator: "-")
	}
}

extension Array where Element: Hashable {
	func removingDuplicates() -> [Element] {
		var addedDict = [Element: Bool]()
		
		return filter {
			addedDict.updateValue(true, forKey: $0) == nil
		}
	}
	
	mutating func removeDuplicates() {
		self = self.removingDuplicates()
	}
}

class scrViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		automaticallyAdjustsScrollViewInsets = false //
		
		let someView = UIView()
		someView.frame = UIScreen.main.bounds
		someView.backgroundColor = .yellow
		view.addSubview(someView)
		
		// some image size calcs to keep the image in the same proportions on all devices.
		let frame = view.frame
		let height = frame.height * 0.35
		let ratioFactor = CGFloat(8.82)
		let width = height * ratioFactor
		
		let hillsImgView = UIImageView()
		//let image = UIImage(named: "hills")
		let image = UIImage(named: "bkg640x360")
		hillsImgView.image = image
		
		// place imageView at the bottom of the screen
		let rect = CGRect(x: 0, y: frame.height - height, width: width, height: height)
		hillsImgView.frame = rect
		hillsImgView.backgroundColor = .green
		hillsImgView.contentMode = UIImageView.ContentMode.scaleToFill
		
		let hillsScrollView = UIScrollView()
		hillsScrollView.frame = UIScreen.main.bounds
		hillsScrollView.frame.origin.x = 10 // just to see the parent views yellow bg
		hillsScrollView.backgroundColor = .red
		hillsScrollView.contentSize = hillsImgView.frame.size // the image is longer then the screen
		hillsScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		hillsScrollView.contentOffset = CGPoint(x: 0, y: 0)
		hillsScrollView.addSubview(hillsImgView)
		
		someView.addSubview(hillsScrollView)
		
		if #available(iOS 11.0, *) {
			hillsScrollView.contentInsetAdjustmentBehavior = .never
		} else {
			// Fallback on earlier versions
		}
	}
	
}

class PresTranVC: UIViewController {
	
}
class TranVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
	}
}


class LaunchViewController: UIViewController {
	
	private let imageView: UIImageView = {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 270))
		imageView.image = UIImage(named: "launch")
		return imageView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(imageView)
		view.backgroundColor = .black
	}
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		imageView.center = view.center
		
		DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
			self.animate()
		})
	}
	
	private func animate() {
		UIView.animate(withDuration: 1, animations: {
			let size = self.view.frame.width * 9
			let diffX = size - self.view.frame.size.width
			let diffY = self.view.frame.size.height - size
			self.imageView.frame = CGRect(
				x: -(diffX/2),
				y: diffY/2,
				width: size,
				height: size
			)
		})
		UIView.animate(withDuration: 1.5, animations: {
			self.imageView.alpha = 0
		}, completion: {done in
			if done {
				guard let window = UIApplication.shared.keyWindow else {
					return
				}
				
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let vc = storyboard.instantiateViewController(withIdentifier: "mainSB")
				
				// Set the new rootViewController of the window.
				// Calling "UIView.transition" below will animate the swap.
				window.rootViewController = vc
				
				// A mask of options indicating how you want to perform the animations.
				let options: UIView.AnimationOptions = .transitionCrossDissolve
				
				// The duration of the transition animation, measured in seconds.
				let duration: TimeInterval = 0.3
				
				// Creates a transition animation.
				// Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
				UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
									{ completed in
					// maybe do something on completion here
				})
				
//				DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
//					if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "mainSB") as? UITabBarController {
//						//let viewController = ViewController()
//						viewController.modalTransitionStyle = .crossDissolve
//						viewController.modalPresentationStyle = .fullScreen
//						self.present(viewController, animated: true)
//					}
//				})
			}
		})
	}
	
}

class AnimTestVC: UIViewController {
	
	let cView = MyCustomView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if #available(iOS 13.0, *) {
			view.backgroundColor = .systemBackground
		} else {
			// Fallback on earlier versions
		}
		
		cView.backgroundColor = .systemBlue
		cView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(cView)
		
		NSLayoutConstraint.activate([
			cView.widthAnchor.constraint(equalToConstant: 100.0),
			cView.heightAnchor.constraint(equalTo: cView.widthAnchor),
			cView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			cView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
		
		cView.alpha = 0.0
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		cView.showPointOfInterestA(at: cView.center, hideViewAfterAnimation: true)
	}
}
class MyCustomView: UIView {

	func showPointOfInterestA(at point: CGPoint, hideViewAfterAnimation: Bool) {

		let durations: [Double] = [
			0.20, 0.3, 0.1, 1.5, 0.5
		]
		
		let totalDuration = durations.reduce(0, +)
		
		var relStart: Double = 0.0
		var relDur: Double = 0.0
		var i: Int = 0
		
		self.center = point
		
		UIView.animateKeyframes(withDuration: totalDuration, delay: 0, options: .calculationModeCubic, animations: {
			
			relStart = 0.0
			relDur = durations[i] / totalDuration
			i += 1
			UIView.addKeyframe(withRelativeStartTime: relStart, relativeDuration: relDur) {
				self.alpha = 1.0
				self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
			}
			
			relStart += relDur
			relDur = durations[i] / totalDuration
			i += 1
			UIView.addKeyframe(withRelativeStartTime: relStart, relativeDuration: relDur) {
				self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
			}
			
			relStart += relDur
			relDur = durations[i] / totalDuration
			i += 1
			UIView.addKeyframe(withRelativeStartTime: relStart, relativeDuration: relDur) {
				self.transform = .identity
			}
			
			relStart += relDur
			relDur = durations[i] / totalDuration
			i += 1
			UIView.addKeyframe(withRelativeStartTime: relStart, relativeDuration: relDur) {
				self.alpha = 0.5
			}

			relStart += relDur
			relDur = durations[i] / totalDuration
			i += 1
			UIView.addKeyframe(withRelativeStartTime: relStart, relativeDuration: relDur) {
				self.alpha = hideViewAfterAnimation ? 0.0 : 0.5
			}
		})
		
//		CATransaction.begin()
//
//		let animA = CABasicAnimation(keyPath: "transform.scale")
//		animA.fromValue = 1.0
//		animA.toValue = 1.5
//
//
//		let group = CAAnimationGroup()
//		group.duration = 0.75
//		group.timingFunction = CAMediaTimingFunction(name: .linear)
//		group.beginTime = CACurrentMediaTime() + 0.2
//		group.animations = [animA]
//		layer.add(group, forKey: "borderChangeAnimationGroup")
//
//		CATransaction.commit()
		
	}
	
	func showPointOfInterest(at point: CGPoint, hideViewAfterAnimation: Bool) {
		
		//if isPreviousAnimationPresenting() { layer.removeAllAnimations() }
		
		layer.removeAllAnimations()
		
		
		
		center = point
		transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
		self.alpha = 1
		
		UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
			self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
		} completion: { animated in
			if !animated {
				return
			} else {
				UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut]) {
					self.transform = .identity
				} completion: { animated in
					if !animated {
						return
					} else {
						UIView.animate(withDuration: 1.5, delay: 0, options: [.curveEaseInOut]) {
							self.alpha = 0.5
						} completion: { animated in
							if !animated {
								return
							} else {
								UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
									self.alpha = hideViewAfterAnimation ? 0 : 0.5
								}
							}
						}
					}
				}
			}
		}
	}
}

class ImageCell: UITableViewCell {
	
}
class SnapTableVC: UIViewController {
	
	let colors: [UIColor] = [
		.systemRed, .green, .systemBlue,
		.cyan, .yellow
	]
	let tableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if #available(iOS 11.0, *) {
			let g = view.safeAreaLayoutGuide
			tableView.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(tableView)
			NSLayoutConstraint.activate([
				tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
				tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
				tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
				tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
			])
			tableView.register(ImageCell.self, forCellReuseIdentifier: "c")
			tableView.dataSource = self
			tableView.delegate = self
		} else {
			// Fallback on earlier versions
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if tableView.rowHeight != tableView.frame.height {
			tableView.rowHeight = tableView.frame.height
			tableView.isPagingEnabled = true
		}
	}
}

extension SnapTableVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! ImageCell
		c.contentView.backgroundColor = colors[indexPath.row % colors.count]
		return c
	}
//	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//		print(#function)
//		let h = tableView.frame.height
//		let c = tableView.contentOffset.y / h
//		let r = Int(c.rounded())
//		tableView.scrollToRow(at: IndexPath(row: r, section: 0), at: .top, animated: true)
//	}
//	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//		print(#function)
//	}
}

class TrimmedLabel: UILabel {
	
}

