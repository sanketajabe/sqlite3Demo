//
//  Employee.swift
//  sqlite3Demo
//
//  Created by Apple on 06/12/22.
//

import Foundation
class Employee{
    var empId : Int
    var empName : String
    var empCity : String
    
    init(empId: Int, empName: String, empCity: String) {
        self.empId = empId
        self.empName = empName
        self.empCity = empCity
    }
    
    deinit{
        
    }
}
