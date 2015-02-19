//
//  DataModel.swift
//  NBANow
//
//  Created by Kartheek Gajjala on 2015-01-31.
//  Copyright (c) 2015 3O1. All rights reserved.
//

import Foundation
import UIKit

class TeamData {
    
    //From: http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    //To create singleton
    /////////////////////////////////////////////
    class var sharedInstance: TeamData {
        struct Static {
            static var instance: TeamData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = TeamData()
        }
        
        return Static.instance!
    }
    /////////////////////////////////////////////
    
    let api = ApiWrapper.sharedInstance
    var isGameToday: Bool
    var currentGameId: String?
    var homeTeamName: String?
    var homeTeamImage: UIImage?
    var homeTeamScore: Int?
    var awayTeamName: String?
    var awayTeamImage: UIImage?
    var awayTeamScore: Int?
    var gameClock: NSDate?

    var data:NSData!
    
    func MakeRequest(){
        api.getNextGame(dayOffset:0)
        //api.updateSchedule()
        //api.getGameClockAndQuarter(<#currentGameId: String#>)
        //self.parseJson(self.data)
    }
    
    init() {
        self.isGameToday = false
    }
    
    func updateScoreAndClock() -> (homeTeamScore: Int, awayTeamScore: Int, gameClock: NSDate) {
        //TODO: call api.getNextGame() and parse to update below properties
        return (self.homeTeamScore!, self.awayTeamScore!, self.gameClock!);
    }

    func getNextGame(data: NSData) {
        
        //SwiftyJSON converts this data into a JSON object using NSJSONSerialization
        // println(data)
        let json = JSON(data:data)
        println(json)
        if let description = json["games"][0]["scheduled"].string {
           // self.Time = description
           // println("\(description)")
        }
        
        //TODO: refactor the following plz :'(
        for i in 0 ..< json["games"].count {
            if let awayTeam = json["games"][i]["away"]["name"].string {
                //self.isGameToday = true
                self.awayTeamName = awayTeam
                //self.awayTeamImage = UIImage(named: self.awayTeamName!) //TODO: check this
                //gameIndex = i
                //break;
            }
            if let homeTeam = json["games"][i]["home"]["name"].string {
                self.homeTeamName = homeTeam
                //self.homeTeamImage = UIImage(named: self.homeTeamName!) //TODO: check this
                //gameIndex = i
                //break;
            }
        
            if self.awayTeamName == "Toronto Raptors" || self.homeTeamName == "Toronto Raptors" { //TODO: change to userdefaults, hardcoded for now
                self.isGameToday = true
                self.currentGameId = json["games"][i]["id"].string
//                self.homeTeamImage = UIImage(named: self.homeTeamName!)
//                self.awayTeamImage = UIImage(named: self.awayTeamName!)
            }
            else {
                self.isGameToday = false
                var index = 0
                while self.homeTeamName != "Toronto Raptors" || self.awayTeamName != "Toronto Raptors" {
                    index++
                    
                    api.getNextGame(dayOffset: index)
                }
                self.isGameToday = true
            }
                let Date1 = json["games"][i]["scheduled"]
                //println(Date)
                var splitstring: String = Date1.string!
            
               // var splittingthestring = splitstring.componentsSeparatedByString(":")
                let result = split(splitstring as String, { $0 == "T" }, maxSplit: 1, allowEmptySlices: true)
                let a = result[0]
                let b = result[1]
                var c = a + " " + b
                
                println(c)
                
                isGameToday = true
                let GameId = json["games"][i]["id"].stringValue
                //println(GameId)
                  currentGameId = GameId
                println(GameId)
                
                }
                if isGameToday != true {
                    isGameToday = false
                }
        }
    }
