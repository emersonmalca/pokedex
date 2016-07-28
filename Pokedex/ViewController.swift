//
//  ViewController.swift
//  Pokedex
//
//  Created by emersonmalca on 7/27/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pokedex = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokedex"
        
        pokedex.append(Pokemon(name: "Pidgey", type: "Normal / Flying", summary: "Pidgey is pure XP gold", evolutions: ["Pidgeotto", "Pidgeot"]))
        pokedex.append(Pokemon(name: "Spearow", type: "Normal / Flying", summary: "Spearow is remarkably angry", evolutions: ["Fearow"]))
        pokedex.append(Pokemon(name: "Jynx", type: "Psychic", summary: "Will cast a spell on you", evolutions: []))
        
        // Credits
        let credits = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(creditsTapped))
        navigationItem.setRightBarButtonItem(credits, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedex.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let pokemon = pokedex[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = pokemon.type
        cell.imageView?.image = UIImage(named: "\(pokemon.name)-Thumb")
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("Detail") as? DetailViewController {
            let pokemon = pokedex[indexPath.row]
            vc.pokemon = pokemon
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func creditsTapped() {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("CreditsNavigation") as? UINavigationController {
            presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
}

