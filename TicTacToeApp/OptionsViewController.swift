//
//  OptionsViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class OptionsViewController: ViewController {
    
    let seagueToGameVC = "seagueToGameVC"

   
    @IBOutlet weak var selectGridOptBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func optionBtnClick(_ sender: UIButton) {
        
        performSegue(withIdentifier: seagueToGameVC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == seagueToGameVC {
            
            let destinationVC = segue.destination as? GameViewController
         }
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
