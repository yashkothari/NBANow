//
//  TeamStatusViewController.swift
//  NBANow
//
//  Created by Yash Kothari on 2015-02-14.
//  Copyright (c) 2015 3O1. All rights reserved.
//

import Foundation
import UIKit

class TeamStatusViewController : UIViewController {
    //Ongoing Game Views
    @IBOutlet var ongoingGameContainerView: UIView!
    //Home Team Views
    @IBOutlet var homeTeamNameLabel: UILabel!
    @IBOutlet var homeTeamLogoImageView: UIImageView!
    @IBOutlet var homeTeamScoreLabel: UILabel!
    //Away Team Views
    @IBOutlet var awayTeamNameLabel: UILabel!
    @IBOutlet var awayTeamLogoImageView: UIImageView!
    @IBOutlet var awayTeamScoreLabel: UILabel!
    
    @IBOutlet var gameClockAndQuarterLabel: UILabel!
    
    
    //Future Game Views
    @IBOutlet var futureGameContainerView: UIView!
    @IBOutlet var opponentTeamNameLabel: UILabel!
    @IBOutlet var opponentTeamLogoImageView: UIImageView!
    @IBOutlet var timeToGameLabel: UILabel!
    
    
    
    @IBAction func cancelTeamSelection(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveTeamSelection(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = ApiWrapper.sharedInstance
        api.getNextGame(completion: {(Bool) in
            self.homeTeamNameLabel.text = api.teamData.homeTeamName!
            self.homeTeamScoreLabel.text = "\(api.teamData.homeTeamScore)"
            println(self.homeTeamScoreLabel.text);
            
            
            self.awayTeamNameLabel.text = api.teamData.awayTeamName!
            self.awayTeamScoreLabel.text = "\(api.teamData.awayTeamScore)"
        })
        
    }
}