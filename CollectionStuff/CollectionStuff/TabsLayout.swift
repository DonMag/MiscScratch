//
//  TabsLayout.swift
//  CollectionStuff
//
//  Created by Don Mag on 6/28/22.
//

import UIKit

class TabsLayout: NSObject {

}

class SomeView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		initViews()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initViews()
	}
	
	func initViews(){
		let containerStack = UIStackView()
		addSubview(containerStack)
		containerStack.axis = .vertical
		containerStack.distribution = .equalCentering
		containerStack.distribution = .fillEqually
		containerStack.isLayoutMarginsRelativeArrangement = true
		containerStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		
		
		let scrollView = UIScrollView()
		let scrolledStack = UIStackView()
		containerStack.addArrangedSubview(scrollView)
		scrollView.addSubview(scrolledStack)
		scrolledStack.distribution = .fill
		scrolledStack.isLayoutMarginsRelativeArrangement = true
		scrolledStack.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
		
		scrolledStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		scrolledStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		scrolledStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		scrolledStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		scrolledStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		
		
		let otherStack = UIStackView()
		containerStack.addArrangedSubview(otherStack)
		otherStack.distribution = .equalCentering
		otherStack.isLayoutMarginsRelativeArrangement = true
		otherStack.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
		
		
		containerStack.translatesAutoresizingMaskIntoConstraints = false
		containerStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		containerStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		containerStack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		containerStack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		
		
		for number in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]{
			let text = UITextView()
			text.font = UIFont.boldSystemFont(ofSize: 14)
			text.text = number
			text.isScrollEnabled = false
			text.backgroundColor = .cyan
			
			scrolledStack.addArrangedSubview(text)
		}
		for number in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]{
			let text = UITextView()
			text.font = UIFont.boldSystemFont(ofSize: 14)
			text.text = number
			text.isScrollEnabled = false
			text.backgroundColor = .green
			
			otherStack.addArrangedSubview(text)
		}
		
		scrolledStack.translatesAutoresizingMaskIntoConstraints = false

		scrollView.backgroundColor = .red
		scrolledStack.backgroundColor = .lightGray
		otherStack.backgroundColor = .systemBlue
		containerStack.backgroundColor = .systemGreen
		
		
		
	}

}

class AnotherStackVC: UIViewController {
	
	@IBOutlet var someView: SomeView!
	
	var subView1: UIStackView!
	var container: UIStackView!
	var subView2: UIStackView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		someView.isHidden = true
		initLayout()
	}
	fileprivate func initLayout() {
		subView1 = UIStackView()
		subView1.axis = .vertical
		// same for subView2
		subView2 = UIStackView()
		subView2.axis = .vertical

		container = UIStackView()
		container.axis = .vertical
		container.distribution = .fillEqually
		view.addSubview(container!)
		
		container.translatesAutoresizingMaskIntoConstraints = false
		subView1.translatesAutoresizingMaskIntoConstraints = false
		subView2.translatesAutoresizingMaskIntoConstraints = false
		
		container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		container.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		container.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		
		container.addArrangedSubview(subView1)
		container.addArrangedSubview(subView2)
		
		container.backgroundColor = .systemBlue
		subView1.backgroundColor = .systemRed
		subView2.backgroundColor = .systemGreen
	}
	
}

class ToolTipTextView: UITextView {

	var tipView: UIView!
	var btn: UIButton!
	var seg: UISegmentedControl!

	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	func commonInit(){
		
		// we need to see the view outside our bounds
		self.clipsToBounds = false
		
		tipView = UIView()
		tipView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

		btn = UIButton()
		btn.setTitle("Tap Me", for: [])
		btn.setTitleColor(.white, for: .normal)
		btn.setTitleColor(.lightGray, for: .highlighted)
		btn.backgroundColor = .systemBlue
		
		seg = UISegmentedControl(items: ["One", "Two", "Three"])
		
		[tipView, btn, seg].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
		}

		tipView.addSubview(btn)
		tipView.addSubview(seg)
		self.addSubview(tipView)

		NSLayoutConstraint.activate([
			// button at top of tipView, centerX
			btn.topAnchor.constraint(equalTo: tipView.topAnchor, constant: 4.0),
			btn.centerXAnchor.constraint(equalTo: tipView.centerXAnchor),
			
			// seg control below button
			seg.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 4.0),
			seg.bottomAnchor.constraint(equalTo: tipView.bottomAnchor, constant: -4.0),
			seg.leadingAnchor.constraint(equalTo: tipView.leadingAnchor, constant: 4.0),
			seg.trailingAnchor.constraint(equalTo: tipView.trailingAnchor, constant: -4.0),

			// tipView above self, centerX
			tipView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -4.0),
			tipView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
		])
		
		// targets for btn and seg
		btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
		seg.addTarget(self, action: #selector(segSelected(_:)), for: .valueChanged)
		
	}
	
	@objc func btnTapped(_ sender: Any?) {
		let str = self.text ?? ""
		self.text = str + " Button Tapped! "
	}
	@objc func segSelected(_ sender: Any?) {
		guard let ctrl = sender as? UISegmentedControl,
			  let t = ctrl.titleForSegment(at: ctrl.selectedSegmentIndex)
		else { return }
		let str = self.text ?? ""
		self.text = str + " Segment \(t) Selected! "
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

		print(point)
		// convert the touch to the tipView coordinate space
		let cvtPoint = self.convert(point, to: tipView)

		if btn.frame.contains(cvtPoint) {
			return btn
		}
		
		if seg.frame.contains(cvtPoint) {
			return seg
		}

		return super.hitTest(point, with: event)

	}
	
}

class TipTestVC: UIViewController {
	
	let myView = ToolTipTextView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		myView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(myView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			myView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			myView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			myView.heightAnchor.constraint(equalToConstant: 160.0),
			myView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
		])
		
		myView.font = .systemFont(ofSize: 20.0, weight: .light)
		myView.text = "This is text in the text view."

		// so we can see the text view frame
		myView.backgroundColor = .green
		
	}
	
}

extension UIButton {
	func angledCorners() {
		let maskLayer1 = CAShapeLayer()
		maskLayer1.frame = bounds
		
		let pt1: CGPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
		let pt2: CGPoint = CGPoint(x: bounds.minX, y: bounds.midY)
		let pt3: CGPoint = CGPoint(x: bounds.minX + bounds.midY, y: bounds.minY)
		let pt4: CGPoint = CGPoint(x: bounds.maxX, y: bounds.minY)
		let pt5: CGPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
		let pt6: CGPoint = CGPoint(x: bounds.maxX - bounds.midY, y: bounds.maxY)

		let maskPath1: UIBezierPath = UIBezierPath()
		
		maskPath1.move(to: pt1)
		maskPath1.addLine(to: pt2)
		maskPath1.addLine(to: pt3)
		maskPath1.addLine(to: pt4)
		maskPath1.addLine(to: pt5)
		maskPath1.addLine(to: pt6)
		maskPath1.close()

		maskLayer1.path = maskPath1.cgPath
		layer.mask = maskLayer1
	}
}

class InputMenuVC: UIViewController {

	@IBOutlet var b1: UIButton!
	@IBOutlet var b2: UIButton!
	
	@IBAction func b1Tap(_ sender: Any) {
		let vc = InputVC()
		navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func b2Tap(_ sender: Any) {
		let vc = CVInputViewController()
		navigationController?.pushViewController(vc, animated: true)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		b1.angledCorners()
		b2.angledCorners()
	}
}

class InputVC: UIViewController, UITextFieldDelegate {
	
	let stackView: UIStackView = {
		let v = UIStackView()
		v.spacing = 8
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	
	let numDigits: Int = 6
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		view.addSubview(stackView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			stackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
		])
		
		for _ in 0..<numDigits {
			let t = UITextField()
			t.borderStyle = .roundedRect
			t.textAlignment = .center
			t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
			t.keyboardType = .numberPad
			t.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
			t.delegate = self
			stackView.addArrangedSubview(t)
		}
		
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1,
			  let idx = stackView.arrangedSubviews.firstIndex(of: tf)
		else { return }
		
