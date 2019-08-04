//
//  URLs.swift
//  PMP
//
//  Created by Mohammed Ahmed on 6/9/18.
//  Copyright © 2018 PMP.PMP. All rights reserved.
//

import Foundation

enum URLs{
    enum Path : String{
        case login = "http://www.professionalengineers.us/pmpmaster/public/api/login"
        case forgotPassword = "http://www.professionalengineers.us/pmpmaster/public/api/forgetPassword"
        case Register = "http://www.professionalengineers.us/pmpmaster/public/api/register"
        case askInstructor = "http://www.professionalengineers.us/pmpmaster/public/api/instructorQuestions"
        case addQuestion = "http://www.professionalengineers.us/pmpmaster/public/api/instructorQuestion/add"
        case deleteQuestion = "http://www.professionalengineers.us/pmpmaster/public/api/instructorQuestion/delete"
        case seenQuestion = "http://www.professionalengineers.us/pmpmaster/public/api/instructorQuestion/seen"
        case userNotes = "http://www.professionalengineers.us/pmpmaster/public/api/notes"
        case addUserNotes = "http://www.professionalengineers.us/pmpmaster/public/api/note/add"
        case addUpdateNotes = "http://www.professionalengineers.us/pmpmaster/public/api/note/update"
        case deleteNote = "http://www.professionalengineers.us/pmpmaster/public/api/note/delete"
        case loginWithFB = "http://www.professionalengineers.us/pmpmaster/public/api/loginWithFacebook"
        case registerWithFB = "http://www.professionalengineers.us/pmpmaster/public/api/signupWithFacebook"
        case getProfile = "http://www.professionalengineers.us/pmpmaster/public/api/user"
        case updateProfile = "http://www.professionalengineers.us/pmpmaster/public/api/updateUserData"
        case getExam = "http://www.professionalengineers.us/pmpmaster/public/api/questions/exam"
        case reportQuestion = "http://www.professionalengineers.us/pmpmaster/public/api/reportQuestion"
        case loginWithLinkedIn = "http://www.professionalengineers.us/pmpmaster/public/api/loginWithLinkedIn"
        case registerWithLinkedIn = "http://www.professionalengineers.us/pmpmaster/public/api/signupWithLinkedIn"
        case syncNotes = "http://www.professionalengineers.us/pmpmaster/public/api/note/sync"
        case previousExams = "http://www.professionalengineers.us/pmpmaster/public/api/userExams"
        case practiceQuestions = "http://www.professionalengineers.us/pmpmaster/public/api/questions"
        
        case userLevels = "http://www.professionalengineers.us/pmpmaster/public/api/userLevels"
        case updateUserLevels = "http://www.professionalengineers.us/pmpmaster/public/api/updateUserLevel"
    }

    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
}
