//
//  MiscViewController.swift
//  CollectionStuff
//
//  Created by Don Mag on 7/10/22.
//

import UIKit

class MiscViewController: UIViewController {
	
	let tiledView = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tiledView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tiledView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			tiledView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			tiledView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			tiledView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			tiledView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
		])
		
	}
	
	override func viewDidLayoutSubviews() {
		// we want to do this here, when we know the
		//	size / frame of the tiledView
		
		// make sure we can load the image
		guard let tileImage = UIImage(named: "tileSquare") else { return }
		
		// let's just pick 80 x 80 for the tile size
		let tileSize: CGSize = CGSize(width: 80.0, height: 80.0)

		// create a "horizontal" replicator layer
		let hReplicatorLayer = CAReplicatorLayer()
		hReplicatorLayer.frame.size = tiledView.frame.size
		hReplicatorLayer.masksToBounds = true
		
		// create a "vertical" replicator layer
		let vReplicatorLayer = CAReplicatorLayer()
		vReplicatorLayer.frame.size = tiledView.frame.size
		vReplicatorLayer.masksToBounds = true
		
		// create a layer to hold the image
		let imageLayer = CALayer()
		imageLayer.contents = tileImage.cgImage
		imageLayer.frame.size = tileSize
		
		// add the imageLayer to the horizontal replicator layer
		hReplicatorLayer.addSublayer(imageLayer)
		
		// add the horizontal replicator layer to the vertical replicator layer
		vReplicatorLayer.addSublayer(hReplicatorLayer)

		// how many "tiles" do we need to fill the width
		let hCount = tiledView.frame.width / tileSize.width
		hReplicatorLayer.instanceCount = Int(ceil(hCount))
		
		// Shift each image instance right by tileSize width
		hReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
			tileSize.width, 0, 0
		)
		
		// how many "rows" do we need to fill the height
		let vCount = tiledView.frame.height / tileSize.height
		vReplicatorLayer.instanceCount = Int(ceil(vCount))
		
		// shift each "row" down by tileSize height
		vReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
			0, tileSize.height, 0
		)

		// add the vertical replicator layer as a sublayer
		tiledView.layer.addSublayer(vReplicatorLayer)

	}
	
}

class aMiscViewController: UIViewController {

	let tiledView = TiledView()
	
	var imgTile1: UIImage!
	var imgTile2: UIImage!
	
	var i: Int = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

		guard let tileImage1 = UIImage(named: "tile519x450") else { return }
		guard let tileImage2 = UIImage(named: "tile370x428") else { return }

		imgTile1 = tileImage1
		imgTile2 = tileImage2
		
		tiledView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tiledView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			tiledView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			tiledView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			tiledView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			tiledView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -20.0),
		])
    }

	override func viewDidLayoutSubviews() {
		switchTiles()
	}
	
	func switchTiles() {
		i += 1
		
		guard let image = (i % 2 == 1 ? imgTile1 : imgTile2) else { return }
		
		let tW: CGFloat = tiledView.frame.width * 0.2
		let tH: CGFloat = tW / image.size.width * image.size.height
		
		tiledView.img = image
		tiledView.tileSize = CGSize(width: tW, height: tH)
		tiledView.tileSize = CGSize(width: 240, height: 240)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		switchTiles()
	}
}

class TiledView: UIView {
	
	var img: UIImage! {
		didSet { setNeedsLayout() }
	}
	var tileSize: CGSize = .zero {
		didSet { setNeedsLayout() }
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let image = img,
			  tileSize.width > 0.0,
			  tileSize.height > 0.0
		else { return }
		
		let hReplicatorLayer = CAReplicatorLayer()
		hReplicatorLayer.frame.size = bounds.size
		hReplicatorLayer.masksToBounds = true

		let vReplicatorLayer = CAReplicatorLayer()
		vReplicatorLayer.frame.size = bounds.size
		vReplicatorLayer.masksToBounds = true

		let imageLayer = CALayer()
		imageLayer.contents = image.cgImage
		imageLayer.frame.size = tileSize
		hReplicatorLayer.addSublayer(imageLayer)
		
		let hCount = bounds.width / tileSize.width
		hReplicatorLayer.instanceCount = Int(ceil(hCount))

		// Shift each image instance right by tileSize width
		hReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
			tileSize.width, 0, 0
		)
		