		if idx + 1 == self.numDigits {
			tf.resignFirstResponder()
			// call the verification func
		} else {
			// get a reference to the next text field
			if let nextTF = stackView.arrangedSubviews[idx + 1] as? UITextField {
				// "activate" it
				nextTF.becomeFirstResponder()
			}
		}
	}
	
}


class SingleCharCell: UICollectionViewCell, UITextFieldDelegate {
	
	// "callback" closure
	var textChanged: ((UICollectionViewCell, String) -> ())?
	
	let textField: UITextField = {
		let t = UITextField()
		t.borderStyle = .roundedRect
		t.textAlignment = .center
		t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		t.keyboardType = .numberPad
		return t
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		textField.translatesAutoresizingMaskIntoConstraints = false

		contentView.addSubview(textField)
		
		let v = UIView()
		v.backgroundColor = .lightGray
		v.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(v)
		
		NSLayoutConstraint.activate([
			
			v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
			v.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
			v.heightAnchor.constraint(equalToConstant: 1.0),

			
			// add 4-points "padding" on label top and bottom
			textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.0),
			textField.bottomAnchor.constraint(equalTo: v.topAnchor, constant: -2.0),
			// add 8-points "padding" on label leading/trailing
			//textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			//textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
			textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
		])

		textField.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
		textField.delegate = self
		
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1
		else { return }
		textChanged?(self, t)
	}
	
}

class CVInputViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	// we should never use changed properties of a cell to track user input
	//	so we'll save the entered digits in an array
	var myData: [String] = []
	
	let numDigits: Int = 6
	
	var collectionView: UICollectionView!
	var cellSize: CGSize!
	var cvWidth: CGFloat = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		// get the size of a cell to use for the
		//	flow layout itemSize as well as the
		//	collection view width and height
		let v = SingleCharCell()
		v.textField.text = "0"
		cellSize = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		cellSize.width = 40.0
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .vertical
		fl.itemSize = cellSize
		fl.minimumLineSpacing = 8
		fl.minimumInteritemSpacing = 8
		
		//let cvWidth = CGFloat(numDigits) * cellSize.width + CGFloat(numDigits - 1) * fl.minimumLineSpacing
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			
			collectionView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			collectionView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			
//			collectionView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
//			collectionView.widthAnchor.constraint(equalToConstant: cvWidth),
			
			collectionView.heightAnchor.constraint(equalToConstant: cellSize.height),
		])
		
		collectionView.register(SingleCharCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// init array to hold the entered values
		myData = Array(repeating: "", count: numDigits)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if cvWidth != collectionView.frame.width {
			cvWidth = collectionView.frame.width
			let spc: CGFloat = CGFloat((numDigits - 1) * 8)
			let cw: CGFloat = (cvWidth - spc) / CGFloat(numDigits)
			if let fl = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
				fl.itemSize.width = cw
			}
		}
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numDigits
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! SingleCharCell
		c.textField.text = myData[indexPath.item]
		
		// set the "callback" closure
		c.textChanged = { [weak self] theCell, theText in
			guard let self = self,
				  let idx = collectionView.indexPath(for: theCell),
				  let thisCell = theCell as? SingleCharCell
			else { return }
			
			// update array of entered digits
			self.myData[idx.item] = theText
			
			// if this was the last cell
			if idx.item + 1 == self.numDigits {
				// stop editing
				thisCell.textField.resignFirstResponder()
				// call the verification func
			} else {
				// get a reference to the next cell
				if let nextCell = collectionView.cellForItem(at: IndexPath(item: idx.item + 1, section: 0)) as? SingleCharCell {
					// "activate" the text field in that cell
					nextCell.textField.becomeFirstResponder()
				}
			}
		}
		return c
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		setOnVc(whereToAdd: self, text: "abc", color: .red, heightMultiplier: 1.0)
	}
	public func setOnVc(whereToAdd: UIViewController, text: String, color: UIColor?, heightMultiplier: CGFloat){

		let whatToAdd = aWarningView(colorOfGradient: color)
		//...
	}
	public func showWarningOfFutureDate1(_ vc: UIViewController){
		setOnVc(whereToAdd: vc, text: "⛔️lalala⛔️", color: .red, heightMultiplier: 0.06)
	}

}


class aSingleCharCell: UICollectionViewCell, UITextFieldDelegate {
	
	// "callback" closure
	var textChanged: ((UICollectionViewCell, String) -> ())?
	
	let textField: UITextField = {
		let t = UITextField()
		t.borderStyle = .roundedRect
		t.textAlignment = .center
		t.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
		t.keyboardType = .numberPad
		return t
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		textField.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(textField)
		
		NSLayoutConstraint.activate([
			// add 4-points "padding" on label top and bottom
			textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
			textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
			// add 8-points "padding" on label leading/trailing
			textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0.0),
			textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
		])
		
		textField.addTarget(self, action: #selector(textEdited(_:)), for: .editingChanged)
		textField.delegate = self
		
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// don't allow paste of more than one character
		if string.count > 1 {
			return false
		}
		// allow backspace
		if string.isEmpty {
			return true
		}
		// only allow digits
		let str = string.filter("0123456789".contains)
		if str.isEmpty {
			return false
		}
		textField.text = str
		// .editingChanged is not triggered when setting the .text property
		//	so we call it from here
		textEdited(textField)
		return false
	}
	
	@objc func textEdited(_ tf: UITextField) {
		guard let t = tf.text,
			  t.count == 1
		else { return }
		textChanged?(self, t)
	}
	
}

class aCVInputViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	// we should never use changed properties of a cell to track user input
	//	so we'll save the entered digits in an array
	var myData: [String] = []
	
	let numDigits: Int = 10
	
	var collectionView: UICollectionView!
	var cellSize: CGSize!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground
		
		// get the size of a cell to use for the
		//	flow layout itemSize as well as the
		//	collection view width and height
		let v = SingleCharCell()
		v.textField.text = "0"
		cellSize = v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		
		let fl = UICollectionViewFlowLayout()
		fl.scrollDirection = .horizontal
		fl.itemSize = cellSize
		fl.minimumLineSpacing = 8
		fl.minimumInteritemSpacing = 8
		
		let cvWidth = CGFloat(numDigits) * cellSize.width + CGFloat(numDigits - 1) * fl.minimumLineSpacing
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: fl)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			collectionView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			collectionView.widthAnchor.constraint(equalToConstant: cvWidth),
			collectionView.heightAnchor.constraint(equalToConstant: cellSize.height),
		])
		
		collectionView.register(SingleCharCell.self, forCellWithReuseIdentifier: "c")
		collectionView.dataSource = self
		collectionView.delegate = self
		
		// init array to hold the entered values
		myData = Array(repeating: "", count: numDigits)
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numDigits
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let c = collectionView.dequeueReusableCell(withReuseIdentifier: "c", for: indexPath) as! SingleCharCell
		c.textField.text = myData[indexPath.item]
		
		// set the "callback" closure
		c.textChanged = { [weak self] theCell, theText in
			guard let self = self,
				  let idx = collectionView.indexPath(for: theCell),
				  let thisCell = theCell as? SingleCharCell
			else { return }
			
			// update array of entered digits
			self.myData[idx.item] = theText
			
			// if this was the last cell
			if idx.item + 1 == self.numDigits {
				// stop editing
				thisCell.textField.resignFirstResponder()
				// call the verification func
			} else {
				// get a reference to the next cell
				if let nextCell = collectionView.cellForItem(at: IndexPath(item: idx.item + 1, section: 0)) as? SingleCharCell {
					// "activate" the text field in that cell
					nextCell.textField.becomeFirstResponder()
				}
			}
		}
		return c
	}

}

class aWarningView: UIView {
	// give it a default value
	var colorOfGradient: UIColor = .blue
	
