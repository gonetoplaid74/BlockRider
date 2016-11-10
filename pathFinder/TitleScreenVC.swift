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
    var mainColor = UIColor()
    
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
            mainColor = PINK_COLOR
            updateColor()
            titleImg.image = UIImage(named: "BRtitlepink")
            
        } else if colourScheme == "blue" {
            mainColor = BLUE_COLOR
            updateColor()
            titleImg.image = UIImage(named: "BRtitle")

        } else if colourScheme == "random" {
            mainColor = RANDOM_COLOR
            updateColor()
            titleImg.image = UIImage(named: "BRtitlerandom")
            
    }
    }
    func updateColor() {
        startBtn.backgroundColor = mainColor
        titleView.backgroundColor = mainColor
        bottomBar.backgroundColor = mainColor

    }
}
