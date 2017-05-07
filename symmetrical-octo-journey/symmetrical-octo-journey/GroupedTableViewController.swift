//
//  GroupedTableViewController.swift
//  symmetrical-octo-journey
//
//  Created by Dustin Pfannenstiel on 5/6/17.
//  Copyright © 2017 Dustin Pfannenstiel. All rights reserved.
//

import UIKit

class GroupedTableViewController: UITableViewController {

    var colors = [[String]]()
    
    @IBAction func addSection(_ sender: Any) {
        colors.append([String]())
        addColor(sender)
    }
    
    @IBAction func addColor(_ sender: Any) {
        colors[colors.endIndex - 1] = colors.last! + [randomHexString()]
        tableView.reloadData()
    }

    func randomHexString(length:Int = 6) -> String {
        var hexString = ""
        for _ in 0..<length {
            hexString += String(format:"%X", arc4random_uniform(16))
        }
        return hexString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSection(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return colors.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colors[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)

        let hexString = colors[indexPath.section][indexPath.row]
        let color = UIColor.colorFrom(hex: hexString)
        let inverse = color.inverted
        cell.textLabel?.text = hexString
        cell.contentView.backgroundColor = color
        cell.textLabel?.textColor = inverse
        return cell
    }

}

extension UIColor {
    
    class func colorFrom(hex:String) -> UIColor {
        // Shamelessly copied from http://stackoverflow.com/a/27203691/296174
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    var inverted: UIColor {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: (1 - r), green: (1 - g), blue: (1 - b), alpha: a) // Assuming you want the same alpha value.
    }
}