	convenience init(colorOfGradient: UIColor?) {
		self.init(frame: CGRect.zero)
		
		// unwrap optional
		if let c = colorOfGradient {
			self.colorOfGradient = c
		}
		print(self.colorOfGradient as Any)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		print(colorOfGradient as Any)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
//...

class BoxView: UIView {
	
	public var fillColor: UIColor = .red {
		didSet {
			shapeLayer.fillColor = fillColor.cgColor
		}
	}
	public var strokeColor: UIColor = .black {
		didSet {
			shapeLayer.strokeColor = strokeColor.cgColor
		}
	}

	private let shapeLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		layer.addSublayer(shapeLayer)
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.strokeColor = strokeColor.cgColor
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		let oneThirdHeight: CGFloat = bounds.height / 3.0
		let bez: UIBezierPath = UIBezierPath()
		var pt: CGPoint = .zero
		
		pt.x = bounds.minX
		pt.y = bounds.maxY
		bez.move(to: pt)

		pt.y = bounds.maxY - oneThirdHeight
		bez.addLine(to: pt)
		
		pt.x = bounds.minX + oneThirdHeight * 2.0
		pt.y = bounds.minY
		bez.addLine(to: pt)

		pt.x = bounds.maxX
		bez.addLine(to: pt)

		pt.y = bounds.minY + oneThirdHeight
		bez.addLine(to: pt)
		
		pt.x = bounds.maxX - oneThirdHeight * 2.0
		pt.y = bounds.maxY
		bez.addLine(to: pt)
		
		bez.close()

		shapeLayer.path = bez.cgPath
	}
}

class SomeTableCell: UITableViewCell {
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var genderLabel: UILabel!
	@IBOutlet var passedOutLabel: UILabel!
	@IBOutlet var commentsLabel: UILabel!

}
class SomeTableVC: UITableViewController {

	var myData: [[String]] = []
	
	let dataSource = ContactEmailDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sampleComments: [String] = [
			"This is a one line comment.",
			"This comment should be long enough to wrap onto two or more lines.",
			"This comment\nHas newline breaks\nto give us\nFour lines.",
			"This comment will be long enough to word wrap, and we will add some newlines.\nLike this.\n\nAnd a double-newline to leave a blank line in the paragraph.",
		]
		
		// create some sample data
		for (i, str) in sampleComments.enumerated() {
			var strings: [String] = []
			strings.append("Name \(i)")
			strings.append("Gender \(i)")
			strings.append("Passed Out \(i)")
			strings.append(str)
			myData.append(strings)
		}
		
		print("")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "someCell", for: indexPath) as! SomeTableCell
		let strs = myData[indexPath.row]
		c.nameLabel.text = strs[0]
		c.genderLabel.text = strs[1]
		c.passedOutLabel.text = strs[2]
		c.commentsLabel.text = strs[3]
		
		if indexPath.row < dataSource.countOfEmails() {
			let cellContact = dataSource.emailAtIndex(index: indexPath.row)
			//cell.textLabel?.text = cellContact.emailAddress
			c.nameLabel.text = cellContact.emailAddress
		}

		
		return c
	}
	
}

class ContactEmail: NSObject
{
	var emailAddress: String
	
	override init ()
	{
		emailAddress = "example@email.com"
		super.init()
	}
	
	init(emailAddress email: String)
	{
		emailAddress = email
		super.init()
	}
}

class ContactEmailDataSource: NSObject
{
	let emailAddresses = NSMutableArray()
	
	override init()
	{
		super.init()
		loadEmailAddresses()
	}
	func loadEmailAddresses()
	{
		let sample1 = ContactEmail()
		emailAddresses.add(sample1)
		let sample2 = ContactEmail(emailAddress: "example@example.com")
		addEmail(contact: sample2)
	}
	func addEmail(contact c: ContactEmail)
	{
		emailAddresses.add(c)
	}
	func countOfEmails() -> Int
	{
		return emailAddresses.count
	}
	func emailAtIndex(index i: Int) -> ContactEmail
	{
		return emailAddresses.object(at: i) as! ContactEmail
	}
}

class AddressBookTableViewController: UITableViewController {
	let dataSource = ContactEmailDataSource()
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar
		//for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return dataSource.countOfEmails()
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
		
		let cellContact = dataSource.emailAtIndex(index: indexPath.row)
		cell.textLabel?.text = cellContact.emailAddress
		
		return cell
	}
	
	
	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */
	
	/*
	 // Override to support editing the table view.
	 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	 if editingStyle == .delete {
	 // Delete the row from the data source
	 tableView.deleteRows(at: [indexPath], with: .fade)
	 } else if editingStyle == .insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */
	
	/*
	 // Override to support rearranging the table view.
	 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	 
	 }
	 */
	
	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}


class PieView: UIView {
	
	private let shapeLayer1 = CAShapeLayer()
	private let shapeLayer2 = CAShapeLayer()

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		[shapeLayer1, shapeLayer2].forEach { v in
			layer.addSublayer(v)
			v.fillColor = UIColor.systemOrange.cgColor
			v.strokeColor = UIColor.systemOrange.cgColor
			v.lineWidth = 2
		}
		shapeLayer1.fillColor = UIColor.clear.cgColor
	}
	override func layoutSubviews() {
		super.layoutSubviews()

		var bez: UIBezierPath!
		let ptC: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)
		let a1: Double = -90.0 * .pi / 180.0
		let a2: Double = 135.0 * .pi / 180.0

		bez = UIBezierPath()
		bez.addArc(withCenter: ptC, radius: bounds.midX, startAngle: a2, endAngle: a1, clockwise: true)
		shapeLayer1.path = bez.cgPath

		bez = UIBezierPath()
		bez.move(to: ptC)
		bez.addArc(withCenter: ptC, radius: bounds.midX, startAngle: a1, endAngle: a2, clockwise: true)
		bez.close()
		shapeLayer2.path = bez.cgPath
	}
	
}

enum LayoutDirection: Int {
	case left, right
}
struct MyDataStruct {
	var first: String = ""
	var second: String = ""
	var third: String = ""
}

class DashedArcView: UIView {
	
	public var startDirection: LayoutDirection = .right
	
	public var rowHeights: [CGFloat] = []
	
	public var yOff: CGFloat = 0.0 {
		didSet {
			// disable layer animation and update the
			//	shape layer's y position
			CATransaction.begin()
			CATransaction.setDisableActions(true)
			shapeLayer.frame.origin.y = yOff
			CATransaction.commit()
		}
	}
	
	var shapeLayer: CAShapeLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		layer.addSublayer(shapeLayer)
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineWidth = 4
		shapeLayer.lineDashPattern = [20, 10]
		
		shapeLayer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
	}
	func updatePath() {
		
		guard rowHeights.count > 0 else { return }
		
		// distance from left/right edge for the arc
		let inset: CGFloat = 32.0
		
		let angleStart: Double = -90.0 * .pi / 180.0
		let angleEnd: Double = 90.0 * .pi / 180.0
		
		var currentY: CGFloat = 0.0
		
		let bez = UIBezierPath()
		bez.move(to: CGPoint(x: bounds.midX, y: 0.0))
		
		let iDir: Int = startDirection == .right ? 0 : 1
		
		// loop through the rowHeights,
		//	adding lines and arcs (alternating left/right/left/right/etc)
		//	to the bezier path
		for i in 0..<rowHeights.count {
			let radius = rowHeights[i] * 0.5
			if i % 2 == iDir {
				bez.addLine(to: CGPoint(x: bounds.maxX - (inset + radius), y: currentY))
				bez.addArc(withCenter: CGPoint(x: bounds.maxX - (inset + radius), y: currentY + radius), radius: radius, startAngle: angleStart, endAngle: angleEnd, clockwise: true)
			} else {
				bez.addLine(to: CGPoint(x: bounds.minX + inset + radius, y: currentY))
				bez.addArc(withCenter: CGPoint(x: bounds.minX + inset + radius, y: currentY + radius), radius: radius, startAngle: angleStart, endAngle: angleEnd, clockwise: false)
			}
			currentY += rowHeights[i]
			bez.addLine(to: CGPoint(x: bounds.midX, y: currentY))

			shapeLayer.frame.size = CGSize(width: 200.0, height: bez.currentPoint.y)
		}
		
		// disable layer animation and update the
		//	shape layer's path and y position
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		shapeLayer.path = bez.cgPath
		CATransaction.commit()
	}
