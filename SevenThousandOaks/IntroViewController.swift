//
//  IntroViewController.swift
//  7000Oaks
//
//  Created by Richard Willis on 15/05/2018.
//  Copyright © 2018 Rich Text Format Ltd. All rights reserved.
//

import Filzanzug
import UIKit

class IntroViewController: FZViewController {
	@IBOutlet weak var image: UIImageView!
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		signalBox.signals?.transmitSignal( by: FZSignalConsts.navigateTo, with: Consts.gameVC )
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
