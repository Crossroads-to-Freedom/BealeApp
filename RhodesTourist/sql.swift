//
//  maybe.swift
//  RhodesTourist
//
//  Created by Morgan McCullough on 2/2/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

import Foundation


var queue: FMDatabaseQueue?

func testDatabaseQueue() {
    let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let databasePath = documentsFolder.stringByAppendingPathComponent("test.sqlite")
    
    queue = FMDatabaseQueue(path: databasePath)
    
    // create table
    
    queue?.inDatabase() {
        db in
        
        if !db.executeUpdate("create table test (id integer primary key autoincrement, a text)", withArgumentsInArray:nil) {
            println("table create failure: \(db.lastErrorMessage())")
            return
        }
    }
    
    // let's insert five rows
    
    queue?.inTransaction() {
        db, rollback in
        
        for i in 0 ..< 5 {
            if !db.executeUpdate("insert into test (a) values (?)", withArgumentsInArray: ["Row \(i)"]) {
                println("insert \(i) failure: \(db.lastErrorMessage())")
                rollback.initialize(true)
                return
            }
        }
    }
    
    // let's try inserting rows, but deliberately fail half way and make sure it rolls back correctly
    
    queue?.inTransaction() {
        db, rollback in
        
        for i in 5 ..< 10 {
            if !db.executeUpdate("insert into test (a) values (?)", withArgumentsInArray: ["Row \(i)"]) {
                println("insert \(i) failure: \(db.lastErrorMessage())")
                rollback.initialize(true)
                return
            }
            
            if (i == 7) {
                rollback.initialize(true)
            }
        }
    }
    
    // let's prove that only the first five rows are there
    
    queue?.inDatabase() {
        db in
        
        if let rs = db.executeQuery("select * from test", withArgumentsInArray:nil) {
            while rs.next() {
                println(rs.resultDictionary())
            }
        } else {
            println("select failure: \(db.lastErrorMessage())")
        }
    }

}
