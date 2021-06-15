//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
	let juicemaker = JuiceMaker()
	
	var strawberryStore: Int { return juicemaker.fruitStores.filter{ $0.name == .strawberry}.first?.stock ?? 0
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.strawberry.text = "\(strawberryStore)"
		}
	
	
	
	@IBAction func strawberryJuiceOrder(_ sender: UIButton) {
		
	
	}
	
	@IBOutlet weak var strawberry: UILabel!
	
	@IBOutlet weak var banana: UILabel!
	
	
	
}