		let vCount = bounds.height / tileSize.height
		vReplicatorLayer.instanceCount = Int(ceil(vCount))

		// shift each "row" down by tileSize height
		vReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
			0, tileSize.height, 0
		)
		
		vReplicatorLayer.addSublayer(hReplicatorLayer)
		layer.addSublayer(vReplicatorLayer)

	}
	
}

class CircleTestVC: UIViewController {
	
	var numStories: Int = 0
	var numViewed: Int = 0
	
	let cView = DashedCircleView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		cView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(cView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			cView.widthAnchor.constraint(equalToConstant: 160.0),
			cView.heightAnchor.constraint(equalTo: cView.widthAnchor),
			cView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			cView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
		])

		cView.storyCount = numStories
		cView.viewedCount = numViewed
		
		// let's add a few buttons
		let stackView = UIStackView()
		stackView.spacing = 8
		stackView.distribution = .fillEqually
		["Add Story", "Add Viewed", "Reset"].forEach { s in
			let b = UIButton()
			b.backgroundColor = .systemRed
			b.setTitle(s, for: [])
			b.setTitleColor(.white, for: .normal)
			b.setTitleColor(.lightGray, for: .highlighted)
			b.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
			stackView.addArrangedSubview(b)
		}
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			stackView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			stackView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
		])

	}
	
	@objc func btnTapped(_ sender: UIButton) {
		guard let t = sender.currentTitle else { return }
		switch t {
		case "Add Story":
			addStory()
		case "Add Viewed":
			addViewed()
		default:
			reset()
		}
	}
	
	@objc func addStory() {
		numStories += 1
		cView.storyCount = numStories
	}
	@objc func addViewed() {
		numViewed += 1
		numViewed = min(numViewed, numStories)
		cView.viewedCount = numViewed
	}
	@objc func reset() {
		numStories = 0
		numViewed = 0
		cView.storyCount = numStories
		cView.viewedCount = numViewed
	}
}
class DashedCircleView: UIView {
	
	var storyCount: Int = 0 {
		didSet { setNeedsLayout() }
	}
	var viewedCount: Int = 0 {
		didSet { setNeedsLayout() }
	}
	
	public var storyColor: UIColor = .systemGreen {
		didSet {
			colorLayer.strokeColor = storyColor.cgColor
		}
	}
	public var viewedColor: UIColor = .gray {
		didSet {
			colorLayer.strokeColor = viewedColor.cgColor
		}
	}

	private let grayLayer = CAShapeLayer()
	private let colorLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		layer.addSublayer(grayLayer)
		layer.addSublayer(colorLayer)
		grayLayer.strokeColor = viewedColor.cgColor
		colorLayer.strokeColor = storyColor.cgColor
		grayLayer.fillColor = UIColor.clear.cgColor
		colorLayer.fillColor = UIColor.clear.cgColor
		grayLayer.lineWidth = 5
		colorLayer.lineWidth = 5
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let cPT: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

		if storyCount == 0 {
			
			// clear both shape layer paths
			grayLayer.path = nil
			colorLayer.path = nil
			
		} else if storyCount == 1 {
			
			// complete 360 degee arc
			//	so no spaces
			let bez = UIBezierPath()
			let a1: Double = -90
			let a2: Double = 270
			
			bez.addArc(withCenter: cPT, radius: bounds.midX, startAngle: a1.degreesToRadians, endAngle: a2.degreesToRadians, clockwise: true)
			
			if viewedCount == 1 {
				grayLayer.path = bez.cgPath
				colorLayer.path = nil
			} else {
				colorLayer.path = bez.cgPath
				grayLayer.path = nil
			}
		} else {
			
			let grayBez = UIBezierPath()
			let colorBez = UIBezierPath()
			let trackBez = UIBezierPath()
			
			// space between arcs
			let gapDegrees: Double = 10
			
			let availableDegrees: Double = 360 - Double(storyCount) * gapDegrees
			let arcDegrees: Double = availableDegrees / Double(storyCount)
			
			var a1: Double = -90

			for i in 0..<storyCount {
				if i < viewedCount {
					grayBez.addArc(withCenter: cPT, radius: bounds.midX, startAngle: a1.degreesToRadians, endAngle: a1.degreesToRadians + arcDegrees.degreesToRadians, clockwise: true)
				} else {
					colorBez.addArc(withCenter: cPT, radius: bounds.midX, startAngle: a1.degreesToRadians, endAngle: a1.degreesToRadians + arcDegrees.degreesToRadians, clockwise: true)
				}
				
				// to provide a space (or gap) between arcs, we need to
				//	move to the start of the next arc
				//	a "cheap" way to do this is to use a "tracking" bezier path
				//	and add an arc including the gap degrees
				//	that will give us the "moveTo" point
				trackBez.addArc(withCenter: cPT, radius: bounds.midX, startAngle: a1.degreesToRadians, endAngle: (a1 + arcDegrees + gapDegrees).degreesToRadians, clockwise: true)
				grayBez.move(to: trackBez.currentPoint)
				colorBez.move(to: trackBez.currentPoint)

				// increment the arc starting degrees
				a1 += arcDegrees + gapDegrees
			}
			
			colorLayer.path = colorBez.cgPath
			grayLayer.path = grayBez.cgPath
			
		}
		
