import React from 'react'
import { Paper } from '@material-ui/core'
import { Dialog, DialogTitle, DialogContent, Typography, makeStyles } from '@material-ui/core';
import Draggable from "react-draggable";
import CloseIcon from '@material-ui/icons/Close';
import Controls from '../Controls'

const PaperComponent = (props) => {
  return (
    <Draggable
      handle="#draggable-dialog-title"
      cancel={'[class*="MuiDialogContent-root"]'}>
      <Paper {...props} />
    </Draggable>
  );
}

const useStyles = makeStyles({
  dialog: {
    position: 'absolute',
    top: 50
  }
});

const Popup = (props) => {
  const {title, children, open, setOpen, width, showCloseIcon = false} = props
  const classes = useStyles()

  return (
      <Dialog open={open}  maxWidth="md" PaperComponent={PaperComponent}>
        <DialogTitle 
          style={{ cursor: "move", width:`${width}` }} 
          id="draggable-dialog-title">
          <div style={{ display: 'flex' }}>
            <Typography variant="h6" component="div" style={{ flexGrow: 1 }}>
              {title}
            </Typography>
            {showCloseIcon &&
            <Controls.ActionButton
              onClick={() => setOpen(false)}>
              <CloseIcon />
            </Controls.ActionButton>
            }
          </div>       
        </DialogTitle>        
        <DialogContent>
          {children}
        </DialogContent>
      </Dialog>
  );
}

export default Popup