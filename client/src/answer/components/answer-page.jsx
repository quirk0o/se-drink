import React from 'react'
import PropTypes from 'prop-types'

import Answer from './answer'
import {Route} from 'react-router-dom'

const AnswerPage = ({answer}) => (
  <Route path="/answer" render={() => (
    <Answer answer={answer} />
  )} />
)

AnswerPage.propTypes = {
  answer: PropTypes.string.isRequired
}

export default AnswerPage
