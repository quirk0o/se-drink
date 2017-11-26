import React from 'react'

import 'style-loader!css-loader!semantic-ui-css/semantic.css'
import './app.scss'
import QuestionPage from '../../question/components/question-page'
import AnswerPage from '../../answer/components/answer-page'
import {Page} from '@src/base/page'

export default () => (
  <Page>
    <QuestionPage questions={[
      {id: '1', text: 'Are you tired?', slug: 'tired'},
      {id: '2', text: 'Do you like fizzy drinks?', slug: 'fizzy'}
    ]} />
    <AnswerPage answer={'juice'} />
  </Page>
)