		grayLayer.lineCap = storyCount > 1 ? .round : .butt
		colorLayer.lineCap = storyCount > 1 ? .round : .butt
		
	}
	
}

extension FloatingPoint {
	var degreesToRadians: Self { self * .pi / 180 }
	var radiansToDegrees: Self { self * 180 / .pi }
}

class ShadowView: UIView {

	public var overlapShadow: Bool = true
	
	private let redLayer = CAShapeLayer()
	private let greenLayer = CAShapeLayer()
	private let blueLayer = CAShapeLayer()
	
	private let blueShadowLayer = CAShapeLayer()

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		let clrs: [UIColor] = [
			.clear, .red, .green, .blue,
		]
		let lays: [CAShapeLayer] = [
			blueShadowLayer, redLayer, greenLayer, blueLayer,
		]
		for (l, c) in zip(lays, clrs) {
			l.fillColor = c.cgColor
			layer.addSublayer(l)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let rd = bounds.width * 0.20

		let redRect: CGRect = CGRect(x: rd * 0.5, y: rd * 0.5, width: rd * 2.0, height: rd * 2.0)
		let greenRect: CGRect = redRect.offsetBy(dx: rd, dy: rd)
		let blueRect: CGRect = greenRect.offsetBy(dx: rd, dy: rd)
		
		let redBez: UIBezierPath = UIBezierPath(ovalIn: redRect)
		let greenBez: UIBezierPath = UIBezierPath(ovalIn: greenRect)
		let blueBez: UIBezierPath = UIBezierPath(ovalIn: blueRect)

		redLayer.path = redBez.cgPath
		greenLayer.path = greenBez.cgPath
		blueLayer.path = blueBez.cgPath

		redLayer.shadowColor = UIColor.black.cgColor
		redLayer.shadowRadius = 10
		redLayer.shadowOpacity = 1
		redLayer.shadowOffset = .zero
		redLayer.shadowPath = redBez.cgPath

		// no shadow on greenLayer

		if overlapShadow {
			blueLayer.shadowColor = UIColor.black.cgColor
			blueLayer.shadowRadius = 10
			blueLayer.shadowOpacity = 1
			blueLayer.shadowOffset = .zero
			blueLayer.shadowPath = blueBez.cgPath
		} else {
			blueShadowLayer.shadowColor = UIColor.black.cgColor
			blueShadowLayer.shadowRadius = 10
			blueShadowLayer.shadowOpacity = 1
			blueShadowLayer.shadowOffset = .zero
			blueShadowLayer.shadowPath = blueBez.cgPath
		}
		
	}
	
}

class xShadowTestVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()

		let stackView = UIStackView()
		stackView.axis = .vertical
		
		let sView1 = ShadowView()
		let sView2 = ShadowView()
		
		stackView.addArrangedSubview(sView1)
		stackView.addArrangedSubview(sView2)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			
			sView1.widthAnchor.constraint(equalToConstant: 300.0),
			sView1.heightAnchor.constraint(equalTo: sView1.widthAnchor),
			
			sView2.widthAnchor.constraint(equalTo: sView1.widthAnchor),
			sView2.heightAnchor.constraint(equalTo: sView1.widthAnchor),
		])
		
		sView1.overlapShadow = true
		sView2.overlapShadow = false
		
	}
}

class DemoShadowView: UIView {
	public var v: Int = 0
	public var s: Bool = false
	public var overlapShadow: Bool = true
	
