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
    
    func getNextGame(#dayOffset:Int) {
        var teamData:TeamData = TeamData.sharedInstance
        var date = NSDate().dateByAddingTimeInterval(NSTimeInterval(60 * 60 * 24 * dayOffset))
        let Url = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/\(getDateComponents(date!).year)/\(getDateComponents(date!).month)/\(getDateComponents(date!).day)/schedule.json?api_key=\(API_KEY)")
        NSLog(Url!.absoluteString!)
        let task = NSURLSession.sharedSession().dataTaskWithURL(Url!) {(data, response, error) in
            println(NSString(data:data, encoding: NSUTF8StringEncoding))
            teamData.getNextGame(data)
        }
        task.resume()
        
//        if(teamData.isGameToday!) {
//            updateSchedule()
//        }
//        else {
//            getGameClockAndQuarter(teamData.currentGameId!)
//        }
    }
    
    private func getDateComponents(date:NSDate) -> NSDateComponents {
        //let todayDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        
        return components
    }
    
    func updateSchedule() { //TODO: don't update everytime
//        let baseUrl = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/\(getTodayDate().year - 1)/REG/schedule.json?api_key=\(API_KEY)")
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(baseUrl!) {(data, response, error) in
//            println(NSString(data: data, encoding: NSUTF8StringEncoding))
//        }
//        task.resume()
    }
    
    func getGameClockAndQuarter(currentGameId: String) {
        let baseUrl = NSURL(string: "http://api.sportsdatallc.org/nba-t3/games/\(currentGameId)/boxscore.json?api_key=\(API_KEY)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(baseUrl!) {(data, response, error) in
            println(NSString(data:data, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
}