/*
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard rowHeights.count > 0 else { return }
		
		// distance from left/right edge for the arc
		let inset: CGFloat = 32.0
		
		let angleStart: Double = -90.0 * .pi / 180.0
		let angleEnd: Double = 90.0 * .pi / 180.0
		
		var currentY: CGFloat = 0.0
		
		let bez = UIBezierPath()
		bez.move(to: CGPoint(x: bounds.midX, y: 0.0))

		let iDir: Int = startDirection == .right ? 0 : 1
		
		// loop through the rowHeights,
		//	adding lines and arcs (alternating left/right/left/right/etc)
		//	to the bezier path
		for i in 0..<rowHeights.count {
			let radius = rowHeights[i] * 0.5
			if i % 2 == iDir {
				bez.addLine(to: CGPoint(x: bounds.maxX - (inset + radius), y: currentY))
				bez.addArc(withCenter: CGPoint(x: bounds.maxX - (inset + radius), y: currentY + radius), radius: radius, startAngle: angleStart, endAngle: angleEnd, clockwise: true)
			} else {
				bez.addLine(to: CGPoint(x: bounds.minX + inset + radius, y: currentY))
				bez.addArc(withCenter: CGPoint(x: bounds.minX + inset + radius, y: currentY + radius), radius: radius, startAngle: angleStart, endAngle: angleEnd, clockwise: false)
			}
			currentY += rowHeights[i]
			bez.addLine(to: CGPoint(x: bounds.midX, y: currentY))
		}
		
		// disable layer animation and update the
		//	shape layer's path and y position
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		shapeLayer.path = bez.cgPath
		shapeLayer.frame.origin.y = yOff
		CATransaction.commit()
	}
*/
	
}

class PiesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var myData: [MyDataStruct] = []
	
	let tableView = UITableView()
	
	let bkgView = DashedArcView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sampleStrings: [String] = [
			"Short string.",
			"Medium length string that may or may not wrap.",
			"This is a very long string that will definitely wrap. When running on an iPhone 8 in portrait orientation, it should wrap to three or four lines."
		]
		// generate some sample data
		var thirdLabelLineCounts: [Int] = [
			6, 2, 4, 3, 2, 1, 3, 4, 4, 5, 4, 3, 1, 5, 6, 7, 8, 5, 4, 3, 5, 28, 28, 2, 28,
		]
		//thirdLabelLineCounts = Array(repeating: 1, count: 100)
		for (i, n) in thirdLabelLineCounts.enumerated() {
			var str: MyDataStruct = MyDataStruct()
			str.first = "Level \(i)"
			str.second = "Foundation \(i)"
			//str.third = ((1...n).map { "Line \($0)" }).joined(separator: "\n")
			str.third = sampleStrings[n % sampleStrings.count]
			myData.append(str)
		}
		
		let g = view.safeAreaLayoutGuide
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		bkgView.translatesAutoresizingMaskIntoConstraints = false
		bkgView.startDirection = .right
		tableView.backgroundView = bkgView
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0),
			
			bkgView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0),
			bkgView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
			bkgView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
			bkgView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0),
		])
		
		tableView.register(PieCell.self, forCellReuseIdentifier: "c")
		tableView.dataSource = self
		tableView.delegate = self
		//tableView.separatorStyle = .none
		
		// because the dashed line will extend above the top of the first cell
		// 	and below the bottom of the last cell
		// we want to add a little "inset padding" on top and bottom of the table view
		
		var defaultInset = tableView.contentInset
		defaultInset.top += 8
		defaultInset.bottom += 8
		tableView.contentInset = defaultInset

		tableView.contentInsetAdjustmentBehavior = .never
		tableView.contentOffset.y = -8
		
		
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		//tableView.scrollToRow(at: IndexPath(row: 90, section: 0), at: .none, animated: true)
	}
	var tvWidth: CGFloat = 0
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if tvWidth != tableView.frame.width {
			tvWidth = tableView.frame.width
			let c = PieCell()
			//c.frame.size.width = tableView.frame.width
			var rHeights: [CGFloat] = []
			myData.forEach { str in
				c.fillData(str, direction: .right)
				let sz = c.systemLayoutSizeFitting(CGSize(width: tvWidth, height: 50), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
				rHeights.append(sz.height)
			}
			print(rHeights)
			bkgView.rowHeights = rHeights
			bkgView.updatePath()
			bkgView.yOff = -tableView.contentOffset.y
		}
		
//		c.setNeedsLayout()
//		c.layoutIfNeeded()
		// this will be called when the frame changes (such as on device rotation)
		//	so we have to re-calculate the row heights
		//	which will update the background view
		scrollViewDidScroll(tableView)
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! PieCell
		let dir: LayoutDirection = indexPath.row % 2 == 0 ? .right : .left
		c.fillData(myData[indexPath.row], direction: dir)
		return c
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(bkgView.shapeLayer.frame, tableView.contentOffset.y)
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		bkgView.yOff = -scrollView.contentOffset.y

//		if let tv = scrollView as? UITableView {
//			if let a = tv.indexPathsForVisibleRows {
//				var needsUpdate: Bool = false
//				// get the current array of heights from bkgView
//				var rHeights: [CGFloat] = bkgView.rowHeights
//				// loop through visible rows
//				a.forEach { pth in
//					if let c = tv.cellForRow(at: pth) {
//						let f = c.frame
//						if pth.row > rHeights.count - 1 {
//							rHeights.append(0.0)
//						}
//						if rHeights[pth.row] != f.size.height {
//							needsUpdate = true
//							rHeights[pth.row] = f.size.height
//						}
//					}
//				}
//				// only tell bkgView to re-generate its path
//				//	if the height of one or more rows has changed
//				if needsUpdate {
//					bkgView.rowHeights = rHeights
//					bkgView.setNeedsLayout()
//				}
//			}
//			// update background view's y-offset
//			bkgView.yOff = -scrollView.contentOffset.y
//		}
	}
}


class PieCell: UITableViewCell {
	
	private var layoutDirection: LayoutDirection = .right {
		didSet {
			
			// update horizontal constraints to position the pieView and labels stack view
			
			let g = contentView

			pieHorizontalConstraint.isActive = false
			stackLeadingConstraint.isActive = false
			stackTrailingConstraint.isActive = false

			if layoutDirection == .left {
				// pie is on the left
				pieHorizontalConstraint = pieView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 48.0)
				stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: pieView.trailingAnchor, constant: 20.0)
				stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -40.0)
				[firstLabel, secondLabel, thirdLabel].forEach { v in
					v.textAlignment = .left
				}
			} else {
				// pie is on the right
				pieHorizontalConstraint = pieView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -48.0)
				stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 40.0)
				stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: pieView.leadingAnchor, constant: -20.0)
				[firstLabel, secondLabel, thirdLabel].forEach { v in
					v.textAlignment = .right
				}
			}

			pieHorizontalConstraint.isActive = true
			stackLeadingConstraint.isActive = true
			stackTrailingConstraint.isActive = true
			
		}
	}
	
	func fillData(_ str: MyDataStruct, direction: LayoutDirection) {
		firstLabel.text = str.first
		secondLabel.text = str.second
		thirdLabel.text = str.third
		layoutDirection = direction
	}
	
	private let pieView = PieView()
	
	private let firstLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 13.0, weight: .regular)
		return v
	}()
	private let secondLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 16.0, weight: .bold)
		return v
	}()
	private let thirdLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 13.0, weight: .regular)
		v.numberOfLines = 0
		return v
	}()
	
	// stack view for the labels
	private let stack: UIStackView = {
		let v = UIStackView()
		v.axis = .vertical
		v.spacing = 2
		return v
	}()

	private var pieHorizontalConstraint: NSLayoutConstraint!
	private var stackLeadingConstraint: NSLayoutConstraint!
	private var stackTrailingConstraint: NSLayoutConstraint!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		[firstLabel, secondLabel, thirdLabel].forEach { v in
			v.setContentCompressionResistancePriority(.required, for: .vertical)
			stack.addArrangedSubview(v)
		}
		[pieView, stack].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(v)
		}
		
		let g = contentView
		
		// initialize the horizontal constraints that we will update
		//	based on left or right layout
		pieHorizontalConstraint = pieView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 60.0)
		stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: pieView.trailingAnchor, constant: 20.0)
		stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: pieView.leadingAnchor, constant: -20.0)
		
		// avoid auto-layout complaints
		// 	pieView is square (1:1 ratio)

		// pieView width constant
		pieView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		let pieHeightConstraint = pieView.heightAnchor.constraint(equalTo: pieView.widthAnchor)
		pieHeightConstraint.priority = .required - 1
		pieHeightConstraint.isActive = true
		
		NSLayoutConstraint.activate([
			
			// center the pieView vertically
			pieView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			
			// we want at least 12-points above and below the pieView
			pieView.topAnchor.constraint(greaterThanOrEqualTo: g.topAnchor, constant: 12.0),
			pieView.bottomAnchor.constraint(lessThanOrEqualTo: g.bottomAnchor, constant: -12.0),
			
			// center the labels stack view vertically
			stack.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			
			// we want at least 12-points above and below the stack view
			stack.topAnchor.constraint(greaterThanOrEqualTo: g.topAnchor, constant: 12.0),
			stack.bottomAnchor.constraint(lessThanOrEqualTo: g.bottomAnchor, constant: -12.0),

		])
		
		// we need to see the table view's background view through the cells
		contentView.backgroundColor = .clear
		self.backgroundColor = .clear
	
		// during development, if we want to see the framing
		//pieView.backgroundColor = .green
		//stack.backgroundColor = .yellow
	}
	
}

