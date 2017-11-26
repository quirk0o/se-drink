import React from 'react'
import PropTypes from 'prop-types'
import Question from './question'
import {Question as QuestionType} from '../question'
import {Redirect, Route, withRouter} from 'react-router-dom'

const QuestionPage = ({questions, history}) => [
  ...questions.map((question, idx) => (
      <Route
        key={question.id}
        path={`/${question.slug}`}
        render={() => (
          <Question
            question={question}
            onAnswer={() => history.push(`/${questions[idx + 1] ? questions[idx + 1].slug : 'answer'}`)}
          />)}
      />
    )),

    <Route key="root" exact path="/" render={() => <Redirect to={questions[0].slug} />} />
]

QuestionPage.propTypes = {
  questions: PropTypes.arrayOf(QuestionType).isRequired
}

export default withRouter(QuestionPage)
