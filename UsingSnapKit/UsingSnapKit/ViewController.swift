//
//  ViewController.swift
//  UsingSnapKit
//
//  Created by Don Mag on 6/1/22.
//

import UIKit

class BottomPaddingViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let safeAreaView = UIView()
		safeAreaView.backgroundColor = .red
		safeAreaView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(safeAreaView)
		
		let btn = UIButton()
		btn.backgroundColor = .systemBlue
		btn.setTitle("Button", for: [])
		btn.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(btn)
		
		let g = view.safeAreaLayoutGuide
		
		// bottom constraint for the button
		//	to the safe area bottom
		//	with less-than-required priority
		let bConstraint = btn.bottomAnchor.constraint(equalTo: g.bottomAnchor)
		bConstraint.priority = .required - 1
		
		NSLayoutConstraint.activate([
			
			// constrain the red view to the safe area bottom
			safeAreaView.bottomAnchor.constraint(equalTo: g.bottomAnchor),
			safeAreaView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			safeAreaView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			safeAreaView.heightAnchor.constraint(equalToConstant: 40.0),
			
			// constrain button 200-pts wide, centered horizontally
			btn.widthAnchor.constraint(equalToConstant: 200.0),
			btn.heightAnchor.constraint(equalToConstant: 40.0),
			btn.centerXAnchor.constraint(equalTo: g.centerXAnchor),

			// and bottom AT LEAST 20-points from the bottom of the VIEW
			btn.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20.0),
			
			// activate the button's safe area bottom constraint
			bConstraint,
		])
	}
	
}

final class CanvasView: UIView {
	
	// closure to get the tool bar view frame
	var getToolbarFrame: (() ->(CGRect))?
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		
		let currentPoint = touch.location(in: self)
		print("touch began \(currentPoint)")
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		
		let currentPoint = touch.location(in: self)
		
		// unwrap the optional closure to get the toolbar view frame
		if let r = getToolbarFrame?() {
			// convert that rect to self's coordinate space
			let rr = self.superview!.convert(r, to: self)
			//	if the frame contains this touch point,
			//	return
			if rr.contains(currentPoint) {
				return
			}
		}
		
		// toobar view frame did not contain the touch, so
		//	do what you want with the moved touch
		print("touch move \(currentPoint)")
	}

}

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBlue
		
		let canvasView = CanvasView()
		canvasView.backgroundColor = .white
		view.addSubview(canvasView)
		
		canvasView.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(40)
		}
		
		let toolbarView = UIView()
		toolbarView.backgroundColor = .black.withAlphaComponent(0.7)
		view.addSubview(toolbarView)
		
		toolbarView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview().inset(80)
			make.height.equalTo(200.0)
		}
		
		// set the closure
		canvasView.getToolbarFrame = {
			return toolbarView.frame
		}
	}
	
}


enum Side {
	case top, left, right, bottom
}
class xViewController: UIViewController {

	public lazy var contentView = UIView()
	public lazy var scrollView = UIScrollView()
	
	func addScrollView(insets: UIEdgeInsets, safeAreaRelatedSides: [Side]) {
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(safeAreaRelatedSides.contains(where: { $0 == .top }) ? view.safeAreaLayoutGuide.snp.top : view.snp.top)
			make.left.equalTo(safeAreaRelatedSides.contains(where: { $0 == .left }) ? view.safeAreaLayoutGuide.snp.left : view.snp.left)
			make.right.equalTo(safeAreaRelatedSides.contains(where: { $0 == .right }) ? view.safeAreaLayoutGuide.snp.right : view.snp.right)
			make.bottom.equalTo(safeAreaRelatedSides.contains(where: { $0 == .bottom }) ? view.safeAreaLayoutGuide.snp.bottom : view.snp.bottom)
		}
		contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 300.0),
		])
//		contentView.snp.makeConstraints { make in
//			make.top.equalToSuperview().inset(insets.top)
//			make.left.equalToSuperview().inset(insets.left)
//			make.right.equalToSuperview().inset(insets.right)
//			make.bottom.equalToSuperview().inset(insets.bottom).priority(250)
//			make.centerX.equalToSuperview()
//			make.centerY.equalToSuperview().priority(250)
//		}
		scrollView.contentInsetAdjustmentBehavior = .never
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		view.backgroundColor = .lightGray
		scrollView.backgroundColor = .systemBlue
		contentView.backgroundColor = .systemYellow
		
		addScrollView(insets: .zero, safeAreaRelatedSides: [.top, .left, .right])
//		scrollView.contentInset.bottom = UIApplication.shared.safeAreaInsets.bottom
		
	}


}

class ManyLayersViewController: UIViewController, UIScrollViewDelegate {
	
	let scrollView: UIScrollView = {
		let v = UIScrollView()
		v.contentInsetAdjustmentBehavior = .never
		return v
	}()
	let pathView: UIView = {
		let v = UIView()
		return v
	}()
	
	let pvSize: CGFloat = 1200.0
	
