//
//  TransactionsLoader.swift
//  ParticlesBackground
//
//  Created by Andrew Turkin on 15.04.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

class TransactionsLoader {
    func contentsOfFile(_ filename: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            throw NSError(domain: "Unable to find file \(filename)", code: 1, userInfo: nil)
        }
        guard let contentsData = FileManager.default.contents(atPath: path) else {
            throw NSError(domain: "Can't retrieve object data", code: 1, userInfo: nil)
        }
        
        return contentsData
    }
    
    func loadTransactions() throws -> [Transaction] {
        let TransactionsFileName = "transactions"
        let transactionsData = try contentsOfFile(TransactionsFileName)
        let transactionsAsArray = try JSONDecoder().decode([Transaction].self, from: transactionsData)
        return transactionsAsArray
    }
}
