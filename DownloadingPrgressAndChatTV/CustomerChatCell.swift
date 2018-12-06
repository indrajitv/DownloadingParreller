//Indrajit

import UIKit
class CustomerChatCell:UITableViewCell{
  
    
    @IBOutlet  var rightAnc: NSLayoutConstraint!
    
    @IBOutlet var leftAnc: NSLayoutConstraint!
    
    
    var message:Message?{
        didSet{
         
            if let messageObject = message{
                
                if messageObject.sender{
                    
                    mainContainerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
                    chatTextView.textColor = UIColor.black
                    rightAnc.isActive = true
                    leftAnc.isActive = false
                    
                }else{ //Receiver
                    mainContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    chatTextView.textColor = .white
                    rightAnc.isActive = false
                    leftAnc.isActive = true
                    
                }
               
                if let messageText = messageObject.text{
                    if messageText.count < 8{
                        let extra = String.init(repeating: " ", count: abs(messageText.count - 8))
                        chatTextView.text = messageText + extra
                    }else{
                        chatTextView.text = messageText
                    }
                    
                }else{
                    chatTextView.text = "No message"
                }
            }
        }
    }
    
    @IBOutlet weak var mainContainerView:UIView!{
        didSet{
            mainContainerView.layer.masksToBounds = true
            mainContainerView.layer.cornerRadius = 4
        }
    }
    @IBOutlet weak var chatTextView: UITextView!
    
}
