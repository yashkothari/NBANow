//
//  ApiWrapper.swift
//  NBANow
//
//  Created by Yash Kothari on 2015-01-31.
//  Copyright (c) 2015 3O1. All rights reserved.
//

import Foundation

class ApiWrapper {
    static let sharedInstance = ApiWrapper()

    let API_KEY = "yayhu3b9nqghx2zcqmtw2sn6" //TODO: move this into a Constants file
    let teamData = TeamData.sharedInstance
    
    init() {}
    
    private func getDateComponents(date:NSDate) -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        
        return components
    }
    
    func getNextGame(dayOffset:Int = 0, completion: () -> ()) {
        let date = NSDate().dateByAddingTimeInterval(NSTimeInterval(60 * 60 * 24 * dayOffset))
        let url = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/2015/3/15/schedule.json?api_key=\(API_KEY)")
        //\(getDateComponents(date).year)/\(getDateComponents(date).month)/\(getDateComponents(date).day)/schedule.json?api_key=\(API_KEY)")

        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if(error != nil || data == nil) {
                println(error) //TODO: return error to user
                return;
            }
            
            self.teamData.parseGetGameData(data)
            completion()
        }
        task.resume()
    }

    func getGameClockQuarterScore(currentGameId: String) {
        if !self.teamData.isGameOngoing! {
//            self.timer?.invalidate()
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