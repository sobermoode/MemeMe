//
//  SavedMemesTableViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/31/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate
{
    // set the re-use identifier for the table view cells
    let reuseIdentifier = "MemeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func numberOfSectionsInTableView( tableView: UITableView ) -> Int
    {
        return 1
    }

    override func tableView( tableView: UITableView, numberOfRowsInSection section: Int ) -> Int
    {
        // access Meme model data and return the total number of saved Memes
        return Meme.allMemes.count
    }
    
    override func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath ) -> UITableViewCell
    {
        // dequeue a cell for a Meme
        var cell = tableView.dequeueReusableCellWithIdentifier( reuseIdentifier, forIndexPath: indexPath ) as SavedMemeTableViewCell
        
        // set the cell's properties with the Meme data
        cell.topTextLabel?.text = Meme.allMemes[ indexPath.item ].topText
        cell.bottomTextLabel?.text = Meme.allMemes[ indexPath.item ].bottomText
        cell.memeImageView?.image = Meme.allMemes[ indexPath.item ].memedImage
        
        return cell
    }
    
    // set a height for the table view rows
    override func tableView( tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)  -> CGFloat
    {
        return 150.0
    }
    
    // segue to detail view when user selects a Meme in the table
    override func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath )
    {
        // Apple recommends deselecting the row before the segue
        tableView.deselectRowAtIndexPath( indexPath, animated: false )
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue( segue: UIStoryboardSegue, sender: AnyObject? )
    {
        // check the which segue we are making
        if( segue.identifier == "detailFromTableView" )
        {
            // get a reference to the detail view
            var memeDetailViewController = segue.destinationViewController as MemeDetailViewController
            
            // to find the correct image to set on the detail view, we need to get
            // the indexPath of the cell, then use that to access the Meme's
            // allMemes[] model data.
            let path = self.tableView.indexPathForSelectedRow()?
            let imageIndex = path?.row
            let memeImage = Meme.allMemes[ imageIndex! ].memedImage
            
            // set the image on the detail view
            memeDetailViewController.memedImage = memeImage
        }
    }
}