/*
class xPiesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var myData: [MyDataStruct] = []
	
	let tableView = UITableView()
	
	let bkgView = DashedArcView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// generate some sample data
		for i in 0..<30 {
			var str: MyDataStruct = MyDataStruct()
			str.first = "Level \(i)"
			str.second = "Foundation \(i)"
			str.third = "Row \(i) some text"
			if i % 3 == 0 {
				str.third = "Row \(i) with lots of text so we can see what happends when the cell is taller than the others.\nA\nB\nC\nD"
			}
			str.direction = i % 2 == 0 ? .right : .left
			myData.append(str)
		}
		
		let g = view.safeAreaLayoutGuide
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		bkgView.translatesAutoresizingMaskIntoConstraints = false
		bkgView.startDirection = .right
		tableView.backgroundView = bkgView
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0),
			
			bkgView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0),
			bkgView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
			bkgView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
			bkgView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0),
		])
		
		tableView.register(PieCell.self, forCellReuseIdentifier: "c")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .none
		
		// because the dashed line will extend above the top of the first cell
		// 	and below the bottom of the last cell
		// we want to add a little "inset padding" on top and bottom of the table view
		
		tableView.contentInsetAdjustmentBehavior = .never
		
		var defaultInset = tableView.contentInset
		defaultInset.top += 8
		defaultInset.bottom += 8
		tableView.contentInset = defaultInset
		tableView.contentOffset.y = -8
	}
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// this will be called when the frame changes (such as on device rotation)
		//	so we have to re-calculate the row heights
		//	which will update the background view
		scrollViewDidScroll(tableView)
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! PieCell
		c.fillData(myData[indexPath.row])
		return c
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if let tv = scrollView as? UITableView {
			if let a = tv.indexPathsForVisibleRows {
				var rHeights: [CGFloat] = bkgView.rowHeights
				a.forEach { pth in
					if let c = tv.cellForRow(at: pth) {
						let f = c.frame
						if pth.row > rHeights.count - 1 {
							rHeights.append(0.0)
						}
						rHeights[pth.row] = f.size.height
					}
				}
				bkgView.yOff = -scrollView.contentOffset.y
				bkgView.rowHeights = rHeights
				bkgView.setNeedsLayout()
			}
		}
	}
}
*/

class ArcVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let st = UIStackView()
		st.axis = .vertical
		st.spacing = 0
		st.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(st)
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			st.topAnchor.constraint(equalTo: g.topAnchor, constant: 40),
			st.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20),
			st.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20),
		])

		let hs: [CGFloat] = [
			80, 80, 120, 160,
		]
		let dr: [LayoutDirection] = [
			.right, .left, .right, .left,
		]
		for (h, d) in zip(hs, dr) {
			let v = MyDashedArcView()
			v.backgroundColor = .yellow.withAlphaComponent(0.25)
			v.layoutDirection = d
			v.heightAnchor.constraint(equalToConstant: h).isActive = true
			st.addArrangedSubview(v)
		}
		
	}
	
}

class SampleTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var myData: [MyDataStruct] = []
	
	let tableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// generate some sample data
		let sampleStrings: [String] = [
			"Short string.",
			"Medium length string that may or may not wrap.",
			"This is a very long string that will definitely wrap. When running on an iPhone 8 in portrait orientation, it should wrap to four lines.",
		]
		let thirdLabels: [Int] = [
			0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 1, 2, 2, 2,
		]
		var rowNum: Int = 0
		thirdLabels.forEach { n in
			var str: MyDataStruct = MyDataStruct()
			str.first = "Level \(rowNum)"
			str.second = "Foundation \(rowNum)"
			str.third = sampleStrings[n % sampleStrings.count]
			myData.append(str)
			rowNum += 1
		}
		// and some more data, with increasing number of lines for the third label
		for i in 4...16 {
			var str: MyDataStruct = MyDataStruct()
			str.first = "Level \(rowNum)"
			str.second = "Foundation \(rowNum)"
			str.third = (1...i).compactMap({"Line \($0)"}).joined(separator: "\n")
			myData.append(str)
			rowNum += 1
		}
		// and a few rows with extremely long strings
		let reallyLongString = "UILabel - A label can contain an arbitrary amount of text, but UILabel may shrink, wrap, or truncate the text, depending on the size of the bounding rectangle and properties you set. You can control the font, text color, alignment, highlighting, and shadowing of the text in the label.\n\nUITextField - Displays a rounded rectangle that can contain editable text. When a user taps a text field, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text field can handle the input in an application-specific way. UITextField supports overlay views to display additional information, such as a bookmarks icon. UITextField also provides a clear text control a user taps to erase the contents of the text field."
		for _ in 1...5 {
			var str: MyDataStruct = MyDataStruct()
			str.first = "Level \(rowNum)"
			str.second = "Foundation \(rowNum)"
			str.third = reallyLongString
			myData.append(str)
			rowNum += 1
		}
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0),
			tableView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0),
		])
		
		tableView.register(MyPieCell.self, forCellReuseIdentifier: "c")
		tableView.dataSource = self
		tableView.delegate = self
		tableView.separatorStyle = .none
		
		// because the dashed line will extend above the top of the first cell
		// 	and below the bottom of the last cell
		//	we want to add a little "inset padding" on top and bottom of the table view
		
		var defaultInset = tableView.contentInset
		defaultInset.top += 8
		defaultInset.bottom += 8
		tableView.contentInset = defaultInset
		
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.contentOffset.y = -8
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! MyPieCell
		let dir: LayoutDirection = indexPath.row % 2 == 0 ? .right : .left
		c.fillData(myData[indexPath.row], direction: dir)
		return c
	}
	
}


class MyDashedArcView: UIView {
	
	public var layoutDirection: LayoutDirection = .left {
		didSet {
			setNeedsLayout()
		}
	}
	
	private var shapeLayer: CAShapeLayer!
	
	override class var layerClass: AnyClass {
		return CAShapeLayer.self
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		shapeLayer = self.layer as? CAShapeLayer
		shapeLayer.strokeColor = UIColor.blue.cgColor
		shapeLayer.lineWidth = 4
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineDashPattern = [20, 10]
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let inset: CGFloat = 32.0
		let radius: CGFloat = bounds.midY
		var ptC: CGPoint = CGPoint(x: 0.0, y: bounds.midY)
		ptC.x = layoutDirection == .right ? bounds.maxX - (inset + radius) : inset + radius
		let a1: Double = -90.0 * .pi / 180.0
		let a2: Double = 90.0 * .pi / 180.0
		let xOff: CGFloat = 0.0
		
		let bez = UIBezierPath()
		bez.move(to: CGPoint(x: bounds.midX + xOff, y: bounds.minY - 0.0))
		bez.addLine(to: CGPoint(x: ptC.x, y: bounds.minY))
		if layoutDirection == .right {
			bez.addArc(withCenter: ptC, radius: bounds.midY, startAngle: a1, endAngle: a2, clockwise: true)
		} else {
			bez.addArc(withCenter: ptC, radius: bounds.midY, startAngle: a1, endAngle: a2, clockwise: false)
		}
		bez.addLine(to: CGPoint(x: bounds.midX + xOff, y: bounds.maxY))
		shapeLayer.path = bez.cgPath
	}
}

