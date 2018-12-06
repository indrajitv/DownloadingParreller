//Indrajit

import UIKit

class ViewController: UIViewController,UITextViewDelegate{
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputTop: NSLayoutConstraint!
    
    var dataSource = [Message]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let messageArray = ["Lorem Ipsum is simply dummy","text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard","dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen boo","anged. It was popularised in the 1960s with the release of Letraset sheets","Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged. It was popularises roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged. It was ext. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged.rds, consectetu","ant simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 yeold. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","Lorem Ipsum is simply dummy","text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard","dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen boo","anged. It was popularised in the 1960s with the release of Letraset sheets","Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged. It was popularises roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged. It was ext. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu","anged.rds, consectetu","ant simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 yeold. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetu"]
        for (index,msg) in messageArray.enumerated(){
            let obj = Message()
            obj.text = msg
            
            obj.sender = index % 2 == 0 
            
            dataSource.append(obj)
            
        }
        
        tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      

        tableView.keyboardDismissMode = .onDrag


        title = "Kush"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewItem))
        
        
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: messageArray.count-1, section: 0), at: .bottom, animated: false)
        }
       
       
        DownloadFile().downloadwithUrl(urlString: "https://sample-videos.com/video123/mp4/240/big_buck_bunny_240p_30mb.mp4", taskId: "kush_ekko", progress: { (prog, id) in
            print("progress -- " , prog, "-- ",id)
        }, downloadedData: { (downloadedData, id) in
            print("completed -- " , downloadedData, "-- ",id)
        }) { (error, id) in
            print("error -- " , error?.localizedDescription, "-- ",id)
        }
        
        
        DownloadFile().downloadwithUrl(urlString: "https://sample-videos.com/video123/mp4/240/big_buck_bunny_240p_20mb.mp4", taskId: "nimlo_ekko", progress: { (prog, id) in
            print("progress -- " , prog, "-- ",id)
        }, downloadedData: { (downloadedData, id) in
            print("completed -- " , downloadedData, "-- ",id)
        }) { (error, id) in
            print("error -- " , error?.localizedDescription, "-- ",id)
        }
        
        
        
     
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            inputTop.constant = keyboardSize.height
            UIView.animate(withDuration: 0) {
                self.view.layoutIfNeeded()
                  self.tableView.scrollToRow(at: IndexPath(row: self.dataSource.count-1, section: 0), at: .bottom, animated: false)
            }
          
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        inputTop.constant = 0
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
  
 
    
    
    @objc func addNewItem(){
        
        let obj = Message()
        obj.text = "New cell added"
        self.dataSource.append(obj)
        
        
        let indexPath = IndexPath(row: self.dataSource.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)

        
        tableView.scrollToRow(at: IndexPath(row: self.dataSource.count-1, section: 0), at: .bottom, animated: true)
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            if textView.text != ""{
                let obj = Message()
                obj.text = textView.text!
                self.dataSource.append(obj)
                let indexPath = IndexPath(row: self.dataSource.count-1, section: 0)
                tableView.insertRows(at: [indexPath], with: .fade)
                
                
                tableView.scrollToRow(at: IndexPath(row: self.dataSource.count-1, section: 0), at: .bottom, animated: true)
            }
            return false
        }
        else
        {
            return true
        }
    }
}




extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomerChatCell
        cell.message = dataSource[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 500{
            let messageArray = ["\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())","\(Date())"]
            var indexPaths = [IndexPath]()
            for (index,msg) in messageArray.enumerated(){
                
                let obj = Message()
                obj.text = msg
                
                obj.sender = index % 2 == 0
                
                dataSource.append(obj)
                
                
                indexPaths.append(IndexPath(item: 0, section: 0))
                
                
                
                
            }
           self.tableView.insertRows(at: indexPaths, with: .none)
            
            print("##################PAGINATION")
        }
    }
    
    
}



class Message:NSObject{
    var text:String?
    var sender = true
    var id:String?
}



