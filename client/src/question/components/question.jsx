import React from 'react'
import PropTypes from 'prop-types'
import {Button} from 'semantic-ui-react'
import {Question as QuestionType} from '../question'

import styles from './question.scss'

const Question = ({question, onAnswer}) => (
  <div>
    <p className={styles.question}>{question.text}</p>
    <Button.Group size="large">
      <Button negative onClick={() => onAnswer(true)} className={styles.button}>No</Button>
      <Button.Or />
      <Button positive onClick={() => onAnswer(false)} className={styles.button}>Yes</Button>
    </Button.Group>
  </div>
)

Question.propTypes = {
  question: QuestionType.isRequired,
  onAnswer: PropTypes.func.isRequired
}

export default Question
