import React, { useState, useEffect } from "react";
import TextField from "@material-ui/core/TextField";
import Autocomplete from "@material-ui/lab/Autocomplete";
import { makeStyles } from '@material-ui/core/styles';
import SabaService from "../../services/SabaService";
//import PageLoading from '../../layout/PageLoading';
const useStyles = makeStyles((theme) => ({
  dropList: {
    fontSize: "12px", 
    padding:"0px", 
    margin:"0"
  }
  ,searchInput: {
    fontSize: "12px"
  }
}));

const SearchBox = (props) => {
    const {id, label, inpWidth, handler, url, optionList, minInpLength, initialValue, resetHandler, errorHandler} = props
    let inpLen = minInpLength
    
    if (inpLen === undefined)
      inpLen = 4

    const [, setInputValue] = useState("");
    const [options, setOptions] = useState(optionList || []);
    const [theInitialValue, setTheInitialValue] = useState(initialValue)
    //const [isLoading, setIsLoading] = useState(false)
    const classes = useStyles()

    useEffect(() => {
      
      if (resetHandler !== undefined) {
        // Take the Reference of Close Button
        const close = document.getElementsByClassName(
          "MuiAutocomplete-clearIndicator"
        )[0];
        
        // Add a Click Event Listener to the button
        close.addEventListener("click", () => {
          resetHandler()
        });
      }
      //console.log(options)
    }, [resetHandler])

    //useEffect(() => {
    //  console.log("isLoading", isLoading)
    //}, [isLoading])
    
    const handleChange = async (inpUrl, event) => {             
      if (event.target.value !== undefined && event.target.value.length < inpLen)
        return
      setInputValue(event.target.value);
      setTheInitialValue(event.target.value)

      if (inpUrl === undefined ) 
        return

      //setIsLoading(true)
      try {
        const resp = await SabaService.getUrl (`${inpUrl}/${event.target.value}`)
        console.log(resp)
        if (resp.status === 200) {
          if (resp.data.length === 0)
            errorHandler("Search data does not exist")
          else 
            setOptions(resp.data);          
        }
        else {
          console.log(resp)
        }
      }
      catch(error) {
        console.log(error);
        //setIsLoading(false)
      }
      finally {
        
      }
    };

    const handleSelection = (e, value) => {
      //console.log(e)
      //console.log("value", value)
      if (handler !== undefined && value !== null && value !== undefined) {
        handler(value, id)
      }
    }

    const getLabel = (option) => {
      if (typeof option === "string") return option
      return option.name || option.label || option.title
    }

    return (
        <>
          <Autocomplete
            id={id}
            style={{ width: inpWidth }}
            getOptionLabel={option =>
              typeof option === "string" ? option : option.name === undefined ? option.label : option.name
            }
            filterOptions={x => { return x; }}
            options={options}
            autoComplete
            includeInputInList
            freeSolo
            disableOpenOnFocus
            onChange={(e, value) => handleSelection(e, value)}

            value={theInitialValue || ""}

            renderInput={params => {
              params.inputProps.className = classes.searchInput
              return <TextField
                {...params}
                label={label}
                variant="standard"
                fullWidth
                onChange={e =>  handleChange(url, e) }
              />
            }}
            renderOption={option => {
              return (
                  <span className={classes.dropList}>  {getLabel(option)}</span>
              );
            }}
          />
          
        </>
    )
}

export default SearchBox

/*           
              //import Grid from "@material-ui/core/Grid";
              value={theInitialValue === undefined ? value : theInitialValue}
              <span style={{fontSize: "15px", padding:"0px", margin:"0"}}>  {option.name === undefined ? option.label : option.name}</span>
                <Grid container alignItems="center">
                  <Grid item xs style={{padding:"0", margin:"0"}}>
                    {option.name === undefined ? option.label : option.name}
                  </Grid>
                </Grid>

            getOptionLabel={option =>
              typeof option === "string" ? option : option.name === undefined ? option.label : option.name
            }
          {isLoading && (<PageLoading title="Loading data..."/>)}


            renderInput={params => (
              <TextField
                {...params}
                label={label}
                variant="standard"
                fullWidth
                onChange={e =>  handleChange(url, e) }
              />
            )}

*/