class MyPieCell: UITableViewCell {
	
	private var layoutDirection: LayoutDirection = .right {
		didSet {
			
			// update horizontal constraints to position the pieView and labels stack view
			
			let g = contentView
			
			pieHorizontalConstraint.isActive = false
			stackLeadingConstraint.isActive = false
			stackTrailingConstraint.isActive = false
			
			if layoutDirection == .left {
				// pie is on the left
				pieHorizontalConstraint = pieView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 48.0)
				stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: pieView.trailingAnchor, constant: 20.0)
				stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -40.0)
				[firstLabel, secondLabel, thirdLabel].forEach { v in
					v.textAlignment = .left
				}
			} else {
				// pie is on the right
				pieHorizontalConstraint = pieView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -48.0)
				stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 40.0)
				stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: pieView.leadingAnchor, constant: -20.0)
				[firstLabel, secondLabel, thirdLabel].forEach { v in
					v.textAlignment = .right
				}
			}
			
			pieHorizontalConstraint.isActive = true
			stackLeadingConstraint.isActive = true
			stackTrailingConstraint.isActive = true
			
		}
	}
	
	func fillData(_ str: MyDataStruct, direction: LayoutDirection) {
		firstLabel.text = str.first
		secondLabel.text = str.second
		thirdLabel.text = str.third
		layoutDirection = direction
		arcView.layoutDirection = direction
	}
	
	private let pieView = PieView()
	private let arcView = MyDashedArcView()
	
	private let firstLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 13.0, weight: .regular)
		return v
	}()
	private let secondLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 16.0, weight: .bold)
		return v
	}()
	private let thirdLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 13.0, weight: .regular)
		v.numberOfLines = 0
		return v
	}()
	
	// stack view for the labels
	private let stack: UIStackView = {
		let v = UIStackView()
		v.axis = .vertical
		v.spacing = 2
		return v
	}()
	
	private var pieHorizontalConstraint: NSLayoutConstraint!
	private var stackLeadingConstraint: NSLayoutConstraint!
	private var stackTrailingConstraint: NSLayoutConstraint!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		[firstLabel, secondLabel, thirdLabel].forEach { v in
			v.setContentCompressionResistancePriority(.required, for: .vertical)
			stack.addArrangedSubview(v)
		}
		[arcView, pieView, stack].forEach { v in
			v.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(v)
		}
		
		let g = contentView
		
		// initialize the horizontal constraints that we will update
		//	based on left or right layout
		pieHorizontalConstraint = pieView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 60.0)
		stackLeadingConstraint = stack.leadingAnchor.constraint(equalTo: pieView.trailingAnchor, constant: 20.0)
		stackTrailingConstraint = stack.trailingAnchor.constraint(equalTo: pieView.leadingAnchor, constant: -20.0)
		
		// giving avoid auto-layout complaints
		// 	pieView is square (1:1 ratio)
		
		// pieView width constant
		pieView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
		
		let pieHeightConstraint = pieView.heightAnchor.constraint(equalTo: pieView.widthAnchor)
		pieHeightConstraint.priority = .required - 1
		pieHeightConstraint.isActive = true
		
		NSLayoutConstraint.activate([
			
			// constrain arcView to all 4 sides
			arcView.topAnchor.constraint(equalTo: g.topAnchor),
			arcView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			arcView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
			arcView.bottomAnchor.constraint(equalTo: g.bottomAnchor),

			// center the pieView vertically
			pieView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			
			// we want at least 12-points above and below the pieView
			pieView.topAnchor.constraint(greaterThanOrEqualTo: g.topAnchor, constant: 12.0),
			pieView.bottomAnchor.constraint(lessThanOrEqualTo: g.bottomAnchor, constant: -12.0),
			
			// center the labels stack view vertically
			stack.centerYAnchor.constraint(equalTo: g.centerYAnchor),
			
			// we want at least 12-points above and below the stack view
			stack.topAnchor.constraint(greaterThanOrEqualTo: g.topAnchor, constant: 12.0),
			stack.bottomAnchor.constraint(lessThanOrEqualTo: g.bottomAnchor, constant: -12.0),
			
		])
		
		// we need to see the table view's background view through the cells
		contentView.backgroundColor = .clear
		self.backgroundColor = .clear
		
		// during development, if we want to see the framing
		//pieView.backgroundColor = .green
		//stack.backgroundColor = .yellow
	}
	
}




class TVTestVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemYellow
		
		let v = UIView()
		v.backgroundColor = .cyan
		
		let t = UITextView()
		t.text = "This is some text in the text view, so we can see it."
		
		v.translatesAutoresizingMaskIntoConstraints = false
		t.translatesAutoresizingMaskIntoConstraints = false
		
		v.addSubview(t)
		view.addSubview(v)

		// minimum width for v
		let m: CGFloat = 200.0
		
		// text view width
		//	change this to see how v responds
		let tW: CGFloat = 160.0
		
		// text view height
		let tH: CGFloat = 128.0
		
		// respect safe area
		let g = view.safeAreaLayoutGuide
		
		// we want v to get wider if t is wider than m
		let vMatchW: NSLayoutConstraint = v.widthAnchor.constraint(equalTo: t.widthAnchor)

		// but we give it less-than-required priority so it never gets narrower than m
		vMatchW.priority = .defaultHigh
		
		NSLayoutConstraint.activate([
			
			// text view width and height
			t.widthAnchor.constraint(equalToConstant: tW),
			t.heightAnchor.constraint(equalToConstant: tH),
			
			// t Top/Bottom to v Top/Bottom (with 8-points "padding" so we can see it better
			t.topAnchor.constraint(equalTo: v.topAnchor, constant: 8.0),
			t.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -8.0),
			
			// we want t centered horizontally in v if t is narrower than m
			t.centerXAnchor.constraint(equalTo: v.centerXAnchor),
			
			// v is AT LEAST m width
			v.widthAnchor.constraint(greaterThanOrEqualToConstant: m),
			
			// activate the lower-priority width constraint
			vMatchW,
			
			// let's place v 40-points from the top
			v.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			
			// center v horizontally
			v.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			
		])
	}
	
}

class ScriptEditingView: UITextView, UITextViewDelegate {
}

class StrTestVC: UIViewController, UITextViewDelegate {
	
	var textView: ScriptEditingView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textView = ScriptEditingView(frame: .zero, textContainer: nil)
		textView.backgroundColor = .black
		textView.delegate = self
		view.addSubview(textView)
		textView.allowsEditingTextAttributes = true
		
		let guide = view.safeAreaLayoutGuide
		
		textView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			textView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
			textView.topAnchor.constraint(equalTo: view.topAnchor),
			textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		let attributedString = sampleAttrString()

		textView.attributedText = attributedString
		
		NSLog("Attributed now")
		dumpAttributesOfText()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			NSLog("Attributes after 1 sec")
			self.dumpAttributesOfText()
		}
	}

	private func dumpAttributesOfText() {
		textView.attributedText?.enumerateAttributes(in: NSRange(location: 0, length: textView.attributedText!.length), options: .longestEffectiveRangeNotRequired, using: { dictionary, range, stop in
			NSLog(" range \(range)")
			
			if let font = dictionary[.font] as? UIFont {
				NSLog("Font at range \(range) - \(font.fontName), \(font.pointSize)")
			}
			
			if let foregroundColor = dictionary[.foregroundColor] as? UIColor {
				NSLog("Foregroundcolor \(foregroundColor) at range \(range)")
			}
			
			if let underline = dictionary[.underlineStyle] as? Int {
				NSLog("Underline \(underline) at range \(range)")
			}
		})
	}
	
	func sampleAttrString() -> NSMutableAttributedString {
		guard let theFont: UIFont = UIFont(name: "HelveticaNeue", size: 30.0) else {
			fatalError()
		}
		
		let attsA: [NSAttributedString.Key : Any] = [
			.font: theFont,
			.foregroundColor: UIColor.white,
		]
		
		let gRGB = CGColorSpace(name: CGColorSpace.genericRGBLinear)!
		let theCGColor = CGColor(colorSpace: gRGB, components: [0.96863, 0.80784, 0.27451, 1])!
		let theColor = UIColor(cgColor: theCGColor)

		let attsB: [NSAttributedString.Key : Any] = [
			.font: theFont,
			.foregroundColor: theColor,
		]
		
		let partOne = NSMutableAttributedString(string: "1234567890123 ", attributes: attsA)
		let partTwo = NSAttributedString(string: "String", attributes: attsB)
		
		partOne.append(partTwo)
		
		return partOne
	}

}

