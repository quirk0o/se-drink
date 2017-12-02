import React from 'react'

import 'style-loader!css-loader!semantic-ui-css/semantic.css'
import './app.scss'
import {QuestionPage} from '@src/question'
import {AnswerPage} from '@src/answer'
import {Page} from '@src/base/page'
import {StartPage} from '@src/start'
import {Route} from 'react-router-dom'

const App = () => (
  <Page>
    <Route exact path="/" component={StartPage} />
    <Route exact path="/q/:slug?" component={QuestionPage} />
    <Route
      path="/a"
      render={({location: {state: {answer}}}) => (
        <AnswerPage answer={answer} />
      )}
    />
  </Page>
)

export default App
