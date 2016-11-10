//
//  SettingsVC.swift
//  pathFinder
//
//  Created by AW on 23/09/2016.
//  Copyright © 2016 Allan Wallace. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingsVC: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var soundFXLbl: UILabel!
    
    @IBOutlet weak var diffLbl: UILabel!
    @IBOutlet weak var colourLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var colourChoose: UISegmentedControl!
    @IBOutlet weak var diffChoose: UISegmentedControl!
    
    @IBOutlet weak var kidsBtn: UISwitch!
    @IBOutlet weak var kidsLbl: UILabel!
    @IBOutlet weak var holdLbl: UILabel!
    @IBOutlet weak var soundOff: UISwitch!
    @IBOutlet weak var bottomBar: UIView!
    
    var kidsModeOn = "off"
    var speed = String()
    var personSpeed = Int()
    var colour = String()
    var colourScheme = String()
    var ad = GADBannerView()
    var mainColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let colourSchemeChoice = UserDefaults.standard
        let diffChosen = UserDefaults.standard
        let kidsMode = UserDefaults.standard
        
        if kidsMode.string(forKey: "kidsMode") == nil {
            kidsBtn.isOn = false
        } else {
        
        kidsModeOn = kidsMode.object(forKey: "kidsMode") as! String
        }
        if kidsModeOn == "on" {
            kidsBtn.isOn = true
        } else {
            kidsBtn.isOn = false
        }
        
        if diffChosen.string(forKey: "startingSpeed") == nil {
            speed = "Slow"
            
        } else {
            speed = diffChosen.string(forKey: "startingSpeed")!
        }
      
        if speed == "Slow" {
            diffChoose.selectedSegmentIndex = 0
        } else if speed == "Hyper-Active" {
            diffChoose.selectedSegmentIndex = 1
        } else if speed == "Ludicrous" {
            diffChoose.selectedSegmentIndex = 2
        }
        
        if colourSchemeChoice.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            colourScheme = colourSchemeChoice.string(forKey: "chosenColourScheme")!
        }
        
        doneBtn.layer.cornerRadius = 6.0
        doneBtn.layer.shadowRadius = 6.0
        doneBtn.layer.shadowOpacity = 0.8
        doneBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)

        if colourScheme == "pink" {
            mainColor = PINK_COLOR
            colorChange()
            colourChoose.selectedSegmentIndex = 1
            
            
        } else if colourScheme == "blue" {
            mainColor = BLUE_COLOR
            colorChange()
            colourChoose.selectedSegmentIndex = 0
        
        }  else if colourScheme == "random" {
            
            let red = CGFloat((arc4random()%10)+2)/12
            let green = CGFloat((arc4random()%10)+2)/12
            let blue = CGFloat((arc4random()%10)+2)/12
            
            mainColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            RANDOM_COLOR = mainColor
            colorChange()
            colourChoose.selectedSegmentIndex = 2

        }
        
                
    }

    @IBAction func colourSelector(_ sender: AnyObject) {
        let storeColour = UserDefaults.standard
        
    
        
        
        if colourChoose.selectedSegmentIndex == 0 {
            colour = "blue"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 1 {
         colour = "pink"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 2 {
            colour = "random"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
            
        }
        
        colourScheme = colour
        
        
    viewDidLoad()
    
    
    
    }
    
    func colorChange() {
        topBar.backgroundColor = mainColor
        doneBtn.backgroundColor = mainColor
        titleLbl.textColor = mainColor
        diffLbl.textColor = mainColor
        colourLbl.textColor = mainColor
        soundFXLbl.textColor = mainColor
        colourChoose.tintColor = mainColor
        diffChoose.tintColor = mainColor
        holdLbl.textColor = mainColor
        soundOff.onTintColor = mainColor
        bottomBar.backgroundColor = mainColor
        kidsLbl.textColor = mainColor
        kidsBtn.onTintColor = mainColor
        kidsBtn.tintColor = mainColor
    }
    
    
    @IBAction func diffChooseBtn(_ sender: AnyObject) {
        
        let chosenDiff = UserDefaults.standard
        
        if diffChoose.selectedSegmentIndex == 0{
            speed = "Slow"
            
        } else if diffChoose.selectedSegmentIndex == 1 {
            speed = "Hyper-Active"
        } else if diffChoose.selectedSegmentIndex == 2 {
            speed = "Ludicrous"
        }
        
        chosenDiff.set(speed, forKey: "startingSpeed")
    }
    
  
    @IBAction func kidsModSlider(_ sender: AnyObject) {
        
        let kidsMode = UserDefaults.standard
        
        
        if kidsBtn.isOn == true {
            kidsModeOn = "on"
        } else {
            kidsModeOn = "off"
        }
        
        kidsMode.set(kidsModeOn, forKey: "kidsMode")
    
        
        
        
    }
    
    


}
