//
//  WelcomeScreen_1.swift
//  trash
//
//  Created by Ekrem Özkaraca on 30.10.2020.
//

import UIKit

class WelcomeScreen_1: UIViewController {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var text2label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        headlineLabel.font = UIFont(name: "Blacklisted", size: 75)
      
        textLabel.text = "Biz burada ne yapiyoruz?"
        
    }
}
class WelcomeScreen_2: UIViewController{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
