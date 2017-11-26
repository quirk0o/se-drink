import React from 'react'
import PropTypes from 'prop-types'

import styles from './answer.scss'

const Answer = ({answer}) => (
  <p className={styles.answer}>Your drink is <em className={styles.drink}>{answer}</em>.</p>
)

Answer.propTypes = {
  answer: PropTypes.string.isRequired
}

export default Answer
