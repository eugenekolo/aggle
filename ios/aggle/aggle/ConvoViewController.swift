//
//  ConvoViewController.swift
//  aggle
//
//  This controller SHOULD be used to display all items currently listed by the user
//  As of 4/22/2016, this controller does nothing.
//
//  Created by Max Li on 3/22/16.
//  Copyright © 2016 Max Li. All rights reserved.
//

import UIKit

class ConvoViewController: UITableViewController {
    
    var convos = [Convo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Add the top bar w/ settings button */
        self.navigationItem.title = "Aggle"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: #selector(ConvoViewController.setBttnTouched(_:)))
        
        // Do any additional setup after loading the view.
        
        /* This is to test... too lazy to create a test class right now */
        testConvos()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convos.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "ConvoTableViewCell";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! ConvoTableViewCell
        
        let convo = convos[indexPath.row]
        
        cell.itemTitle.text = convo.item().title()
        cell.itemText.text = convo.item().desc()
        //cell.itemText = convo.item().pic() // TODO(eugenek): Need to actually have valid b64 data here, and it won't atm w/ the test
        
        return cell
    }
    
    func setBttnTouched(sender: UIBarButtonItem) {
        performSegueWithIdentifier("convoSettingsSegue", sender: self)
    }
    
    func loadConvos() {
        // TODO(eugenek): Pull convos for the user from firebase
    }
    
    /**
    * Used to just test/mock load convos */
    func testConvos() {
        // Create some testing items
        let item1 = Item(title: "Tardis",
                         description: "Great time travel machine",
                         itemzip: "90210",
                         owner: "The Doctor",
                         pic: "somepicdata",
                         price: "1234",
                         soldto: "")
        let item2 = Item(title: "DeLorean time machine",
                         description: "A more stylish time travel machine",
                         itemzip: "90210",
                         owner: "Doc",
                         pic: "somepicdata2",
                         price: "1234",
                         soldto: "")
        
        // Start some conversations about them
        let convo1 = Convo(messages: [], item: item1)
        let msg1 = Message(text: "Hello there", from: "Scott", to: "The Doctor")
        let msg2 = Message(text: "What do you want?", from: "The Doctor", to: "Scott")
        convo1.addMessage(msg1)
        convo1.addMessage(msg2)
        
        let msg3 = Message(text: "This is another message", from: "Timmy", to: "Doc")
        let convo2 = Convo(messages: [msg3], item: item2)
        
        self.convos = [convo1, convo2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
