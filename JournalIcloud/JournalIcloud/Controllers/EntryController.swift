//
//  EntryController.swift
//  JournalIcloud
//
//  Created by Connor Holland on 6/29/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    
    //MARK: - Crud Methods
    //add
    func createEntryWith(title: String, body: String, completion: @escaping (Result<Entry, EntryError>) -> Void) {
        let newEntry = Entry(title: title, body: body)
        save(entry: newEntry) { (result) in
            switch result {
            case .success(let entry):
                guard let entry = entry else {return}
                self.entries.append(entry)
                completion(.success(entry))
            case .failure(let error):
                print("\(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    //save
    func save(entry: Entry, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        let newRecord = CKRecord(entry: entry)
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("There was an error saving an Entry: \(error) - \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            //Ask about savedEntry
            guard let record = record, let savedEntry = Entry(ckRecord: record) else {return completion(.failure(.couldNotUnwrap))}
            print("Saved Entry Successfully")
            completion(.success(savedEntry))
        }
    }
    
    //fetch
    func fetchEntriesWith(completion: @escaping (Result<[Entry], EntryError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.recordTypeKey, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("There was an error fetching all entries - \(error) - \(error.localizedDescription)")
                completion(.failure(.ckError(error)))
            }
            
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            print("Fetched Entry Records Successfully.")
            
            let fetchedEntries = records.compactMap {Entry(ckRecord: $0)}
    
            completion(.success(fetchedEntries))
        }
    }
}
