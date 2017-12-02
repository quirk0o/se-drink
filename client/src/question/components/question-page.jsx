import React from 'react'
import PropTypes from 'prop-types'
import Question from './question'
import {Question as QuestionType} from '../question'

const QuestionPage = ({question, onAnswer}) => (
  <Question question={question} onAnswer={onAnswer} />
)

QuestionPage.propTypes = {
  question: QuestionType.isRequired,
  onAnswer: PropTypes.func.isRequired
}

export default QuestionPage