	private let redLayer = CAShapeLayer()
	private let greenLayer = CAShapeLayer()
	private let blueLayer = CAShapeLayer()
	
	private let blueShadowLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		layer.addSublayer(blueShadowLayer)
		let clrs: [UIColor] = [
			.blue, .red, .green, .blue,
		]
		let lays: [CAShapeLayer] = [
			blueShadowLayer, redLayer, greenLayer, blueLayer,
		]
		for (l, c) in zip(lays, clrs) {
			l.fillColor = c.cgColor
			layer.addSublayer(l)
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let rd = bounds.width * 0.20
		
		let redRect: CGRect = CGRect(x: rd * 0.5, y: rd * 0.5, width: rd * 2.0, height: rd * 2.0)
		let greenRect: CGRect = redRect.offsetBy(dx: rd, dy: rd)
		let blueRect: CGRect = greenRect.offsetBy(dx: rd, dy: rd)
		
		let redBez: UIBezierPath = UIBezierPath(ovalIn: redRect)
		let greenBez: UIBezierPath = UIBezierPath(ovalIn: greenRect)
		let blueBez: UIBezierPath = UIBezierPath(ovalIn: blueRect)
		
		switch v {
		case 0:
			redLayer.path = redBez.cgPath
			if s {
				redLayer.shadowColor = UIColor.black.cgColor
				redLayer.shadowRadius = 10
				redLayer.shadowOpacity = 1
				redLayer.shadowOffset = .zero
				redLayer.shadowPath = redBez.cgPath
			}
			()
		case 1:
			greenLayer.path = greenBez.cgPath
			()
		case 2:
			blueLayer.path = blueBez.cgPath
			if s {
				blueLayer.shadowColor = UIColor.black.cgColor
				blueLayer.shadowRadius = 10
				blueLayer.shadowOpacity = 1
				blueLayer.shadowOffset = .zero
				blueLayer.shadowPath = blueBez.cgPath
			}
			()
		case 3:
//			blueShadowLayer.isHidden = true
//			layer.shadowColor = UIColor.black.cgColor
//			layer.shadowRadius = 10
//			layer.shadowOpacity = 1
//			layer.shadowOffset = .zero
//			layer.shadowPath = blueBez.cgPath
			blueShadowLayer.path = blueBez.cgPath
			if s {
				blueShadowLayer.shadowColor = UIColor.black.cgColor
				blueShadowLayer.shadowRadius = 10
				blueShadowLayer.shadowOpacity = 1
				blueShadowLayer.shadowOffset = .zero
				blueShadowLayer.shadowPath = blueBez.cgPath
			}
			()
		default:
			()
		}
		
	}
	
}


class yShadowTestVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sView1 = DemoShadowView()
		let sView2 = DemoShadowView()
		let sView3 = DemoShadowView()
		let sView4 = DemoShadowView()

		let g = view.safeAreaLayoutGuide

		let vals: [Int] = [3, 0, 1, 2]
		let vs: [DemoShadowView] = [sView1, sView2, sView3, sView4]
		for (i, v) in zip(vals, vs) {
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
			NSLayoutConstraint.activate([
				v.centerXAnchor.constraint(equalTo: g.centerXAnchor),
				v.centerYAnchor.constraint(equalTo: g.centerYAnchor),
				v.widthAnchor.constraint(equalToConstant: 300.0),
				v.heightAnchor.constraint(equalTo: v.widthAnchor),
			])
			v.v = i
		}
		
		//sView2.s = true
		
		sView1.isHidden = false
		//sView1.s = true

		sView4.s = sView1.isHidden
		
	}
}

class ShadowTestVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sView1 = DemoShadowViewA()
		
		let g = view.safeAreaLayoutGuide

		let v = sView1
		
			v.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(v)
			NSLayoutConstraint.activate([
				v.centerXAnchor.constraint(equalTo: g.centerXAnchor),
				v.centerYAnchor.constraint(equalTo: g.centerYAnchor),
				v.widthAnchor.constraint(equalToConstant: 300.0),
				v.heightAnchor.constraint(equalTo: v.widthAnchor),
			])
		
		v.layer.shadowColor = UIColor.black.cgColor
		v.layer.shadowRadius = 10
		v.layer.shadowOpacity = 1
		v.layer.shadowOffset = CGSize(width: 12, height: 12)

		v.backgroundColor = .systemYellow
	}
}

