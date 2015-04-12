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
    
    let api = ApiWrapper.sharedInstance
    let game = TeamData.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var dayOffset = 0
        //do {
            api.getNextGame(dayOffset: dayOffset, completion: {
                if let isGameOngoing = self.game.isGameOngoing {
                    if isGameOngoing {
                        self.futureGameContainerView.hidden = true
                        self.ongoingGameContainerView.hidden = false
                        
                        self.homeTeamNameLabel.text = self.game.homeTeamName!
                        self.awayTeamNameLabel.text = self.game.awayTeamName!
                        
                        
                        let timer = NSTimer(self.updateGameClockQuarterScore());
                    }
                    else {
                        dayOffset++
                        self.ongoingGameContainerView.hidden = true
                        self.futureGameContainerView.hidden = false
                        self.opponentTeamNameLabel.text = self.game.homeTeamName! //TODO: change to get the team name that is not in NSUserDefaults
                        if let d = self.game.dateScheduled {
                        //let d = self.game.dateScheduled!
                            self.timeToGameLabel.text = "\(d)"
                        }
                        println(self.opponentTeamNameLabel.text)
                    }
                }
                else {
                    //TODO: Display error here
                }
            })
        //} while !(game.isGameOngoing != nil)
        
    }
    
    func updateGameClockQuarterScore() {
        self.api.getGameClockQuarterScore(self.game.gameId!, completion: {
            //self.homeTeamScoreLabel.text = "\(self.game.homeTeamScore!)"
            self.awayTeamScoreLabel.text = "\(self.game.awayTeamScore!)"
            //self.gameClockAndQuarterLabel.text = "\(self.game.gameClock!)"// + "\(self.game.quarter?)"
        })
    }
}