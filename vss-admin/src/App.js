import React, { useContext } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import _ from 'lodash'
import Employees from './pages/Employees';
import Payroll from './pages/Payroll';
import Users from './pages/Users';
import Dashboard from './pages/Dashboard';
import Settings from './pages/Settings'
import Login from './pages/Login'
import { AppContext } from './context/AppContext';

//  Fonts
import './assets/fonts/DIN_Alternate_Bold.ttf'
import './assets/fonts/Hero_Light.otf'
import './assets/fonts/Hero.otf'

function App() {
  const { login } = useContext(AppContext)
  return (
      <BrowserRouter basename="/payroll/admin">
      <div className="wrapper">
        <Navbar />
        <div className="main_container">
          <Routes>
            <Route path='/'          exact element={
              _.isEmpty(login) ? <Login/> : <Dashboard/>
            } />
            <Route path='/employees' element={<Employees/>} />
            <Route path='/payroll'   element={<Payroll/>} />
            <Route path='/users'      element={<Users/>} />
            <Route path='/settings'    element={<Settings/>} />
          </Routes>
        </div>
      </div>
      </BrowserRouter>
  );
}

export default App;
