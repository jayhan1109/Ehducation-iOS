//
//  Constants.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

struct K {
    static let titles = [
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
        "What is Pie?",
    ]
    
    static let contents = [
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "savflksdjfv     lkjsadflvijdflk j  dlfv    kdjf ldifvjqwlkfdjvliwejflviajsflv wf 13414",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "Hello world wodelfi elfiej ldi fjelf ivldfi ejv ldfivldfivejldvieldkfjvelvdijelvdkjvlei",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "asdfasdfasdflkasjflksdjflkjfklajdflkjfklasjdfklajlkdfjflkajdfklasdsadfasdfasdfdasf",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
        "Pie cannot defeat Number 4, because it's 3.141592... hahaha",
    ]
    
    static let MainPageCellIdentifier = "MainCell"
    static let MainTableViewCell = "MainTableViewCell"
    
    static let subjects = ["English", "Math", "Science"]
    static let grades = ["8", "9", "10"]
    
    struct Colors{
        static let textPrimaryColor = "TextPrimaryColor"
        static let textSecondaryColor = "TextSecondaryColor"
        static let cardBackgroundColor = "CardBackgroundColor"
        static let pageBackgroundColor = "PageBackgroundColor"
        static let primaryColor = "PrimaryColor"
        static let questionLetterColor = "QuestionLetterColor"
        static let selectedAnswerCardColor = "SelectedAnswerCardColor"
        static let selectedAnswerMarkColor = "SelectedAnswerMarkColor"
    }
    
    struct FStore {
        struct User {
            static let userIdField = "user_id"
            static let collectionName = "users"
            static let usernameField = "username"
            static let emailField = "email"
            static let expField = "exp"
            static let answeredField = "answered"
            static let starredField = "starred"
        }
        
        struct Post {
            static let collectionName = "posts"
            static let userIdField = "user_id"
            static let titleField = "title"
            static let textField = "text"
            static let imageRefField = "imageRef"
            static let timestampField = "timestamp"
            static let gradeField = "grade"
            static let subjectField = "subject"
            static let viewCountField = "viewCount"
            static let answerCountField = "answerCount"
            static let imageCountField = "imageCount"
        }
        
        struct Answer {
            static let collectionName = "answers"
            static let userIdField = "user_id"
            static let postIdField = "post_id"
            static let timestampField = "timestamp"
            static let textField = "text"
            static let imageRefField = "imageRef"
            static let voteField = "vote"
            static let starredField = "starred"
        }
    }
}
