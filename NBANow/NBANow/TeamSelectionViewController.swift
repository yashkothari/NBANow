//
//  ViewController.swift
//  NBANow
//
//  Created by Yash Kothari on 2015-01-31.
//  Copyright (c) 2015 3O1. All rights reserved.
//
import Foundation
import UIKit

class TeamSelectionViewController: UITableViewController {
    
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    var nbaTeams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nbaTeams = [Team(teamName: "Atlanta Hawks"),
            Team(teamName: "Boston Celtics"),
            Team(teamName: "Brooklyn Nets"),
            Team(teamName: "Charlotte Hornets"),
            Team(teamName: "Chicago Bulls"),
            Team(teamName: "Cleveland Cavaliers"),
            Team(teamName: "Dallas Mavericks"),
            Team(teamName: "Denver Nuggets"),
            Team(teamName: "Detroit Pistons"),
            Team(teamName: "Golden State Warriors"),
            Team(teamName: "Houston Rockets"),
            Team(teamName: "Indiana Pacers"),
            Team(teamName: "LA Clippers"),
            Team(teamName: "LA Lakers"),
            Team(teamName: "Memphis Grizzlies"),
            Team(teamName: "Miami Heat"),
            Team(teamName: "Milwaukee Bucks"),
            Team(teamName: "Minnesota Timberwolves"),
            Team(teamName: "New Orleans Pelicans"),
            Team(teamName: "New York Knicks"),
            Team(teamName: "Oklahoma City Thunder"),
            Team(teamName: "Orlando Magic"),
            Team(teamName: "Philadelphia Sixers"),
            Team(teamName: "Phoenix Suns"),
            Team(teamName: "Portland Trail Blazers"),
            Team(teamName: "Sacramento Kings"),
            Team(teamName: "San Antonio Spurs"),
            Team(teamName: "Toronto Raptors"),
            Team(teamName: "Utah Jazz"),
            Team(teamName: "Washington Wizards") ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tells the tableView that it should contain as many rows as there are items in the candies array you populated earlier.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.nbaTeams.count
    }
    
    //creates our cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell //"Cell" is the identifier
        
        var team : Team
        
        team = nbaTeams[indexPath.row]
        
        cell.textLabel!.text = team.teamName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark;
        self.doneBarButtonItem.enabled = true;
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None;
    }
}