class WrapTestVC: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 4
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)

		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			stackView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			stackView.widthAnchor.constraint(equalToConstant: 320.0),
		])
		
		var noteLabel: UILabel!
		var testLabel: UILabel!
	
		let noteFont: UIFont = .systemFont(ofSize: 14.0)
		
		noteLabel = UILabel()
		noteLabel.font = noteFont
		noteLabel.numberOfLines = 0
		noteLabel.text = "Just enough to fit:"
	
		stackView.addArrangedSubview(noteLabel)
		
		testLabel = UILabel()
		testLabel.backgroundColor = .yellow
		testLabel.numberOfLines = 0
		testLabel.attributedText = sampleAttrString(method: 0)

		stackView.addArrangedSubview(testLabel)
		
		stackView.setCustomSpacing(20.0, after: testLabel)
		
		noteLabel = UILabel()
		noteLabel.font = noteFont
		noteLabel.numberOfLines = 0
		noteLabel.text = "Using a space char:"
		
		stackView.addArrangedSubview(noteLabel)
		
		testLabel = UILabel()
		testLabel.backgroundColor = .yellow
		testLabel.numberOfLines = 0
		testLabel.attributedText = sampleAttrString(method: 1)
		
		stackView.addArrangedSubview(testLabel)
		
		stackView.setCustomSpacing(20.0, after: testLabel)
		
		noteLabel = UILabel()
		noteLabel.font = noteFont
		noteLabel.numberOfLines = 0
		noteLabel.text = "Using a non-break-space char:"
		
		stackView.addArrangedSubview(noteLabel)
		
		testLabel = UILabel()
		testLabel.backgroundColor = .yellow
		testLabel.numberOfLines = 0
		testLabel.attributedText = sampleAttrString(method: 2)
		
		stackView.addArrangedSubview(testLabel)

		stackView.setCustomSpacing(20.0, after: testLabel)
		
		noteLabel = UILabel()
		noteLabel.font = noteFont
		noteLabel.numberOfLines = 0
		noteLabel.text = "Although, iOS 16 may give:"
		
		stackView.addArrangedSubview(noteLabel)
		
		testLabel = UILabel()
		testLabel.backgroundColor = .yellow
		testLabel.numberOfLines = 0
		testLabel.attributedText = sampleAttrString(method: 3)
		
		stackView.addArrangedSubview(testLabel)
		
		stackView.setCustomSpacing(20.0, after: testLabel)
		

	}

	func sampleAttrString(method: Int) -> NSMutableAttributedString {
		let fontA: UIFont = .systemFont(ofSize: 20.0, weight: .bold)
		
		let attsA: [NSAttributedString.Key : Any] = [
			.font: fontA,
			.foregroundColor: UIColor.blue,
		]
		
		let attsB: [NSAttributedString.Key : Any] = [
			.font: fontA,
			.foregroundColor: UIColor.red,
		]
		
		var partOne = NSMutableAttributedString(string: "If the label has enough text so it wraps to more than two lines, UIKit will allow a last word orphan.", attributes: attsA)
		
		var partTwo: NSAttributedString = NSAttributedString()
		
		switch method {
		case 0:
			()
		case 1:
			partTwo = NSAttributedString(string: " *", attributes: attsB)
		case 2:
			partTwo = NSAttributedString(string: "\u{a0}*", attributes: attsB)
		case 3:
			partOne = NSMutableAttributedString(string: "If the label has enough text so it wraps to more than two lines, UIKit will allow a last\nword orphan.", attributes: attsA)
			partTwo = NSAttributedString(string: "\u{a0}*", attributes: attsB)
		default:
			()
		}
		
		partOne.append(partTwo)
		
		return partOne
	}

}

class TransformImageView: UIImageView {
	let textLayer = CATextLayer()
	let shapeLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		
		shapeLayer.strokeColor = UIColor.yellow.cgColor
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineWidth = 8
		layer.addSublayer(shapeLayer)
		
		textLayer.string = "TEST"
		textLayer.foregroundColor = UIColor.red.cgColor
		let font: UIFont = .systemFont(ofSize: 40.0, weight: .bold)
		textLayer.font = font
		textLayer.alignmentMode = .center
		textLayer.contentsScale = UIScreen.main.scale
		layer.addSublayer(textLayer)
		
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let pth = UIBezierPath(ovalIn: bounds.insetBy(dx: bounds.width * 0.1, dy: bounds.height * 0.1))
		shapeLayer.path = pth.cgPath
		shapeLayer.frame = bounds
		
		guard let font = textLayer.font else { return }
		textLayer.frame = CGRect(x: bounds.minX, y: bounds.midY - (font.pointSize * 0.5), width: bounds.maxX, height: font.pointSize)
	}
	public func doTransform(_ idx: Int) {
		
		var tr: CATransform3D = CATransform3DIdentity
		
		// make sure everything is at identity
		self.layer.transform = tr
		self.layer.sublayerTransform = tr
		self.textLayer.transform = tr
		self.shapeLayer.transform = tr
		
		let v: CGFloat = 60.0
		
		switch idx {
		case 1:
			// transform entire view, including sublayers
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, -v * .pi / 180.0, 1.0, 0.0, 0.0)
			self.layer.transform = tr
		case 2:
			// transform only sublayers
			tr = CATransform3DIdentity
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, -v * .pi / 180.0, 1.0, 0.0, 0.0)
			self.layer.sublayerTransform = tr
		case 3:
			// transform layer with one transform
			//	only sublayers with another transform
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, v * .pi / 180.0, 1.0, 0.0, 0.0)
			self.layer.transform = tr
			tr = CATransform3DIdentity
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, v * .pi / 180.0, 0.0, 1.0, 0.0)
			self.layer.sublayerTransform = tr
		case 4:
			// transform each sublayer individually
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, v * .pi / 180.0, 0.0, 0.0, 1.0)
			self.textLayer.transform = tr
			tr = CATransform3DIdentity
			tr.m34 = 1.0 / 200.0
			tr = CATransform3DRotate(tr, v * .pi / 180.0, 0.0, 1.0, 0.0)
			self.shapeLayer.transform = tr
		default:
			// no transforms
			break
		}
		

	}
}
class UserDefsVC: UIViewController {
	
	let strs: [String] = [
		".layer.transform",
		".layer.sublayerTransform",
		"Different transform for .layer and .sublayerTransform",
		"no .layer transform, different transforms for each sublayer",
	]
	let infoLabel: UILabel = {
		let v = UILabel()
		v.font = .systemFont(ofSize: 12.0, weight: .light)
		v.textAlignment = .center
		v.numberOfLines = 0
		return v
	}()
	
	var imgView: TransformImageView!
	
	var idx: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let img = UIImage(named: "test") else {
			fatalError("Could not load image!")
		}
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false

		let seg = UISegmentedControl(items: ["1", "2", "3", "4"])
		seg.addTarget(self, action: #selector(segChanged(_:)), for: .valueChanged)
		
		stackView.addArrangedSubview(seg)
		
		let v = UILabel()
		v.font = .systemFont(ofSize: 12.0, weight: .light)
		v.textAlignment = .center
		v.text = "Original - no Transforms"
		stackView.addArrangedSubview(v)
		
		let defImgView = TransformImageView(frame: .zero)
		defImgView.image = img
		defImgView.heightAnchor.constraint(equalTo: defImgView.widthAnchor, multiplier: 2.0 / 3.0).isActive = true
		stackView.addArrangedSubview(defImgView)

		stackView.setCustomSpacing(40.0, after: defImgView)
		
		stackView.addArrangedSubview(infoLabel)
		
		imgView = TransformImageView(frame: .zero)
		imgView.image = img
		imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor, multiplier: 2.0 / 3.0).isActive = true
		stackView.addArrangedSubview(imgView)

