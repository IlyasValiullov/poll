# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(email: "a", password: "1111") 
poll =  Poll.create(title: "City poll", author: user) 
question = PollQuestion.create(poll: poll, question: "Will destroy your building?")
answer_yes = PollQuestionAnswer.create(question: question, answer: "Yes")
answer_no = PollQuestionAnswer.create(question: question, answer: "No")

question2 = PollQuestion.create(poll: poll, question: "Where do you want to live?")
answer1 = PollQuestionAnswer.create(question: question2, answer: "City")
answer2 = PollQuestionAnswer.create(question: question2, answer: "Country")
answer3 = PollQuestionAnswer.create(question: question2, answer: "Don't know")



user2 = User.create(email: "b", password: "1111") 
user3 = User.create(email: "c", password: "1111") 
user4 = User.create(email: "d", password: "1111") 

result = PollResult.create(user: user2, 
   												poll: poll,
   												question: question,
   												answer: answer_yes)

result = PollResult.create(user: user2, 
   												poll: poll,
   												question: question2,
   												answer: answer1)

result = PollResult.create(user: user3, 
   												poll: poll,
   												question: question,
   												answer: answer_yes)

result = PollResult.create(user: user3, 
   												poll: poll,
   												question: question2,
   												answer: answer1)

result = PollResult.create(user: user4, 
   												poll: poll,
   												question: question,
   												answer: answer_no)

result = PollResult.create(user: user4, 
   												poll: poll,
   												question: question2,
   												answer: answer3)