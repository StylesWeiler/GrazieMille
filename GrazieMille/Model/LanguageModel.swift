//
//  LanguageModel.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/17/24.
//


import Foundation

protocol LessonPlan {
    var topics: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
}

struct Language {
    var topics: [Topic]
    
    struct Topic: Identifiable {
        let id: UUID
        let title: String
        let lessonText: String
        let vocabulary: [Term]
        let quiz: [QuizItem]
        
        init(title: String, id: UUID, lessonText: String, vocabulary: [Term], quiz: [QuizItem]) {
            self.id = id
            self.title = title
            self.lessonText = lessonText
            self.vocabulary = vocabulary
            self.quiz = quiz
        }
    }
    
    enum QuestionType {
        case trueFalse
        case multipleChoice
        case fillInTheBlank
    }
    
    struct QuizItem {
        var question: String
        var answers: [String]
        var correctAnswer: String
        
    }
    
    struct Term {
        let word: String
        let translation: String
    }
    
    struct Progress: Codable, Identifiable {
        let topicId: UUID
        var lessonCompleted: Bool
        var vocabStudied: Bool
        var quizPassed: Bool
        var quizHighScore: Int?
        
        var id: UUID { topicId }
        
        init(topicId: UUID) {
            self.topicId = topicId
            self.lessonCompleted = false
            self.vocabStudied = false
            self.quizPassed = false
            self.quizHighScore = nil
        }
    }
}

struct ItalianLesson: LessonPlan {
    // Read-only properties
    var progress: [Language.Progress]
    

    
    let topics: [Language.Topic] = [
        Language.Topic(
            title: "Phrases",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            /*
            TO-DO: Figure out a better approach to persistant progress.
            */
            lessonText: """
                Here are some common Italian phrases that will come in handy during conversations.
                """,
            vocabulary: [
                Language.Term(word: "Ciao", translation: "Hello/Goodbye"),
                Language.Term(word: "Arrivederci", translation: "Goodbye"),
                Language.Term(word: "Per favore", translation: "Please"),
                Language.Term(word: "Grazie", translation: "Thank you"),
                Language.Term(word: "Scusa", translation: "Excuse me"),
                Language.Term(word: "Mi dispiace", translation: "I'm sorry"),
                Language.Term(word: "Buongiorno", translation: "Good morning"),
                Language.Term(word: "Buonanotte", translation: "Good night")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Thank you'?",
                    answers: ["Scusa", "Grazie", "Ciao", "Per favore"],
                    correctAnswer: "Grazie"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Goodbye'?",
                    answers: ["Arrivederci", "Ciao", "Mi dispiace", "Buongiorno"],
                    correctAnswer: "Arrivederci"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Excuse me'?",
                    answers: ["Buonanotte", "Mi dispiace", "Scusa", "Grazie"],
                    correctAnswer: "Scusa"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Good night'?",
                    answers: ["Buonanotte", "Mi dispiace", "Scusa", "Grazie"],
                    correctAnswer: "Buonanotte"
                ),
                Language.QuizItem(
                    question: "What does 'Ciao' mean?",
                    answers: ["Excuse me", "Cat", "Hello/Goodbye", "Thank you"],
                    correctAnswer: "Hello/Goodbye"
                )
            ]
        ),
        
