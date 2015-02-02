//
//  sql.swift
//  RhodesTourist
//
//  Created by Morgan McCullough on 2/2/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

import Foundation


let myDatabase = FMDatabase(path: "/" )

if myDatabase == nil {
    // Database could not be found or created
} else {
    if myDatabase.open() {
        
    }
}