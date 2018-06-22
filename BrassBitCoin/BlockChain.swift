
import Foundation

class BlockChain : API {
    
    let apiUrl = "https://yorkshire-brassbitcoin.azurewebsites.net/"
    
    func fetchLatestBlock(onSuccess successCallback : @escaping ClosureType){
        
        if let latestUrl = NSURL(string: apiUrl + "api/blocks?latest=true" ) {
        
            
            self.makeRequest(url: latestUrl, onSuccess: {
                
                (responseData:Any?) in
                
                self.parseJson(fromRawData: responseData as! Data, intoCodable: BrassBitCoinBlock.self, ifSuccessful: successCallback)
                
            })
        }
        
        
    }
    

    
}
