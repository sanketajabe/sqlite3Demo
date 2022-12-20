//
//  ViewController.swift
//  sqlite3Demo
//
//  Created by Apple on 06/12/22.
//

import UIKit

class ViewController: UIViewController {
    var employees = [Employee]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegisterNIB()
        InitializeDatasourceAndDelegate()
        var dbHelper = DBHelper()
     
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 10, empName: "Om", empCity: "Pune")
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 11, empName: "Sai", empCity: "Pune")
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 12, empName: "Sai", empCity: "Pune")
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 13, empName: "Sai", empCity: "Pune")
        
        employees = dbHelper.retriveEmployeeRecords()
        
        dbHelper.deleteEmpById(empId: 12)
        
        employees = dbHelper.retriveEmployeeRecords()
        
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 18, empName: "ram", empCity: "Pune")
        dbHelper.insertEmployeeRecordsIntoEmployeeTable(empId: 13, empName: "ram", empCity: "Pune")
       
        dbHelper.deleteEmpById(empId: 18)
        employees = dbHelper.retriveEmployeeRecords()
        
    }
     
// Mark:- Register Xib File
    func RegisterNIB(){
        let uinib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: "tableViewCell")
    }
    
// Mark:- Define Datasource And Delegate
    func InitializeDatasourceAndDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.id.text = String(employees[indexPath.row].empId)
        cell.name.text = employees[indexPath.row].empName
        cell.city.text = employees[indexPath.row].empCity
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
