
import Foundation
   
let previousIndex = 113
   
class Miner {
    
    func mine(){

        let b = BrassBitCoinBlock(withIndex: previousIndex, miner: "DavidT", havingData: "Transaction,DavidT,David,-35 Transaction,DavidT,Kev,-9999 Transaction,DavidT,DavidB,-1 Transaction,DavidT,TopDevs,-998 Transaction,Genesis,DavidT,-1 Transaction,Bob,DavidT,-1 Transaction,Eve,DavidT,-1", withNonce: 0, previousHash: "000001749591B56361755A44E99A7AB0AC6FCCC146084764BB8B54384E2DA741")
        
        var iteration = 0
        
        var r = Int(arc4random())

        while (!b.checkHash(r)) {
            r = Int(arc4random())
            iteration += 1
            if (iteration % 10000 == 0) {
                print("Reached Iteration: \(iteration)")
                print("Last hash tried: \(b.generatedHash)")
            }
        }

        print(b.generatedHash)
        print("nonce: \(b.nonce) ")

    }
}