class DemoShadowViewA: UIView {
	public var v: Int = 0
	public var s: Bool = false
	public var overlapShadow: Bool = true
	
	private let redLayer = CAShapeLayer()
	private let greenLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		let clrs: [UIColor] = [
			.green, .green,
		]
		let lays: [CAShapeLayer] = [
			redLayer, greenLayer,
		]
		for (l, c) in zip(lays, clrs) {
			layer.addSublayer(l)
		}
		redLayer.fillColor = UIColor.green.cgColor
		greenLayer.fillColor = UIColor.clear.cgColor
		greenLayer.strokeColor = UIColor.green.cgColor
		greenLayer.lineWidth = 8
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let rd = bounds.width * 0.15
		
		let redRect: CGRect = CGRect(x: rd * 0.5, y: rd * 0.5, width: rd * 2.0, height: rd * 2.0)
		let greenRect: CGRect = redRect.offsetBy(dx: rd * 2.5, dy: 0)
		
		let redBez: UIBezierPath = UIBezierPath(ovalIn: redRect)
		let greenBez: UIBezierPath = UIBezierPath(ovalIn: greenRect)
		
		redLayer.path = redBez.cgPath
		greenLayer.path = greenBez.cgPath
	}
	
}

class ButtonFontScaleVC: UIViewController {
	var b1: UIButton = {
		let b = UIButton()
		return b
	}()
	var b2: UIButton = {
		let b = UIButton()
		return b
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
	
		let titles: [String] = [
			"Pay by major credit card", "Pay in cash"
		]
		let btns: [UIButton] = [
			b1, b2
		]
		
		let stackView = UIStackView()
		stackView.spacing = 8
		stackView.distribution = .fillEqually
		
		for (b, s) in zip(btns, titles) {
			b.setTitle(s, for: [])
			b.setTitleColor(.white, for: .normal)
			b.layer.cornerRadius = 8
			b.backgroundColor = .red
			stackView.addArrangedSubview(b)
		}
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			stackView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			stackView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
		])
	}

	var b1W: CGFloat = -1
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		if b1W != b1.frame.width {
			print("b1W:", b1W)
			b1W = b1.frame.width
			if b1W < 1.0 {
				view.setNeedsLayout()
				return
			}
			print("b1W:", b1W)

			var titles: [String] = []
			titles.append(b1.currentTitle ?? "A")
			titles.append(b2.currentTitle ?? "B")
			
			guard let oldF: UIFont = UIFont(name: "Times", size: 24) else {
				return
			}
			
			let f: UIFont = fontSizeThatFits(font: oldF, strings: titles, maxW: b1.frame.width - 16.0, maxPS: 24, minPS: 4)
			
			b1.titleLabel?.font = f
			b2.titleLabel?.font = f

		}
		return()
		
		if b1W != b1.frame.width {
			b1W = b1.frame.width
			if b1W < 1.0 {
				view.setNeedsLayout()
				return
			}

			let titles: [String] = [
				"Pay in cash", "Pay by credit card", "Pay in cash"
			]
			let f: UIFont = fontSizeThatFits(font: .systemFont(ofSize: 24), strings: titles, maxW: b1.frame.width - 16.0, maxPS: 24, minPS: 8)

			b1.titleLabel?.font = f
			b2.titleLabel?.font = f

			
//			if let t = b1.currentTitle
//			{
//				var pS: CGFloat = 32
//				var newF: UIFont = .systemFont(ofSize: pS)
//				var w = t.width(withConstrainedHeight: b1.frame.height, font: newF)
//				while w > b1.frame.width {
//					pS -= 1
//					newF = .systemFont(ofSize: pS)
//					w = t.width(withConstrainedHeight: b1.frame.height, font: newF)
//				}
//				print(w, pS)
//				b1.titleLabel?.font = newF
//				b2.titleLabel?.font = newF
//			}
		}

	}
	
	func fontSizeThatFits(font: UIFont, strings: [String], maxW: CGFloat, maxPS: CGFloat, minPS: CGFloat) -> UIFont {
		
		var curPS: CGFloat = maxPS

		var newF: UIFont = UIFont(descriptor: font.fontDescriptor, size: curPS)
		var w: CGFloat = 0
		var minW: CGFloat = maxW
		
		strings.forEach { s in
			w = s.width(withConstrainedHeight: curPS + 2.0, font: newF)
			while w > minW && curPS > minPS {
				curPS -= 1.0
				newF = UIFont(descriptor: font.fontDescriptor, size: curPS)
				w = s.width(withConstrainedHeight: curPS + 2.0, font: newF)
			}
			minW = min(minW, w)
		}
		
		return newF
		
	}
	
}

