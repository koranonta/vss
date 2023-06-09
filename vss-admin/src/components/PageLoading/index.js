import React from 'react'
import { makeStyles } from '@material-ui/core'
import spinner from './spinner.gif'

const useStyles = makeStyles(theme => ({
  container: {
    height:   '300px',
    position: 'relative'    
  },
  verticalCenter : {
    position: 'absolute',
    width: '300px',
    height: '200px',
    zIndex: 15,
    top: '50%',
    left: '50%',
    margin: '-100px 0 0 -150px',
    textAlign: 'center'
  },  
}))

const PageLoading = (props) => {
  const {title} = props;
  const classes = useStyles()
  return (
      <div className={classes.container}>
        <div className={classes.verticalCenter}>
          <img src={spinner} alt={title}  height="200px"/>
          <p>{title}</p>
        </div>
      </div>
  )
}

export default PageLoading
