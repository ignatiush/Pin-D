//
//  EventListViewController.swift
//  Test1
//
//  Created by Ignatius Ian on 24/3/15.
//  Copyright (c) 2015 Ignatius Ian. All rights reserved.
//

import Foundation
import UIKit

class EventListViewController : UITableViewController {

    let eventsManager = EventsManager()
    var address:String?
    var latD:CLLocationDegrees?
    var lonD:CLLocationDegrees?
    var coords:CLLocationCoordinate2D?
    var name:String?
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
        if segue.identifier == "DoneEvent"{
            let addEventController = segue.sourceViewController as AddEventViewController
            if let newEvent = addEventController.newEvent {
                eventsManager.createdEvents += [newEvent]
                eventsManager.save()
                let indexPath = NSIndexPath(forRow: eventsManager.createdEvents.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath],
                    withRowAnimation: .Automatic)
            }
        }
        
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            
            return eventsManager.createdEvents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let eventCell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
        let event = eventsManager.createdEvents[indexPath.row]
        eventCell.textLabel?.text =  event.name
        
        return eventCell

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectedEvent"{
            let cellIndex = tableView.indexPathForSelectedRow();
            let tempIndex = cellIndex?.row
            name = eventsManager.createdEvents[tempIndex!].name
            address = eventsManager.createdEvents[tempIndex!].address
            latD = eventsManager.createdEvents[tempIndex!].eventLat
            lonD = eventsManager.createdEvents[tempIndex!].eventLon
            coords = CLLocationCoordinate2DMake(40.0992, -88.2358) // coordinates hard-coded for now.
            
            var destMapController = segue.destinationViewController as? MapViewController
            if let destMapController = destMapController {
                destMapController.showOnMap(segue)
                println("worked")
            }
        }
        println("segue fired")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        navigationItem.title = "Events"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
