//
//  ApiWrapper.swift
//  NBANow
//
//  Created by Yash Kothari on 2015-01-31.
//  Copyright (c) 2015 3O1. All rights reserved.
//

import Foundation

class ApiWrapper {
    let API_KEY = "yayhu3b9nqghx2zcqmtw2sn6"
    let teamData:TeamData = TeamData.sharedInstance
    var timer: NSTimer?

//From: http://code.martinrue.com/posts/the-singleton-pattern-in-swift
//To create singleton
/////////////////////////////////////////////
    class var sharedInstance: ApiWrapper {
        struct Static {
            static var instance: ApiWrapper?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ApiWrapper()
        }
        
        return Static.instance!
    }
/////////////////////////////////////////////
    
    init() {}
    
    private func getDateComponents(date:NSDate) -> NSDateComponents {
        //let todayDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        
        return components
    }
    
    func getNextGame(dayOffset:Int = 0) {
        let date = NSDate().dateByAddingTimeInterval(NSTimeInterval(60 * 60 * 24 * dayOffset))
        let url = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/\(getDateComponents(date!).year)/\(getDateComponents(date!).month)/\(getDateComponents(date!).day)/schedule.json?api_key=\(API_KEY)")

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            self.teamData.parseGetGameData(data)
            
            if self.teamData.isGameOngoing! {
                self.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("getGameClockQuarterScore"), userInfo: nil, repeats: true)
                self.timer?.fire()
            }
            else {
                var index = 0
                while !(self.teamData.homeTeamName == "Toronto Raptors" || self.teamData.awayTeamName == "Toronto Raptors") {
                    index++
                    self.getNextGame(dayOffset: index)
                }
            }
        }
        task.resume()
    }

    func getGameClockQuarterScore(currentGameId: String) {
        if !self.teamData.isGameOngoing! {
            self.timer?.invalidate()
        }
        else {
            let baseUrl = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/\(currentGameId)/boxscore.json?api_key=\(API_KEY)")
            let task = NSURLSession.sharedSession().dataTaskWithURL(baseUrl!) {(data, response, error) in
                self.teamData.parseGetGameClockQuarterScore(data)
            }
            task.resume()
        }
    }
}