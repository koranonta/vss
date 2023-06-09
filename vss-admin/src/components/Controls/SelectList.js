import React from "react";
import TextField from "@material-ui/core/TextField";
import Autocomplete from "@material-ui/lab/Autocomplete";
import { makeStyles } from '@material-ui/core/styles';
import _ from 'lodash'

const useStyles = makeStyles((theme) => ({
  dropList: {
    fontSize: "12px", 
    padding:"0px", 
    margin:"0",
    border:"0px"
  }
  ,searchInput: {
    fontSize: "12px"
  }
}));

const SelectList = (props) => {
  const {id, label, handler, optionList, selOption, optLabel} = props
  const classes = useStyles()
  const handleTextChange = (e) => handler(e, e.target.value)
  const handleSelection = (e, value) => value === null ? null : handler(e, value)
  const optionLabel = () => _.isEmpty(selOption) ? "" : _.isString(selOption) ? selOption : selOption[optLabel]

  //console.log(optionList)
  //console.log(selOption)
  
  return (
    <Autocomplete 
      freeSolo
      id={id}
      options={optionList || []}
      getOptionLabel={option => optionLabel() }
      defaultValue={ selOption && optionList ? optionList.find(v => v[optLabel] === optionLabel()) : null } 
      onChange={handleSelection}
      renderInput={(params) => {
        params.inputProps.className = classes.searchInput
        return <TextField {...params} label={label} onChange={e =>  handleTextChange(e)} />
      }}
      renderOption={option => {
        return (<span className={classes.dropList}>  {option[optLabel]}</span>);
      }}                                    
    />
  )
}

export default SelectList
// defaultValue={ selOption ? optionList.find(v => v[optLabel] === _.isString(selOption) ? selOption : selOption[optLabel]) : null } 

/*

  console.log(_.isString(selOption) ? selOption : selOption[optLabel])
  console.log(optionList)


  optionList.forEach(item => {
    
    const sts = (item[optLabel] === (_.isString(selOption) ? selOption : selOption[optLabel])) ? "T" : "F"

    console.log(item[optLabel], sts)
  })

  const defValue = () => {
    if (!selOption) return null

    optionList.forEach(v => {
      console.log(v[optLabel])
      console.log(_.isString(selOption) ? selOption : selOption[optLabel])
    })

    //return optionList.find(v => {v[optLabel] === _.isString(selOption) ? selOption : selOption[optLabel]})
    return null
  }


  const handleSelection1 = (e, value) => {
    if (value === null) return
    handler(e, value)
  }

*/
