//
//  RoomsViewController.swift
//  Club Chat
//
//  Created by Caner on 12.07.2021.
//

import UIKit

class RoomsViewController: UIViewController {
    @IBOutlet weak var roomsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
}
//MARK: - UITableViewDelegate,UITableViewDataSource
extension RoomsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as! RoomsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
