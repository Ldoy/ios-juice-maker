//
//  JuiceMaker - ViewController.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let juiceMaker = JuiceMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var stockAlert: UIAlertController {
        let title = "경고"
        let alert = UIAlertController(title: title, message: "재고가 부족합니다", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("네", comment: "Default action"),
                style: .default,
                handler: nil // GO TO NEXT SCENE
            ))
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("아니오", comment: "Destructive action"),
                style: .destructive,
                handler: nil
            ))
        
        return alert
    }
    
    var confirmAlert: UIAlertController {
        let title = "확인"
        let alert = UIAlertController(title: title, message: "만들어졌습니다", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("확인", comment: "Default action"),
                style: .default,
                handler: nil // GO TO NEXT SCENE
            ))
        return alert
    }
    
    func showLackOfStockAlert(title: String){
        self.present(stockAlert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(title: String){
        confirmAlert.message = "\(title)이 만들어졌습니다"
        self.present(confirmAlert, animated: true, completion: nil)
    }
    
    @IBAction func clickButtons(_ item: UIButton!){
        let initialText: String! = item.titleLabel?.text
        
        guard let endIndex = initialText?.index(initialText.endIndex, offsetBy: -4) else {
            return
        }
        
        let text = String(initialText[initialText.startIndex...endIndex])
        let initialType = JuiceMenu(rawValue: text)
        
        guard let type:JuiceMenu = initialType else {
            return
        }
        
        do {
            try juiceMaker.orderJuice(menu: type)
            showConfirmAlert(title: text)
        } catch {
            showLackOfStockAlert(title: text)
        }
    }
}