        Language.Topic(
            title: "Colors",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            lessonText: """
                It can be quite helpful to know some colors. Here are a few of \
                our favorites.
                """,
            vocabulary: [
                Language.Term(word: "Nero", translation: "Black"),
                Language.Term(word: "Bianco", translation: "White"),
                Language.Term(word: "Giallo", translation: "Yellow"),
                Language.Term(word: "Arancione", translation: "Orange"),
                Language.Term(word: "Azzurro", translation: "Blue"),
                Language.Term(word: "Rosso", translation: "Red"),
                Language.Term(word: "Verde", translation: "Green"),
                Language.Term(word: "Viola", translation: "Purple"),
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Black'?",
                    answers: ["Nero", "Rosso", "Arancione", "Azzurro"],
                    correctAnswer: "Nero"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Red'?",
                    answers: ["Rosso", "Viola", "Verde", "Giallo"],
                    correctAnswer: "Rosso"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Blue'?",
                    answers: ["Nero", "Rosso", "Giallo", "Azzurro"],
                    correctAnswer: "Azzurro"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Green'?",
                    answers: ["Azzurro", "Rosso", "Verde", "Nero"],
                    correctAnswer: "Verde"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Purple'?",
                    answers: ["Viola", "Rosso", "Verde", "Azzurro"],
                    correctAnswer: "Viola"
                )
            ]
        ),
        
        Language.Topic(
            title: "Numbers",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            lessonText: """
                Learn how to count in Italian! Start with these basic numbers.
                """,
            vocabulary: [
                Language.Term(word: "Uno", translation: "One"),
                Language.Term(word: "Due", translation: "Two"),
                Language.Term(word: "Tre", translation: "Three"),
                Language.Term(word: "Quattro", translation: "Four"),
                Language.Term(word: "Cinque", translation: "Five"),
                Language.Term(word: "Sei", translation: "Six"),
                Language.Term(word: "Sette", translation: "Seven"),
                Language.Term(word: "Otto", translation: "Eight"),
                Language.Term(word: "Nove", translation: "Nine"),
                Language.Term(word: "Dieci", translation: "Ten")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Four'?",
                    answers: ["Due", "Quattro", "Sette", "Cinque"],
                    correctAnswer: "Quattro"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Eight'?",
                    answers: ["Otto", "Tre", "Sei", "Nove"],
                    correctAnswer: "Otto"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Ten'?",
                    answers: ["Dieci", "Sette", "Uno", "Cinque"],
                    correctAnswer: "Dieci"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'One'?",
                    answers: ["Dieci", "Sette", "Uno", "Cinque"],
                    correctAnswer: "Uno"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Three'?",
                    answers: ["Dieci", "Sette", "Tre", "Cinque"],
                    correctAnswer: "Tre"
                )
            ]
        ),
        
       Language.Topic(
            title: "Family Members",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            lessonText: """
                Here are some Italian words for family members.
                """,
            vocabulary: [
                Language.Term(word: "Padre", translation: "Father"),
                Language.Term(word: "Madre", translation: "Mother"),
                Language.Term(word: "Fratello", translation: "Brother"),
                Language.Term(word: "Sorella", translation: "Sister"),
                Language.Term(word: "Nonno", translation: "Grandfather"),
                Language.Term(word: "Nonna", translation: "Grandmother"),
                Language.Term(word: "Figlio", translation: "Son"),
                Language.Term(word: "Figlia", translation: "Daughter")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Sister'?",
                    answers: ["Madre", "Sorella", "Fratello", "Nonna"],
                    correctAnswer: "Sorella"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Father'?",
                    answers: ["Padre", "Fratello", "Nonno", "Figlio"],
                    correctAnswer: "Padre"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Grandfather'?",
                    answers: ["Nonno", "Padre", "Figlio", "Fratello"],
                    correctAnswer: "Nonno"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Grandmother'?",
                    answers: ["Nonna", "Padre", "Figlio", "Fratello"],
                    correctAnswer: "Nonna"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Son'?",
                    answers: ["Nonno", "Padre", "Figlio", "Fratello"],
                    correctAnswer: "Figlio"
                )
            ]
        ),
        
        Language.Topic(
            title: "Animals",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            lessonText: """
                Learn the names of common animals in Italian.
                """,
            vocabulary: [
                Language.Term(word: "Cane", translation: "Dog"),
                Language.Term(word: "Gatto", translation: "Cat"),
                Language.Term(word: "Uccello", translation: "Bird"),
                Language.Term(word: "Cavallo", translation: "Horse"),
                Language.Term(word: "Mucca", translation: "Cow"),
                Language.Term(word: "Pecora", translation: "Sheep"),
                Language.Term(word: "Pesce", translation: "Fish"),
                Language.Term(word: "Topo", translation: "Mouse")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Dog'?",
                    answers: ["Cane", "Gatto", "Cavallo", "Uccello"],
                    correctAnswer: "Cane"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Cat'?",
                    answers: ["Mucca", "Pecora", "Gatto", "Topo"],
                    correctAnswer: "Gatto"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Horse'?",
                    answers: ["Gatto", "Cavallo", "Topo", "Cane"],
                    correctAnswer: "Cavallo"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Mouse'?",
                    answers: ["Pesce", "Cavallo", "Topo", "Cane"],
                    correctAnswer: "Topo"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Sheep'?",
                    answers: ["Pesce", "Cavallo", "Topo", "Pecora"],
                    correctAnswer: "Pecora"
                )
            ]
        ),
        
        Language.Topic(
            title: "Food and Drink",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            lessonText: """
                Learn how to talk about food and drink in Italian!
                """,
            vocabulary: [
                Language.Term(word: "Pane", translation: "Bread"),
                Language.Term(word: "Acqua", translation: "Water"),
                Language.Term(word: "Latte", translation: "Milk"),
                Language.Term(word: "Caffè", translation: "Coffee"),
                Language.Term(word: "Vino", translation: "Wine"),
                Language.Term(word: "Formaggio", translation: "Cheese"),
                Language.Term(word: "Mela", translation: "Apple"),
                Language.Term(word: "Pasta", translation: "Pasta")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Water'?",
                    answers: ["Pane", "Latte", "Acqua", "Vino"],
                    correctAnswer: "Acqua"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Bread'?",
                    answers: ["Pasta", "Pane", "Formaggio", "Mela"],
                    correctAnswer: "Pane"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Wine'?",
                    answers: ["Latte", "Vino", "Caffè", "Acqua"],
                    correctAnswer: "Vino"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Pasta'?",
                    answers: ["Pasta", "Vino", "Caffè", "Acqua"],
                    correctAnswer: "Pasta"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Apple'?",
                    answers: ["Latte", "Vino", "Mela", "Acqua"],
                    correctAnswer: "Mela"
                )
            ]
        ),
        
        Language.Topic(
            title: "Week Days",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
            lessonText: """
                Here are the days of the week in Italian.
                """,
            vocabulary: [
                Language.Term(word: "Lunedì", translation: "Monday"),
                Language.Term(word: "Martedì", translation: "Tuesday"),
                Language.Term(word: "Mercoledì", translation: "Wednesday"),
                Language.Term(word: "Giovedì", translation: "Thursday"),
                Language.Term(word: "Venerdì", translation: "Friday"),
                Language.Term(word: "Sabato", translation: "Saturday"),
                Language.Term(word: "Domenica", translation: "Sunday")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Monday'?",
                    answers: ["Martedì", "Lunedì", "Sabato", "Giovedì"],
                    correctAnswer: "Lunedì"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Wednesday'?",
                    answers: ["Martedì", "Domenica", "Mercoledì", "Giovedì"],
                    correctAnswer: "Mercoledì"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Sunday'?",
                    answers: ["Domenica", "Sabato", "Martedì", "Venerdì"],
                    correctAnswer: "Domenica"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Tuesday'?",
                    answers: ["Domenica", "Sabato", "Martedì", "Venerdì"],
                    correctAnswer: "Martedì"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Thursday'?",
                    answers: ["Domenica", "Sabato", "Martedì", "Venerdì"],
                    correctAnswer: "Giovedì"
                )
            ]
        ),

        Language.Topic(
            title: "Weather",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000008")!,
            lessonText: """
                Learn how to talk about the weather in Italian.
                """,
            vocabulary: [
                Language.Term(word: "Sole", translation: "Sun"),
                Language.Term(word: "Pioggia", translation: "Rain"),
                Language.Term(word: "Neve", translation: "Snow"),
                Language.Term(word: "Vento", translation: "Wind"),
                Language.Term(word: "Nuvola", translation: "Cloud"),
                Language.Term(word: "Temporale", translation: "Storm"),
                Language.Term(word: "Caldo", translation: "Hot"),
                Language.Term(word: "Freddo", translation: "Cold")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Rain'?",
                    answers: ["Sole", "Neve", "Pioggia", "Vento"],
                    correctAnswer: "Pioggia"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Snow'?",
                    answers: ["Nuvola", "Neve", "Caldo", "Pioggia"],
                    correctAnswer: "Neve"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Hot'?",
                    answers: ["Caldo", "Freddo", "Nuvola", "Sole"],
                    correctAnswer: "Caldo"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Storm'?",
                    answers: ["Temporale", "Freddo", "Nuvola", "Sole"],
                    correctAnswer: "Temporale"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Sun'?",
                    answers: ["Caldo", "Freddo", "Nuvola", "Sole"],
                    correctAnswer: "Sole"
                )
            ]
        ),
        
        Language.Topic(
            title: "Religion",
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000009")!,
            lessonText: """
                Here are some common Church of Jesus Christ terms in Italian.
                """,
            vocabulary: [
                Language.Term(word: "Chiesa", translation: "Church"),
                Language.Term(word: "Vescovo", translation: "Bishop"),
                Language.Term(word: "Sacramento", translation: "Sacrament"),
                Language.Term(word: "Tempio", translation: "Temple"),
                Language.Term(word: "Profeta", translation: "Prophet"),
                Language.Term(word: "Scritture", translation: "Scriptures"),
                Language.Term(word: "Battesimo", translation: "Baptism"),
                Language.Term(word: "Preghiera", translation: "Prayer")
            ],
            quiz: [
                Language.QuizItem(
                    question: "What is the Italian word for 'Church'?",
                    answers: ["Tempio", "Sacramento", "Chiesa", "Vescovo"],
                    correctAnswer: "Chiesa"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Bishop'?",
                    answers: ["Vescovo", "Profeta", "Scritture", "Battesimo"],
                    correctAnswer: "Vescovo"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Prayer'?",
                    answers: ["Preghiera", "Battesimo", "Tempio", "Sacramento"],
                    correctAnswer: "Preghiera"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Baptism'?",
                    answers: ["Preghiera", "Battesimo", "Tempio", "Sacramento"],
                    correctAnswer: "Battesimo"
                ),
                Language.QuizItem(
                    question: "What is the Italian word for 'Sacrament'?",
                    answers: ["Preghiera", "Battesimo", "Tempio", "Sacramento"],
                    correctAnswer: "Sacramento"
                )
            ]
        )
        
    ]
    
    init() {
        self.progress = topics.map { Language.Progress(topicId: $0.id) }
    }
    
    // Model methods to get progress
    func getProgress(for topicId: UUID) -> Language.Progress? {
        return progress.first { $0.topicId == topicId }
    }
    
}





