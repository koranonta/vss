import React, {createContext, useMemo, useState} from "react"

const AppContext = createContext({})
const AppProvider = (props) => {
  const [login, setLogin]     = useState()
  const [selMenu, setSelMenu] = useState()
  const value = useMemo(() => (
     {login, setLogin, selMenu, setSelMenu}), 
     [login, setLogin, selMenu, setSelMenu])
    return (
      <AppContext.Provider value = {value}>
        {props.children}
      </AppContext.Provider>
    )
}

export {AppContext, AppProvider}
