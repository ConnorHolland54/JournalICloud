//
//  EntryError.swift
//  JournalIcloud
//
//  Created by Connor Holland on 6/29/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
            
        case .ckError(let error):
            return "There was an error: \(error) - \(error.localizedDescription)"
        case .couldNotUnwrap:
            return "There was a problem unwrapping."
        }
    }
}
