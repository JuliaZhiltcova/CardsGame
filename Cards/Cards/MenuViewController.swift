//
//  MenuViewController.swift
//  Cards
//
//  Created by Admin on 20/02/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
   // @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBAction func backToGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
//        if visualEffectView.alpha == 1.0 {
//            UIView.animate (withDuration: 3.0,
//                            delay: 2.0,
//                            options: [ .curveLinear],
//                            animations: { self.visualEffectView.alpha = 0.0 } ,
//                            completion:  nil   )
//        
//        }
        
 

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
