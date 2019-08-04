//
//  DB.swift
//  RealmSwift
//
//  Created by Riccardo Rizzo on 12/07/17.
//  Copyright © 2017 Riccardo Rizzo. All rights reserved.
//

import UIKit
import RealmSwift

//class DBManager {
//
//    private var database:Realm
//    static let sharedInstance = DBManager()
//
//    private init() {
//
//        database = try! Realm()
//
//    }
//
//    func getDataFromDB() -> Results<ExamQuestionFull> {
//
//        let results: Results<ExamQuestionFull> = database.objects(ExamQuestionFull.self)
//        return results
//    }
//
//    func addData(object: ExamQuestionFull) {
//
//        try! database.write {
//            database.add(object, update: true)
//            print("Added new object")
//        }
//    }
//
//    func addArrayOfData(objects: [ExamQuestionFull]) {
//
//        try! database.write {
//            for object in objects{
//                database.add(object, update: false)
//                print("Added new object")
//            }
//        }
//    }
//
//    func deleteAllDatabase()  {
//        try! database.write {
//            database.deleteAll()
//        }
//    }
//
//    func deleteFromDb(object: ExamQuestionFull) {
//
//        try! database.write {
//
//            database.delete(object)
//        }
//    }
//
//}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

class NotesDBManager {
    
    private var database:Realm
    static let sharedInstance = NotesDBManager()
    
    private init() {
        
        database = try! Realm()
        
    }
    
    func getDataFromDB() -> Results<UserNoteFull> {
        
        let results: Results<UserNoteFull> = database.objects(UserNoteFull.self)
        return results
    }
    
    func getNotesFromDB() -> [UserNoteFull] {
        
        let results: Results<UserNoteFull> = database.objects(UserNoteFull.self)
        var notesArray = [UserNoteFull]()
        let resultsArray = results.toArray(ofType: UserNoteFull.self) as [UserNoteFull]
        for note in resultsArray{
            notesArray.append(note)
        }
        return notesArray
    }
    
    func getNoteWithId(id : Int) -> UserNoteFull? {
        
        let results: Results<UserNoteFull> = database.objects(UserNoteFull.self)
        for note in results{
            if note.noteId == id{
                return note
            }
        }
        return nil
    }
    
