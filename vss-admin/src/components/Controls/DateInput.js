import React from 'react'
import { TextField } from '@material-ui/core';

export default function DateInput(props) {

    const { name, label, value,error=null, onChange, ...other } = props;
    return (
        <TextField
            variant="outlined"
            label={label}
            name={name}
            value={value}
            onChange={onChange}
            type="date"
            {...other}
            {...(error && {error:true,helperText:error})}
        />
    )
}
