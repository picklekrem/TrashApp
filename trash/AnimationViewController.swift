//
//  AnimationViewController.swift
//  trash
//
//  Created by Ekrem Özkaraca on 13.12.2020.
//

import UIKit
import Lottie


class AnimationViewController: UIViewController {

    let animationView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private func setupAnimation () {
        animationView.animation = Animation.named("trash")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 450)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
//        animationView.loopMode = .loop
        animationView.play(){ (finished) in
            self.performSegue(withIdentifier: "passVC", sender: nil)
            }
        view.addSubview(animationView)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
