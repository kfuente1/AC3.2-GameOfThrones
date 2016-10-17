//
//  GameOfThronesTableViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jason Gresh on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GameOfThronesTableViewController: UITableViewController{
    
    var episodes = [GOTEpisode]()
    
    var selectedGOTEpisodes: GOTEpisode?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        guard let path = Bundle.main.path(forResource: "got", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
            let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary else {
                return
        }
        
        if let episodes = dict?.value(forKeyPath: "_embedded.episodes") as? [[String:Any]] {
            for epDict in episodes {
                if let ep = GOTEpisode(withDict: epDict) {
                    self.episodes.append(ep)
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return seasons()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfSeasons = section + 1
        let arrayOfSeason = episodes.filter {$0.season == numberOfSeasons}
        return arrayOfSeason.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GOT Episodes", for: indexPath)
        

        // Configure the cell...
        cell.textLabel?.text = "Episode name: \(self.episodes[indexPath.row].name)"
        cell.detailTextLabel?.text = "Air Date: \(self.episodes[indexPath.row].airdate)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGOTEpisodes = self.episodes[indexPath.row]
        
        performSegue(withIdentifier: "GOT Epidsode detail", sender: selectedGOTEpisodes)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season:\(section + 1)"
    }
    
    
    
    func seasons() -> Int {
        var lastSeason = 0
        for episode in episodes {
            if episode.season > lastSeason {
                lastSeason = episode.season
            }
        }
        return lastSeason
    }
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller. 
        if segue.identifier == "GOT Epidsode detail" {
            if let destination = segue.destination as? GOTDetailViewController {
                destination.selectedGOTEpisode = selectedGOTEpisodes
                
            }
        }
    }
    
    

}