extension NSAttributedString {
	func height(withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
		
		return ceil(boundingBox.height)
	}
	
	func width(withConstrainedHeight height: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
		
		return ceil(boundingBox.width)
	}
}

extension String {
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
		
		return ceil(boundingBox.height)
	}
	
	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
		
		return ceil(boundingBox.width)
	}
}


class PixelVC: UIViewController {
	@IBOutlet var iv1: UIImageView!
	@IBOutlet var iv2: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let image = UIImage(named: "pixelTest") else { return }
		let modifiedImage = setColor(color: .red, onImage: image, atPoint: CGPoint(x: 5, y: 5))
		
	}
	
	func setColor(color: UIColor, onImage: UIImage, atPoint: CGPoint) -> UIImage {
		let rndr = UIGraphicsImageRenderer(size: onImage.size)
		let newImg = rndr.image { ctx in
			onImage.draw(at: .zero)
			let r = CGRect(origin: atPoint, size: CGSize(width: 1, height: 1))
			ctx.cgContext.setFillColor(color.cgColor)
			ctx.cgContext.addRect(r)
			ctx.cgContext.drawPath(using: .fill)
		}
		return newImg
	}

	func processPixels(in image: UIImage) -> UIImage? {
		guard let inputCGImage = image.cgImage else {
			print("unable to get cgImage")
			return nil
		}
		let colorSpace       = CGColorSpaceCreateDeviceRGB()
		let width            = inputCGImage.width
		let height           = inputCGImage.height
		let bytesPerPixel    = 4
		let bitsPerComponent = 8
		let bytesPerRow      = bytesPerPixel * width
		let bitmapInfo       = RGBA32.bitmapInfo
		
		guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
			print("unable to create context")
			return nil
		}
		context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))
		
		guard let buffer = context.data else {
			print("unable to get context data")
			return nil
		}
		
		let pixelBuffer = buffer.bindMemory(to: RGBA32.self, capacity: width * height)
		
		for row in 0 ..< Int(height) {
			for column in 0 ..< Int(width) {
				let offset = row * width + column
				if pixelBuffer[offset] == .yellow {
					pixelBuffer[offset] = .red
				}
			}
		}
		
		let outputCGImage = context.makeImage()!
		let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
		
		return outputImage
	}
	
	struct RGBA32: Equatable {
		private var color: UInt32
		
		var redComponent: UInt8 {
			return UInt8((color >> 24) & 255)
		}
		
		var greenComponent: UInt8 {
			return UInt8((color >> 16) & 255)
		}
		
		var blueComponent: UInt8 {
			return UInt8((color >> 8) & 255)
		}
		
		var alphaComponent: UInt8 {
			return UInt8((color >> 0) & 255)
		}
		
		init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
			let red   = UInt32(red)
			let green = UInt32(green)
			let blue  = UInt32(blue)
			let alpha = UInt32(alpha)
			color = (red << 24) | (green << 16) | (blue << 8) | (alpha << 0)
		}
		
		static let red     = RGBA32(red: 255, green: 0,   blue: 0,   alpha: 255)
		static let green   = RGBA32(red: 0,   green: 255, blue: 0,   alpha: 255)
		static let blue    = RGBA32(red: 0,   green: 0,   blue: 255, alpha: 255)
		static let white   = RGBA32(red: 255, green: 255, blue: 255, alpha: 255)
		static let black   = RGBA32(red: 0,   green: 0,   blue: 0,   alpha: 255)
		static let magenta = RGBA32(red: 255, green: 0,   blue: 255, alpha: 255)
		static let yellow  = RGBA32(red: 255, green: 255, blue: 0,   alpha: 255)
		static let cyan    = RGBA32(red: 0,   green: 255, blue: 255, alpha: 255)
		
		static let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
		
		static func ==(lhs: RGBA32, rhs: RGBA32) -> Bool {
			return lhs.color == rhs.color
		}
	}
}
