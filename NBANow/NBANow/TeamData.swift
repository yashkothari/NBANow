//
//  TeamData.swift
//  NBANow
//
//  Created by Kartheek Gajjala on 2015-01-31.
//  Copyright (c) 2015 3O1. All rights reserved.
//

import Foundation
import UIKit

class TeamData {
    static let sharedInstance = TeamData()
    
    var isGameOngoing: Bool?
    var gameId: String?
    var gameClock: String?
    var quarter: Int?
    var dateScheduled: NSDate?
    
    var homeTeamName: String?
    var homeTeamImage: UIImage?
    var homeTeamScore: Int?
    
    var awayTeamName: String?
    var awayTeamImage: UIImage?
    var awayTeamScore: Int?
    
    init() {}
    
    func updateScoreAndClock() -> (homeTeamScore: Int, awayTeamScore: Int, gameClock: String) {
        //TODO: call api.getNextGame() and parse to update below properties
        return (self.homeTeamScore!, self.awayTeamScore!, self.gameClock!);
    }

    func parseGetGameData(data: NSData) {
        //SwiftyJSON converts this data into a JSON object using NSJSONSerialization
        let json = JSON(data:data)

        for i in 0 ..< json["games"].count {
            if let awayTeam = json["games"][i]["away"]["name"].string {
                self.awayTeamName = awayTeam
            }
            if let homeTeam = json["games"][i]["home"]["name"].string {
                self.homeTeamName = homeTeam
            }
            if self.awayTeamName == "Toronto Raptors" || self.homeTeamName == "Toronto Raptors" { //TODO: change to userdefaults, hardcoded for now
                self.gameId = json["games"][i]["id"].string
                let dateScheduledString = json["games"][i]["scheduled"].string
                //TODO: NSDateFormatter for this date^
                
                //self.homeTeamImage = UIImage(named: self.homeTeamName!)
                //self.awayTeamImage = UIImage(named: self.awayTeamName!)
                if json["games"][i]["status"].string == "inprogress" {
                    self.isGameOngoing = true
                }
                else {
                    self.isGameOngoing = true //TODO: change to false
                }
                break;
            }
        }
    }
    
    func parseGetGameClockQuarterScore(data: NSData) {
        let json = JSON(data: data)
        
        self.gameClock = json["clock"].string
        self.quarter = json["quarter"].intValue
        self.homeTeamScore = json["home"]["points"].intValue
        self.awayTeamScore = json["away"]["points"].intValue
        
        if json["status"].string == "inprogress" {
            self.isGameOngoing = false
        }
    }
}
