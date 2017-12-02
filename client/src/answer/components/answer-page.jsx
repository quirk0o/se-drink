import React from 'react'
import PropTypes from 'prop-types'

import Answer from './answer'
import {Link} from 'react-router-dom'
import {Button} from 'semantic-ui-react'

const AnswerPage = ({answer}) => (
  <div>
    <Answer answer={answer} />
    <Link to={{pathname: '/q', state: {}}}><Button size="massive" color="teal" icon="repeat" content="Restart" /></Link>
  </div>
)

AnswerPage.propTypes = {
  answer: PropTypes.string.isRequired
}

export default AnswerPage
