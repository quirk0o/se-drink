import React from 'react'
import {Component} from 'react'
import QuestionService from '../question.service'
import QuestionPage from './question-page'
import {Redirect} from 'react-router-dom'
import {Message} from 'semantic-ui-react'

class QuestionPageContainer extends Component {
  constructor (props) {
    super(props)

    this.state = {
      answer: null,
      error: null
    }
  }

  componentDidMount () {
    if (!this.props.location.state || !this.props.location.state.question) {
      this.consult()
    }
  }

  onAnswer = (question, answer) => {
    QuestionService.answer(question, answer)
      .then(() => {
        this.consult()
      })
      .catch((error) => {
        this.setState({error})
      })
  }

  render () {
    const {location: {state}} = this.props
    const {answer, error} = this.state

    return error
      ? <Message negative>{error.toString()}</Message>
      : (answer
          ? <Redirect to={{pathname: '/a', state: {answer}}} />
          : (state && state.question
              ? <QuestionPage question={state.question} onAnswer={this.onAnswer} />
              : null
          )
      )
  }

  consult () {
    QuestionService.consult()
      .then(response => {
        console.log(response)
        switch (response.type) {
          case 'question':
            this.props.history.push(`/q/${response.question.slug}`, {question: response.question})
            break
          case 'drink':
            this.setState({answer: response.drinkName})
            QuestionService.clear()
            break
        }
      })
      .catch((error) => {
        this.setState({error})
      })
  }
}

export default QuestionPageContainer
