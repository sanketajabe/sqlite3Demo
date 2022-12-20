//
//  DBHelper.swift
//  sqlite3Demo
//
//  Created by Apple on 06/12/22.
//

import Foundation
import SQLite3

class DBHelper{
    init(){
        db = openDatabase()
        createTable()
    }
    var dbPath : String = "my_database.sqlite"
    var db : OpaquePointer?
   
// Mark :- Open DataBase
    func openDatabase()->OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        
        print("File URL --\(fileURL.path)")
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_FAIL{
            print("Error in database creation")
            return nil
        }else{
            print("database created successfully \(dbPath)")
            print("Database is : \(db)")
            return db
        }
    }

// Mark :- Creating Employee Table
    func createTable(){
        let creteQueryString = "CREATE TABLE IF NOT EXISTS EMPLOYEE(EmpId INTEGER PRIMARY KEY,EmpName TEXT,EmpCity TEXT);"
        var createTableStatement : OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(db, creteQueryString, -1, &createTableStatement, nil) == SQLITE_OK){
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Employee Table is created")
            }else{
                print("Failed To Create Employee Table")
            }
        }else{
            print("Failed To create prepare statement")
        }
       sqlite3_finalize(createTableStatement)
    }

// Mark :- Insert Record In Employee Table
    func insertEmployeeRecordsIntoEmployeeTable(empId : Int, empName : String, empCity : String){
        let employees = retriveEmployeeRecords()
        for eachEmployee in employees{
            if eachEmployee.empId == empId{
                return
            }
        }
        
        let insertQueryString = "INSERT INTO EMPLOYEE(EmpId,EmpName,EmpCity) VALUES (?,?,?);"
        var insertStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQueryString, -1, &insertStatement, nil) == SQLITE_OK{
            
            sqlite3_bind_int(insertStatement, 1, Int32(empId))
            sqlite3_bind_text(insertStatement, 2, (empName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (empCity as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Row Insert Successfully")
            }else{
                print("Failed To insert Row")
            }
        }else{
            print("Failed To Create prepare statement")
        }
        sqlite3_finalize(insertStatement)
    }
    
// Mark :- Retriving Employee Records
    func retriveEmployeeRecords()->[Employee]{
        let selectQueryString = "SELECT * FROM EMPLOYEE;"
        var selectStatement : OpaquePointer? = nil
        var employees : [Employee] = []
        if sqlite3_prepare_v2(db, selectQueryString, -1, &selectStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectStatement) == SQLITE_ROW{
                let rEmpId = sqlite3_column_int(selectStatement, 0)
                
                let rEmpName = String(describing: String(cString: sqlite3_column_text(selectStatement, 1)))
                
                let rEmpCity = String(describing: String(cString: sqlite3_column_text(selectStatement, 2)))
                
                employees.append(Employee(empId: Int(rEmpId), empName: rEmpName, empCity: rEmpCity))
              
                    print("The result of selected query is : \(rEmpId)--\(rEmpName)--\(rEmpCity)")
            }
        }
        else{
            print("The select Statement preparation failed")
        }
        sqlite3_finalize(selectStatement)
        return employees
    }
    
// Mark :- Deleting Records From Employee Table
    func deleteEmpById(empId : Int){
        let deleteQueryString = "DELETE FROM EMPLOYEE WHERE empId = \(empId);"
        var deleteStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteQueryString, -1, &deleteStatement, nil) == SQLITE_OK{
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("The record of Employee with \(empId) is deleted")
            }else{
                print("record deletion failed")
            }
        }else{
            print("The preparation for delete statement is failed")
        }
        sqlite3_finalize(deleteStatement)
    }
}
