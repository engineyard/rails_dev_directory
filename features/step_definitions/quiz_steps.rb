Given /^a quiz "([^\"]*)"$/ do |quiz_name|
  Quiz.make(:name => quiz_name)
end

Given /^the quiz "([^\"]*)" has a question "([^\"]*)" with the following answers:$/ do |quiz_name, question, answers|
  quiz = Quiz.find_by_name(quiz_name)
  Question.make(
    :quiz => quiz,
    :text => question,
    :answers_attributes => answers.hashes.map do |row|
      { :text => row['answer'].strip }
    end
  )
end

Given /^the answer "([^\"]*)" is the correct answer for question "([^\"]*)"$/ do |answer, question|
  answer = Answer.find_by_text(answer)
  Question.find_by_text(question).update_attribute(:correct_answer, answer)
end