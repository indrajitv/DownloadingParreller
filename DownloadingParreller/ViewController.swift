//
//  ViewController.swift
//  DownloadingParreller
//
//  Created by sculpsoft-mac on 30/11/18.
//  Copyright © 2018 sculpsoft-mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var dataSource = [Download]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0...30{
            let down = Download()
            dataSource.append(down)
        }
        
        tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadingCell") as! DownloadingCell
        cell.dataSource = dataSource[indexPath.item]
        cell.refOfClass = self
        return cell
    }
    
    
    
    func startDownaloading(downoad:Download){
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
            downoad.percentage += 2
            
            print(downoad.id,downoad.percentage)
            for cell in self.tableView.visibleCells{
                if let down = cell as? {
                    if down.dataSource?.id == downoad.id{
                       down.dataSource = DownloadingCell
                    }
                }
            }
            
        }
    }

}



class DownloadingCell:UITableViewCell{
    
  
    var refOfClass:ViewController?
    
    var dataSource:Download?{
        didSet{
            widthOfBlue.constant = dataSource!.percentage
        }
    }
    
    @IBOutlet weak var downlaodButton: UIButton!
    
    @IBOutlet weak var widthOfBlue: NSLayoutConstraint!
    @IBAction func downloadingClicked(_ sender: UIButton) {
        dataSource?.isDownloading = true
        refOfClass?.startDownaloading(downoad: dataSource!)
    }
    
}



class Download{
    var percentage:CGFloat = 0
    var isDownloading = false
    var id:Int = Int.random(in: 5555...9999)
}
