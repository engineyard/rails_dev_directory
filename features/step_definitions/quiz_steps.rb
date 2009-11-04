Given /^a quiz "([^\"]*)"$/ do |quiz_name|
  Quiz.make(:name => quiz_name)
end

Given /^the quiz "([^\"]*)" has a question "([^\"]*)" with the following answers:$/ do |quiz_name, question, answers|
  quiz = Quiz.find_by_name(quiz_name)
  Question.make(
    :quiz => quiz,
    :text => question,
    :answers_attributes => answers.hashes.map do |row|
      { :text => row['answer'], :correct => (row['correct'].not.blank?) }
    end
  )
end
