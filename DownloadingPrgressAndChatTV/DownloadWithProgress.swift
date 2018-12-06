


//Indrajit

import UIKit
class DownloadFile:NSObject,URLSessionDelegate,URLSessionDataDelegate{
    
    
    var taskId:String?
    var dataTask:URLSessionDataTask!
    var session:URLSession!
    
    var expectedContentLength = 0
    
    var buffer = Data()
    
    typealias CompletionHanlderProgess = (_ percentage:CGFloat,_ taskId:String?)->Void
    typealias CompletionHanlderError = (_ error:Error?,_ taskId:String?)->Void
    typealias CompletionHanlderFinished = (_ data:Data?,_ taskId:String?)->Void
    
    var progressHandler:CompletionHanlderProgess?
    var progressError:CompletionHanlderError?
    var finishedHanlder:CompletionHanlderFinished?
    
    func downloadwithUrl(urlString:String,taskId:String?,progress:@escaping CompletionHanlderProgess,downloadedData:@escaping CompletionHanlderFinished,error:@escaping CompletionHanlderError){
        
        self.taskId = taskId
        progressHandler = progress
        progressError = error
        self.finishedHanlder = downloadedData
        
        let configuration = URLSessionConfiguration.default
        let mainQueue = OperationQueue.main
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: mainQueue)
        
        if let url = URL(string:urlString){
            let request = URLRequest(url: url)
            self.dataTask = session.dataTask(with: request)
            self.dataTask?.resume()
            
        }
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void){
        
        expectedContentLength = Int(response.expectedContentLength)
        completionHandler(.allow)
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask){
        
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask){
        
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        
        self.buffer.append(data)
        
        let percentageDownloaded = Float(self.buffer.count) / Float(expectedContentLength)
        self.progressHandler?(CGFloat(percentageDownloaded),self.taskId)
        if percentageDownloaded >= 1{
            self.finishedHanlder?(self.buffer, self.taskId)
        }
        
        
        
    }
    
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void){
        
    }
    
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?){
        self.progressError?(error,self.taskId)
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){
        if challenge.previousFailureCount > 0 {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        } else if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("unknown state. error: \(challenge.error)")
            self.progressError?(challenge.error,self.taskId)
        }
    }
    
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession){
        
    }
    
}
