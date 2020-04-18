//
//  ViewController.swift
//  tableView
//
//  Created by Amardeep Singh on 2020/04/17.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//	
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    //Outlets
    @IBOutlet weak var iphoneLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    //Variables
    var toggle : Bool = true
    
    var filteredName = [String]()
    
    var isSearching = false

    var name = ["iPhone 11","iphone X🅁","iPhone 11 Pro","iPhone 8","iPhone SE","iPhone 7","iPhone 8 Plus"]
   
    var images = ["1","2","3","4","5","6","7"]

    var url = ["https://www.apple.com/in/iphone-11/specs/",
               "https://www.apple.com/in/iphone-xr/specs/",
               "https://www.apple.com/in/iphone-11-pro/specs/",
               "https://www.apple.com/in/iphone-8/specs/",
               "https://www.gsmarena.com/apple_iphone_se-7969.php",
               "https://gadgets.ndtv.com/apple-iphone-7-3766",
               "https://www.apple.com/in/iphone-8/specs/"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        
        tableView.dataSource = self
        
        searchbar.delegate = self

        searchbar.isHidden = true
        
        filteredName = name

        setNavigationBarProperties()

        tableView.separatorColor = UIColor(displayP3Red: 253/255, green: 247/255, blue: 162/155, alpha: 1.0)
        
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        searchbar.backgroundColor = UIColor.red
        
        self.tableView.reloadData()

    }
    

    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredName.count
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell

        let data = filteredName[indexPath.row]
            
        cell?.phoneLabel.text = data
        
        cell?.phoneImage.image = UIImage(named: images[name.firstIndex(of: "\(data)")!])

        return cell!
       }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //unhighlight cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        //perform segue
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "infoViewController") as? infoViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //pass data b/w viewControllers
        let data = name.firstIndex(of: "\(filteredName[indexPath.row])")!
        
        vc?.name = name[data]
        
        vc?.img = images[indexPath.row]
        
        vc?.url = url[data]
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        
        toggle.toggle()
        
        switch toggle {
            
        case true:
            hideSearchBar()
            filteredName = name
            tableView.reloadData()
            
        case false:
            showSearchBar()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            
            filteredName = name
            
            print("UISearchBar.text cleared!")
            
            tableView.reloadData()
        }
        else {
            
            filteredName = searchText.isEmpty ? name : name.filter({(dataString: String) -> Bool in
                  return dataString.range(of: searchText, options: .caseInsensitive) != nil
              })
              tableView.reloadData()
        }
    }
    

    
    func hideSearchBar(){
        self.searchbar.isHidden = true

        UIView.animate(withDuration: 0.5, animations: {
            
        self.tableView.frame = CGRect(x: 0, y: 144, width: 414, height: 752)
            
        })
    }
    
    func showSearchBar(){
        self.searchbar.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            
        self.tableView.frame = CGRect(x: 0, y: 178, width: 414, height: 718)
            
        })
    }
    
    
    //Customise Navigation Bar
    func setNavigationBarProperties(){
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 182/255, green: 220/255, blue: 216/255, alpha: 1.0)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}
