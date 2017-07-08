//
//  ViewController.swift
//  PropertyAnimatorBug
//
//  Created by Klaas on 07.07.17.
//  Copyright © 2017 Park Bench. All rights reserved.
//

import UIKit

// Without using one of the two workarounds the completion block will not be called
// Use EITHER of the workarounds and the animation happens and the completion block gets called
//
// The header documentation for pauseAnimation() states:
// "Pauses an active, running animation, or start the animation as paused."
//

private let flag_useWorkaround1 = false
private let flag_useWorkaround2 = false

class ViewController: UIViewController {
	
	var myView = UIView(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		myView.backgroundColor = .red
		
		view.addSubview(myView)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let pa = UIViewPropertyAnimator(duration: 5, dampingRatio: 1) {
			self.myView.frame.origin.x = 200
		}
		
		pa.addCompletion { (pos) in
			print("Completion block executed.")
		}
		
		if flag_useWorkaround1 {
			pa.startAnimation()
		}
		
		pa.pauseAnimation()
		
		if flag_useWorkaround2 {
			DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
				pa.continueAnimation(withTimingParameters: nil, durationFactor: 0.3)
			}
		} else {
			pa.continueAnimation(withTimingParameters: nil, durationFactor: 0.3)
		}
	}
}