		view.addSubview(stackView)
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 8.0),
			stackView.widthAnchor.constraint(equalToConstant: 240.0),
			stackView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
		])
		
		seg.selectedSegmentIndex = 0
		segChanged(seg)
	}
	
	@objc func segChanged(_ sender: UISegmentedControl) {
		let idx = sender.selectedSegmentIndex
		imgView.doTransform(idx + 1)
		infoLabel.text = strs[idx]
	}
	
}

class MultiChildViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let origString: String = "This is your test of looping replacement"

		// characters to replace
		let origChars: [String] = ["a", "e", "i", "o", "u"]
		
		// replace with these characters
		let replChars: [[String]] = [
			["á", "é", "í", "ó", "ú"],
			["ǎ", "ě", "ǐ", "ǒ", "ǔ"],
			["à", "è", "ì", "ò", "ù"],
			
			// add more sets
			["1", "2", "3", "4", "5"],
			["ⓐ", "ⓔ", "ⓘ", "ⓞ", "ⓤ"],
		]
		
		// mutable array of copies of the original string
		var resultStrings: [String] = Array(repeating: origString, count: replChars.count)
		
		// for each copy
		for i in 0..<resultStrings.count {
			// for each orig char
			for (oChar, rChar) in zip(origChars, replChars[i]) {
				// replace with replacement car
				resultStrings[i] = resultStrings[i].replacingOccurrences(of: oChar, with: rChar)
			}
		}
		
		// print the original string
		print(origString)
		
		// print the resulting replacement strings
		resultStrings.forEach {
			print($0)
		}

		print()
		print()

/*
		let replChars: [[String]] = [
			["á", "ǎ", "à"],
			["é", "ě", "è"],
			["í", "ǐ", "ì"],
			["ó", "ǒ", "ò"],
			["ú", "ǔ", "ù"],
		]
		
		var newA: [[String]] = []
		for i in 0..<3 {
			var a: [String] = []
			var s: String = ""
			for j in 0..<5 {
				a.append(replChars[j][i])
				s += "\"" + replChars[j][i] + "\","
			}
			print(s)
			newA.append(a)
		}

		// we want an array of strings
		//	each replacing "aeiou" with replacement variations
		var replacedStrings: [String] = Array(repeating: origString, count: replChars[0].count)
		
		for (oChar, rChars) in zip(origChars, replChars) {
			for n in 0..<rChars.count {
				replacedStrings[n] = replacedStrings[n].replacingOccurrences(of: oChar, with: rChars[n])
			}
		}
		
		
//		for (o, r) in zip(orig, repl) {
//			for i in 0..<r.count {
//				replacedArray[i] = replacedArray[i].replacingOccurrences(of: o, with: r[i])
//			}
//		}
		replacedStrings.forEach {
			print($0)
		}

//		var resultStr = str.replacingOccurrences(of: "a", with: "á")
//		resultStr = resultStr.replacingOccurrences(of: "e", with: "é")
//		resultStr = resultStr.replacingOccurrences(of: "o", with: "ó")
//		print(resultStr)
		
*/
		
		let seg = UISegmentedControl(items: ["First", "Second", "Third"])
		seg.addTarget(self, action: #selector(segChanged(_:)), for: .valueChanged)
		seg.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(seg)
		
		// respect safe area
		let safeG = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			seg.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 20.0),
			seg.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 20.0),
			seg.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -20.0),
		])

		// instantiate 3 view controllers
		let firstVC = FirstVC()
		let secondVC = SecondVC()
		let thirdVC = ThirdVC()

		// for each view controller
		[firstVC, secondVC, thirdVC].forEach { vc in
			// add it as a child
			self.addChild(vc)
			// add its view
			view.addSubview(vc.view)
			// layout its view
			vc.view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				// constrain top to segmented control bottom plus 20-points
				vc.view.topAnchor.constraint(equalTo: seg.bottomAnchor, constant: 20.0),
				// we'll constrain leading/trailing/bottom to the safe area
				//	with 20-points "padding"
				vc.view.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 20.0),
				vc.view.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: -20.0),
				vc.view.bottomAnchor.constraint(equalTo: safeG.bottomAnchor, constant: -20.0),
			])
			// start with all child controller views hidden
			vc.view.isHidden = true
			// finish the add child process
			vc.didMove(toParent: self)
		}
		
		// set the segmented control's selected segment to Zero
		seg.selectedSegmentIndex = 0
		
		// show first child controller view
		self.children.first?.view.isHidden = false

	}
	
	@objc func segChanged(_ sender: UISegmentedControl) {
		let idx = sender.selectedSegmentIndex
		for (i, vc) in self.children.enumerated() {
			vc.view.isHidden = i != idx
		}
	}

}

class FirstVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemRed
		
		let v = UILabel()
		v.textAlignment = .center
		v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		v.text = "First VC"
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
			v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
			v.heightAnchor.constraint(equalToConstant: 100.0),
			v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
}

class SecondVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemGreen
		
		let v = UILabel()
		v.textAlignment = .center
		v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		v.text = "Second VC"
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
			v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
			v.heightAnchor.constraint(equalToConstant: 100.0),
			v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
}

class ThirdVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBlue
		
		let v = UILabel()
		v.textAlignment = .center
		v.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
		v.text = "Third VC"
		v.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(v)
		
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
			v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
			v.heightAnchor.constraint(equalToConstant: 100.0),
			v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
}


class SimpleListVCModel {
	var dataSource: UICollectionViewDiffableDataSource<Section, String>! = nil
	var items = Array(0..<10).map{"This is item \($0)"}
	
	enum Section: String {
		case main
	}
	
	func configureDataSource(using collectionView: UICollectionView) {
		let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
			var content = cell.defaultContentConfiguration()
			content.text = "\(item)"
			cell.contentConfiguration = content
		}
		
		dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
			
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
	}
	
	func applySnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
		snapshot.appendSections([.main])
		snapshot.appendItems(items)
		
		dataSource.apply(snapshot, animatingDifferences: false)
	}
}

/*
class SimListViewController: SimpleListViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "List"
		view.backgroundColor = .red
		configureHierarchy()
		model.configureDataSource(using: collectionView)
		model.applySnapshot()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Here")
	}
}
class SimpleListViewController: UIViewController, UICollectionViewDelegate {
	var collectionView: UICollectionView! = nil
	let model = SimpleListVCModel()
	
	func configureHierarchy() {
		let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.delegate = self
		view.addSubview(collectionView)
	}
}
*/

class ViewControllerViewModel: SimpleListVCModel {
	func foo(){
		print("Foo")
	}
}

class SimpleListViewController<M: SimpleListVCModel>: UIViewController, UICollectionViewDelegate {
	let model: M
	var collectionView: UICollectionView! = nil
	
	
	//MARK: - Initializer
	init(model: M) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	//MARK: - Views
	func configureHierarchy() {
		let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.delegate = self
		view.addSubview(collectionView)
	}
	
//	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		print("Selected item: \(indexPath) in SimpleListViewController")
//		// do something common
//	}

}

class SimListViewController: SimpleListViewController<ViewControllerViewModel> {
	override init(model: ViewControllerViewModel = ViewControllerViewModel()) {
		super.init(model: model)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "List"
		view.backgroundColor = .red
		configureHierarchy()
		model.configureDataSource(using: collectionView)
		model.applySnapshot()
		model.foo()
	}
	
	@objc (collectionView:didSelectItemAtIndexPath:)

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		//super.collectionView(collectionView, didSelectItemAt: indexPath)
		print("Selected item: \(indexPath) in ViewController")
	}

}

class LauncherVC: UIViewController {
	
	@IBAction func tapp(_ sender: Any) {
		let vc = SimListViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
}

