//
//  SavedMemesTableViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/31/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class SavedMemesTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    // var allMemes = [ Meme ]()
    
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return Meme.allMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier( reuseIdentifier, forIndexPath: indexPath ) as SavedMemeTableViewCell
        
        cell.topTextLabel?.text = Meme.allMemes[ indexPath.item ].topText
        cell.bottomTextLabel?.text = Meme.allMemes[ indexPath.item ].bottomText
        cell.memeImageView?.image = Meme.allMemes[ indexPath.item ].memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath )
    {
        println( "Selecting a row..." )
        
        tableView.deselectRowAtIndexPath( indexPath, animated: false )
        
        // performSegueWithIdentifier( "showMemeDetailViewController", sender: Meme.allMemes[ indexPath.item ].memedImage )
        // performSegueWithIdentifier( "showMemeDetailViewController", sender: self )
        
        // var memeDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier( "MemeDetailViewController" ) as MemeDetailViewController
        
//        var memeDetailViewController = MemeDetailViewController()
//        memeDetailViewController.imageNumber = indexPath.item
//        println( memeDetailViewController.imageNumber )
//
//        println( "The MemeDetailViewController ImageView is \(memeDetailViewController.memeImageView?)" )
//        
//        memeDetailViewController.memeImageView? = UIImageView( image: Meme.allMemes[ indexPath.item ].memedImage )
        
//        memeDetailViewController.memeImageView?.frame = CGRectMake( 0.0, 0.0, Meme.allMemes[ indexPath.item ].memedImage.size.width, Meme.allMemes[ indexPath.item ].memedImage.size.height )
//        memeDetailViewController.memeImageView?.image = Meme.allMemes[ indexPath.item ].memedImage
        
        // self.navigationController?.showViewController( memeDetailViewController, sender: indexPath.item )
        // self.navigationController?.performSegueWithIdentifier( "showMemeDetailViewController", sender: indexPath.item )
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println( "Preparing for segue..." )
        // println( "\(segue.identifier?)" )
        
        if( segue.identifier == "detailFromTableView" )
        {
            println( "Segue'ing from table view..." )
            var memeDetailViewController = segue.destinationViewController as MemeDetailViewController
            
            let path = self.tableView.indexPathForSelectedRow()?
            let imageIndex = path?.row
            let memeImage = Meme.allMemes[ imageIndex! ].memedImage
            
            memeDetailViewController.memedImage = memeImage
        }
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        // memeDetailViewController.imageNumber! = sender? as Int
        // segue.perform()
        // let item = tableView.indexPathForSelectedRow()!
        // memeDetailViewController.memeImageView?.image = sender as? UIImage
        
        
        // println( "prepareForSegue: memeImage is \(memeImage)" )
        // memeDetailViewController.memeImageView?.frame = CGRectMake( 0, 0, memeImage.size.width, memeImage.size.height )
        // memeDetailViewController.memeImageView?.image = memeImage
        
        // segue.perform()
        
//        if( segue.identifier == "showMemeDetailViewController" )
//        {
//            var memeDetailViewController = segue.destinationViewController as MemeDetailViewController
//            
//            memeDetailViewController.imageNumber = sender? as Int
//            
//            segue.perform()
//        }
    }

}
