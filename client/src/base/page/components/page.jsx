import React from 'react'
import {Grid, Header} from 'semantic-ui-react'

import styles from './page.scss'

const Page = ({children}) => (
  <div className={styles.page}>
    <Grid className={styles.grid} textAlign="center" verticalAlign="middle">
      <Grid.Column className={styles.column}>
        <Header as="h1" className={styles.header}>What should I drink?</Header>

        {children}

      </Grid.Column>
    </Grid>
  </div>
)

export default Page
