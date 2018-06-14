
class BrassBitCoinBlock {
    
    var index : Int = 0
    var minedBy : String = ""
    var data : String = ""
    var previousHash : String = ""
    var nonce: Int = 0
    public var generatedHash : String = ""
    
    public init(withIndex index : Int, miner minedBy : String, havingData data: String, withNonce nonce : Int, previousHash : String) {
        
        self.index = index
        self.minedBy = minedBy
        self.data = data
        self.previousHash = previousHash
        self.nonce = nonce
    }
    
    func simpleDescription() -> String {
        
        return "\(index) \(minedBy) \(data) \(previousHash) \(nonce)"
        
    }
    
    private func hash() -> String {
        
        let sha = SHA256(self.simpleDescription())
        
        generatedHash = sha.digestString()
        return self.generatedHash
    }
    
    public func checkHash(_ newNonce : Int) -> Bool {
        self.nonce = newNonce
        let hash = String(self.hash())
        
        
        for j in 0...3 {
            let index = hash.index(hash.startIndex, offsetBy: j)
            if (hash[index] != "0") {
                return false
                
            }
        }
        
        return true
    }
    
}
