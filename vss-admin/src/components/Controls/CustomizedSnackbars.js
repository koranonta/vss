import React from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
//  JS Library
import _ from 'lodash'

function Alert(props) {
  return <MuiAlert elevation={6} variant="filled" {...props} />;
}

export default function CustomizedSnackbars(props) {
  const {message, open, setOpen, showDuration} = props

  const handleClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpen(false);
  };

  return (
    _.isEmpty(message) ? ""
    :
    <Snackbar 
       open={open} 
       autoHideDuration={showDuration} 
       onClose={handleClose}
       anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
       >
      <Alert onClose={handleClose} severity={message.severity}>{message.text}</Alert>
    </Snackbar>
  );
}
