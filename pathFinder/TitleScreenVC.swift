//
//  TitleScreenVC.swift
//  pathFinder
//
//  Created by AW on 23/09/2016.
//  Copyright © 2016 Allan Wallace. All rights reserved.
//

import UIKit

class TitleScreenVC: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bottomBar: UIView!
    
    @IBOutlet weak var titleImg: UIImageView!
    var colourScheme = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        startBtn.layer.cornerRadius = 6.0
        startBtn.layer.shadowRadius = 6.0
        startBtn.layer.shadowOpacity = 0.8
        startBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
       
        let colourSchemeChoice = UserDefaults.standard
        
        if colourSchemeChoice.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            colourScheme = colourSchemeChoice.string(forKey: "chosenColourScheme")!
        }
        
        if colourScheme == "pink" {
            startBtn.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            titleView.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            bottomBar.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            titleImg.image = UIImage(named: "BRtitlepink")
            
        } else if colourScheme == "blue" {
            startBtn.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            titleView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            bottomBar.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            titleImg.image = UIImage(named: "BRtitle")

        } else if colourScheme == "random" {
            bottomBar.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            titleView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            startBtn.backgroundColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
             titleImg.image = UIImage(named: "BRtitlerandom")
            
    }
    }
}
