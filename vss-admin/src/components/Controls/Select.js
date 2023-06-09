import React from 'react'
import { FormControl, InputLabel, Select as MuiSelect, MenuItem, FormHelperText } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({
    root: {
        fontSize: "12px", 
        padding:"0px", 
        marginLeft:"15px"
      }  
    ,searchInput: {
       fontSize: "12px"
    }
}));

export default function Select(props) {
  const { name, label, value,error=null, onChange, options, widthPct, mandatory=false, readOnly=false} = props;
  //console.log(minWidth)
  const classes = useStyles()
  //console.log(mandatory)
  //console.log(value)

  return (
     <FormControl variant="standard" style={widthPct === undefined ? {width: 130} : {width: widthPct} }
        {...(error && {error:true})}>
            <InputLabel>{label}</InputLabel>
            <MuiSelect
                label={label}
                name={name}
                value={value || ""}
                onChange={onChange}
                disabled={readOnly}
                className={classes.searchInput}>
                {mandatory === false ? <MenuItem value="" className={classes.root}>None</MenuItem> : ""}
                { 
                    options.map(
                        item => (<MenuItem key={item.id} value={item.id} className={classes.root}>{item.title}</MenuItem>)
                    )
                }
            </MuiSelect>
            {error && <FormHelperText>{error}</FormHelperText>}
     </FormControl>
    )
}


/*
 item => (<MenuItem key={item.id} value={item.id} style={{fontSize: "15px", padding:"0px", marginLeft:"15px"}}>{item.title}</MenuItem>)

*/