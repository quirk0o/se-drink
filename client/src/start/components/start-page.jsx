import React from 'react'
import {Link} from 'react-router-dom'
import {Button} from 'semantic-ui-react'

const StartPage = () => (
  <Link to="/q"><Button size="massive" color="teal">Let's start!</Button></Link>
)

export default StartPage