	var pts: [CGPoint] = []
	var markers: [UIView] = []
	var order: [Int] = []
	var idx: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		[scrollView, pathView].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
		}
		
		// add pathView to the scroll view
		scrollView.addSubview(pathView)
		
		// add scroll view to self.view
		view.addSubview(scrollView)
		
		let safeG = view.safeAreaLayoutGuide
		let contentG = scrollView.contentLayoutGuide
		
		NSLayoutConstraint.activate([
			
			// scroll view Top/Leading/Trailing/Bottom to safe area
			scrollView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 40.0),
			scrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 40.0),
			scrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -40.0),
			scrollView.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -40.0),
			
			// pathView Top/Leading/Trailing/Bottom to scroll view's CONTENT GUIDE
			pathView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 0.0),
			pathView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 0.0),
			pathView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: 0.0),
			pathView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: 0.0),
			
			pathView.widthAnchor.constraint(equalToConstant: 1600.0),
			pathView.heightAnchor.constraint(equalToConstant: 1600.0),
			
		])
		
		scrollView.delegate = self
		scrollView.minimumZoomScale = 0.25
		scrollView.maximumZoomScale = 8.0
		
		// so we can see the scroll view frame
		scrollView.layer.borderWidth = 2
		scrollView.layer.borderColor = UIColor.red.cgColor
		
		let colors: [UIColor] = [
			.red, .green, .blue,
			.cyan, .magenta, .yellow
		]
		
		
		// use a large font so we can see it easily
		let font = UIFont(name: "Times", size: 40)!
		
		// Hebrew character for 8
		var unichars = [UniChar]("ח".utf16)
		unichars = [UniChar]("י".utf16)
		var str: String = "ABCDEFGHI"
		var a: [UniChar] = Array(str.utf16)
		
		var glyphs = [CGGlyph](repeatElement(0, count: a.count))
		
		let gotGlyphs = CTFontGetGlyphsForCharacters(font, &a, &glyphs, a.count)
		
		var pathsArray: [CGPath] = []
		if gotGlyphs {
			glyphs.forEach { g in
				if let cgpath = CTFontCreatePathForGlyph(font, g, nil) {
					var tr = CGAffineTransform(scaleX: 1.0, y: -1.0)
					if let p = cgpath.copy(using: &tr) {
						pathsArray.append(p)
					}
				}
			}
		}
		
		
		let num: Int = 28
		var cIDX: Int = 0
		var off: Int = 4
		pathsArray.forEach { pth in
			let clr = colors[cIDX % colors.count]
			for c in 0..<num {
				for r in 0..<num {
					let sl = CAShapeLayer()
					sl.path = pth
					sl.strokeColor = UIColor.systemYellow.cgColor
					sl.fillColor = clr.cgColor
					sl.frame.origin = CGPoint(x: c * 50 + off, y: r * 50 + off + 30)
					pathView.layer.addSublayer(sl)
				}
			}
			off += 20
			cIDX += 1
		}
		pathView.clipsToBounds = true
		
		print(pathView.layer.sublayers?.count)
		
		return()
		
		// init glyphs array
		//		var glyphs = [CGGlyph](repeatElement(0, count: unichars.count))
		//
		//		let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
		
		if gotGlyphs {
			glyphs.forEach { g in
				if let cgpath = CTFontCreatePathForGlyph(font, g, nil) {
					
					let pth = UIBezierPath(cgPath: cgpath)
					
					// glyph path is inverted, so flip vertically
					let flipY = CGAffineTransform(scaleX: 1, y: -1.0)
					
					// glyph path may be offset on the x coord, and by the height (because it's flipped)
					//					let translate = CGAffineTransform(translationX: -pth.bounds.origin.x, y: pth.bounds.size.height + pth.bounds.origin.y)
					
					let translate = CGAffineTransform(translationX: -pth.bounds.origin.x, y: pth.bounds.size.height + pth.bounds.origin.y)
					
					// apply the transforms
					pth.apply(flipY)
					pth.apply(translate)
					
					let sl = CAShapeLayer()
					sl.path = pth.cgPath
					sl.strokeColor = UIColor.systemYellow.cgColor
					let clr = colors[cIDX % colors.count]
					sl.fillColor = clr.cgColor
					sl.frame.origin.x = CGFloat(cIDX) * 40
					pathView.layer.addSublayer(sl)
					cIDX += 1
				}
			}
			
			//			// get the cgPath for the character
			//			let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)!
			//
			//			// convert it to a UIBezierPath
			//			let path = UIBezierPath(cgPath: cgpath)
			//
			//			var r = path.bounds
			//
			//			// let's show it at 40,40
			//			r = r.offsetBy(dx: 40.0, dy: 40.0)
			//
			//			let pView = PathView(frame: r)
			//			pView.backgroundColor = .white
			//			//pView.myPath = path
			//
			//			view.addSubview(pView)
			//
			//			// print bounds and path data for debug / reference
			//			print("bounds of path:", path.bounds)
			//			print()
			//			print(path)
			//			print()
		}
		
		return()
		
		let n: Int = 600 / 20
		
		var i: Int = 0
		
		colors.forEach { clr in
			for c in 0..<n {
				for r in 0..<n {
					let sl = CAShapeLayer()
					let r: CGRect = CGRect(x: c * 20 + off, y: r * 20 + off, width: 12, height: 12)
					sl.path = UIBezierPath(roundedRect: r, cornerRadius: 2).cgPath
					sl.strokeColor = UIColor.systemYellow.cgColor
					sl.fillColor = clr.cgColor
					pathView.layer.addSublayer(sl)
				}
			}
			off += 4
		}
		
		//		let c = CAShapeLayer()
		//		c.path = UIBezierPath(roundedRect: CGRect(x: 50, y: 50, width: 300, height: 200), cornerRadius: 16).cgPath
		//		c.strokeColor = UIColor.red.cgColor
		//		c.fillColor = UIColor.systemBlue.cgColor
		//		pathView.layer.addSublayer(c)
		
		print(pathView.layer.sublayers?.count)
		
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return pathView
	}
	
}
