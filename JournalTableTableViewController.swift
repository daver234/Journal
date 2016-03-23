//
//  JournalTableTableViewController.swift
//  Journal
//
//  Created by David Rothschild on 2/9/16.
//  Copyright © 2016 Dave Rothschild. All rights reserved.
//

import UIKit
import CoreData



class JournalTableTableViewController: UITableViewController {
    

    
    
    @IBAction func addJournal(sender: UIBarButtonItem) {
        // prepares an instance of an alert box
        var alert = UIAlertController(title: "New Journal", message: "Add a new Journal", preferredStyle: .Alert)
        // = "comment from-rainbow"
        
        // We want to add the new item below the bottom-most cell, so let's count how many journals there currently are as a reference to index
        let newRowIndex = self.journal.count
        // This is the code block that get's triggered when user clicks on the Save button within the Alert Box
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as! UITextField
            let entity = NSEntityDescription.entityForName("Journal", inManagedObjectContext: self.managedObjectContext)
            let newJournal = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedObjectContext)
            newJournal.setValue(textField.text, forKey: "title")
            var error: NSError?
            
            //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            //let managedContext = appDelegate.managedObjectContext
            if self.managedObjetContext!.save(&error) {
                print("Success!")
            } else {
                print("Error: \(error)")
            }
            //let's append the journal instance variable
            self.journal.append(newJournal)
            //to slide in the new journal instead of just popping on the screen without transition
            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
            let indexPaths = [indexPath]
            self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
        // This is the code block that get's triggered when user clicks on the Cancel button within the Alert Box
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction!) -> Void in
        }
        //code to register the text field to the alert box
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        //code to register the save button to the alert box
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        // code to register the alert box to the view controller
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var journalTableView: UITableView!
    var journal = [JournalJournal]()
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let journalRequest = NSFetchRequest(entityName: "Journal")
        
        do {
        
            let journalItems = try managedObjectContext.executeFetchRequest(journalRequest) as? [JournalJournal]
            journal = journalItems!
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journal.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...

        //return cell
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        let journalItem = journal[indexPath.row]
        cell.textLabel!.text = journalItem.valueForKey("title") as? String
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
