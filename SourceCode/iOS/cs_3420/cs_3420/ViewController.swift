//
//  ViewController.swift
//  cs_3420
//
//  Created by Minh Pham on 3/9/17.
//  Copyright © 2017 devmen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    var courses = [Course]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get_1_course()
        getCoursesFromDB()
        
        //get_1_User()
        getAllStudentsFromDB()
        
        //addCoursesIntoAStudent()
    }
    
    func deleteCoursesOfAStudent() {
        let user = self.users[0]
        //let arrCourses = [self.courses[0], self.courses[1]]
        let arrCourses = [self.courses[0]]
        for cou in arrCourses {
            DataService.instance.deleteCoursesForStudent(user: user, course: cou, { (err) in
           
                print("Delete a \(cou.course_id) for Student successfully")
            })
        }
    }
    
    func addCoursesIntoAStudent() {
        
        let user = self.users[0]
        //let arrCourses = [self.courses[0], self.courses[1]]
        let arrCourses = [self.courses[0]]
        let dict = ["assingment": -1]
        
        for cou in arrCourses {
            DataService.instance.addCoursesForStudent(user: user, course: cou, data: dict) { (err) in
                
                print("Added a \(cou.course_id) for Student successfully")
            }
        }
    }

    @IBAction func btnDelete1_pressed(_ sender: Any) {
        //deleteCourse()
        deleteCoursesOfAStudent()
    }
    
    @IBAction func btnUpdate_Pressed(_ sender: Any) {
        updateCourse()
    }
    
    @IBAction func btnAdd_Pressed(_ sender: Any) {
        //addCourse()
        addCoursesIntoAStudent()
    }
    
    func deleteCourse() {
        let uid = "COMM_1301"
        DataService.instance.deleteCourse(uid: uid) { (err) in
            print("Deleted course successfully")
        }
    }
    
    func updateCourse() {
        
        let course: [String: Any] = [
            CONSTANTS.courses.COURSE_ID: "COMM 1302",
            CONSTANTS.courses.NAME: "Intro to Communication",
            CONSTANTS.courses.TYPE: CONSTANTS.courses.ONLINE,
            CONSTANTS.courses.REGISTERED: 0
        ]
        
        let uid = "COMM_1301"
        
        DataService.instance.updateCourseInfo(uid: uid, data: course) { (err) in
            
            print("Update course successfully")
        }
    }
    
    func addCourse() {
        
        let course_id = "COMM 1301";
        let course: [String : Any] = [
            CONSTANTS.courses.COURSE_ID: course_id,
            CONSTANTS.courses.NAME: "Communication 1",
            CONSTANTS.courses.TYPE: CONSTANTS.courses.HYBRID,
            CONSTANTS.courses.REGISTERED: 0
        ]
        
        let uid = course_id.replacingOccurrences(of: " ", with: "_")
        
        DataService.instance.addCourse(uid: uid, data: course) { (err) in
            print("Added course successfully")
        }
    }
  
    
    func getCoursesFromDB() {
        
        DataService.instance.getAllCourses { (err, courses) in
            
            if let err = err {
                print(err)
                return
            }
            
            if let courses = courses as? [Course] {
                self.courses = courses
                //self.printC(num: 2)
            }
        }
    }
    
    func get_1_course() {
        
        DataService.instance.get_1_course(uid: "CS_3308") { (err, course) in
            
            if let err = err {
                print(err)
                return
            }
            
            if let course = course {
                self.print_1C(course: course as! Course)
            }
        }
    }
    
    func get_1_User() {
        
        DataService.instance.get_1_User(uid: "nhan_nguyen") { (err, user) in
            
            if let err = err {
                print(err)
                return
            }
            
            self.printU(user: user as! User, 0)
        }
    }
    
    func getAllStudentsFromDB() {
    
        DataService.instance.getAllStudents { (err, students) in
            self.users = students as! [User]
            
            //self.printUs(0, 0)
        }
    }
    
    //
    func printC(num: Int) {
        print_1C(course: courses[num])
    }
    
    func print_1C(course: Course) {
        print(course.uid)
        print(course.course_id)
        print(course.name)
        print(course.type)
        print(course.registed)
    }
    
    func printU(user: User, _ course_grade: Int) {
        print(user.email)
        print(user.name)
        print(user.photoUrl)
        print(user.role)
        print(user.student_id)
        
        
        print(user.course_grades?[course_grade].assignment)
        print(user.course_grades?[course_grade].final)
        print(user.course_grades?[course_grade].midterm)
        print(user.course_grades?[course_grade].quiz_1)
        print(user.course_grades?[course_grade].quiz_2)
        print(user.course_grades?[course_grade].uid_course)
    }
    
    func printUs(_ n: Int, _ course_grade: Int) {
        printU(user: users[n], course_grade)
        print(users.count)
    }
}