    func addData(object: UserNoteFull) {
        
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func updateData(object: UserNoteFull) {
        let obj = self.getNoteWithId(id: object.noteId)
        self.deleteFromDb(object: obj!)
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func deleteData(object: UserNoteFull) {
        try! database.write {
            object.isDeleted = true
            print("Added new object")
        }
    }
    
    func updateDataWithText(id :Int, text:String) {
        let obj = self.getNoteWithId(id: id)
        try! database.write {
            obj?.note = text
            print("Added new object")
        }
    }
    
    func addArrayOfData(objects: [UserNoteFull]) {
         
        try! database.write {
            for object in objects{
                database.add(object, update: false)
                print("Added new object")
            }
        }
    }
    
    func deleteAllDatabase()  {
        
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteAllNotesInDatabase()  {
        try! database.write {
            let allNotes = database.objects(UserNoteFull.self)
            database.delete(allNotes)
            
            //            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: UserNoteFull) {
        
        try! database.write {
            
            database.delete(object)
        }
    }
    
}

class ExamsDBManager {
    
    private var database:Realm
    static let sharedInstance = ExamsDBManager()
    
    private init() {
        
        database = try! Realm()
        
    }
    
    func getDataFromDB() -> Results<Exam> {
        
        let results: Results<Exam> = database.objects(Exam.self)
        return results
    }
    
    func getExamsFromDB() -> [Exam] {
        
        let results: Results<Exam> = database.objects(Exam.self)
        var examsArray = [Exam]()
        let resultsArray = results.toArray(ofType: Exam.self) as [Exam]
        for note in resultsArray{
            examsArray.append(note)
        }
        return examsArray
    }
    
    func getExamWithId(id : Int) -> Exam? {
        
        let results: Results<Exam> = database.objects(Exam.self)
        for exam in results{
            if exam.examId == id{
                return exam
            }
        }
        return nil
    }
    
    func addData(object: Exam/* , questions: [ExamQuestionFull]*/) {
        
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func addArrayOfData(objects: [Exam]) {
        
        try! database.write {
            for object in objects{
                database.add(object, update: false)
                print("Added new object")
            }
        }
    }
    
    func deleteAllExamsInDatabase()  {
        
        try! database.write {
            let allExams = database.objects(Exam.self)
            database.delete(allExams)
            
//            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: Exam) {
        
        try! database.write {
            
            database.delete(object)
        }
    }
    
}

class PracticesDBManager {
    
    private var database:Realm
    static let sharedInstance = PracticesDBManager()
    
    private init() {
        
        database = try! Realm()
        
    }
    
    func getDataFromDB() -> Results<PracticeQuestionFull> {
        
        let results: Results<PracticeQuestionFull> = database.objects(PracticeQuestionFull.self)
        return results
    }
    
    func getExamsFromDB() -> [PracticeQuestionFull] {
        
        let results: Results<PracticeQuestionFull> = database.objects(PracticeQuestionFull.self)
        var practicesArray = [PracticeQuestionFull]()
        let resultsArray = results.toArray(ofType: PracticeQuestionFull.self) as [PracticeQuestionFull]
        for note in resultsArray{
            practicesArray.append(note)
        }
        return practicesArray
    }
    
    func getExamWithId(id : Int) -> PracticeQuestionFull? {
        
        let results: Results<PracticeQuestionFull> = database.objects(PracticeQuestionFull.self)
        for practiceQues in results{
            if practiceQues.questionId == id{
                return practiceQues
            }
        }
        return nil
    }
    
    func addData(object: PracticeQuestionFull/* , questions: [ExamQuestionFull]*/) {
        
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func updateData(questionID: String , userAnswer:String) {
        let obj = database.objects(PracticeQuestionFull.self).filter("questionId = \(questionID)")[0]
//        PracticesDBManager.sharedInstance.deleteFromDb(object: obj)
        
        try! database.write {
//            database.add(updatedQuestion, update: false)
            obj.userAnswer = userAnswer
            print("updated new object")
        }
    }
    
//    func updateData(questionID: Int) {
//        let obj = database.objects(PracticeQuestionFull.self).filter("questionId = \(questionID)")[0]
//
//        try! database.write {
//            database.add(updatedQuestion, update: false)
//            print("Added new object")
//        }
//    }
    
    func filterData(filterSyntax : String) -> [PracticeQuestionFull] {
        let objs = database.objects(PracticeQuestionFull.self).filter(filterSyntax)
        
        return Array(objs)
    }
    func filterData(predicate : NSPredicate) -> [PracticeQuestionFull] {
        let objs = database.objects(PracticeQuestionFull.self).filter(predicate)
        
        return Array(objs)
    }
    
    func addArrayOfData(objects: [PracticeQuestionFull]) {
        
        try! database.write {
            for object in objects{
                database.add(object, update: false)
                print("Added new object")
            }
        }
    }
    
    func deleteAllPracticesQuestionsInDatabase()  {
        
        try! database.write {
            let allQuestions = database.objects(PracticeQuestionFull.self)
            database.delete(allQuestions)
            
            //            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: PracticeQuestionFull) {
        
        try! database.write {
            
            database.delete(object)
        }
    }
    
}

class DateDBManager { // DateQuestionsTransactions
    
    private var database:Realm
    static let sharedInstance = DateDBManager()
    
    private init() {
        
        database = try! Realm()
        
    }
    
    func getDataFromDB() -> Results<DateQuestionsTransactions> {
        
        let results: Results<DateQuestionsTransactions> = database.objects(DateQuestionsTransactions.self)
        return results
    }
    
    func getTransactionsFromDB() -> [DateQuestionsTransactions] {
        
        let results: Results<DateQuestionsTransactions> = database.objects(DateQuestionsTransactions.self)
        var practicesArray = [DateQuestionsTransactions]()
        let resultsArray = results.toArray(ofType: DateQuestionsTransactions.self) as [DateQuestionsTransactions]
        for note in resultsArray{
            practicesArray.append(note)
        }
        return practicesArray
    }
    
    func getTransactionsWithdate(date : String) -> DateQuestionsTransactions? {
        
        let results: Results<DateQuestionsTransactions> = database.objects(DateQuestionsTransactions.self)
        for practiceQues in results{
            if practiceQues.date == date{
                return practiceQues
            }
        }
        return nil
    }
    
    func addData(object: DateQuestionsTransactions/* , questions: [ExamQuestionFull]*/) {
        
        try! database.write {
            database.add(object, update: false)
            print("Added new object")
        }
    }
    
    func updateData(date: String , correct:Int , wrong : Int) {
        let obj = database.objects(DateQuestionsTransactions.self).filter("date = '\(date)'")[0]
        //        PracticesDBManager.sharedInstance.deleteFromDb(object: obj)
        
        try! database.write {
            //            database.add(updatedQuestion, update: false)
            obj.correctCount = obj.correctCount + correct
            obj.wrongCount = obj.wrongCount + wrong
            print("updated new object")
        }
    }
    
    //    func updateData(questionID: Int) {
    //        let obj = database.objects(PracticeQuestionFull.self).filter("questionId = \(questionID)")[0]
    //
    //        try! database.write {
    //            database.add(updatedQuestion, update: false)
    //            print("Added new object")
    //        }
    //    }
    
    func filterData(filterSyntax : String) -> [DateQuestionsTransactions] {
        let objs = database.objects(DateQuestionsTransactions.self).filter(filterSyntax)
        
        return Array(objs)
    }
    func filterData(predicate : NSPredicate) -> [DateQuestionsTransactions] {
        let objs = database.objects(DateQuestionsTransactions.self).filter(predicate)
        
        return Array(objs)
    }
    
    func addArrayOfData(objects: [DateQuestionsTransactions]) {
        
        try! database.write {
            for object in objects{
                database.add(object, update: false)
                print("Added new object")
            }
        }
    }
    
    func deleteAllTransactionsInDatabase()  {
        
        try! database.write {
            let allQuestions = database.objects(DateQuestionsTransactions.self)
            database.delete(allQuestions)
            
            //            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: DateQuestionsTransactions) {
        
        try! database.write {
            
            database.delete(object)
        }
    }
    
}
