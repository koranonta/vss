import React, { useContext } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import _ from 'lodash'
import Employees from './pages/Employees';
import Payroll from './pages/Payroll';
import Users from './pages/Users';
import Dashboard from './pages/Dashboard';
import Cooperation from './pages/Cooperation'
import Settings from './pages/Settings'
import Login from './pages/Login'
import { AppContext } from './context/AppContext';
import Header from './components/Header';

//  Fonts
import './assets/fonts/DIN_Alternate_Bold.ttf'
import './assets/fonts/Hero_Light.otf'
import './assets/fonts/Hero.otf'

import Footer from './components/Footer';


function App() {
  const { login } = useContext(AppContext)
  return (
      <BrowserRouter basename="/app/vss/admin">
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
            <Route path='/cooperation' element={<Cooperation/>} />
            <Route path='/settings'    element={<Settings/>} />
          </Routes>
        </div>
      </div>
      </BrowserRouter>
  );
}

export default App;


/*

<Route path='/'          exact element={<Dashboard/>} />


      <BrowserRouter basename="/app/vss/admin">
      <div style={{height: '40px'}}>VSS School</div>

      <div className="wrapper">
        <Navbar />
        <div className="main_container">
        <Routes>
          <Route path='/'          exact element={<Dashboard/>} />
          <Route path='/employees' element={<Employees/>} />
          <Route path='/payroll'   element={<Payroll/>} />
          <Route path='/users'     element={<Users/>} />
        </Routes>
        </div>
      </div>
      <Footer />
      </BrowserRouter>
*/

/*

          <Route path='/products' element={<Products/>} />
          <Route path='/users' element={<Users/>} />
          <Route path='/orders' element={<Orders/>} />
          <Route path='/video' element={<Video/>} />
          <Route path='/notifications' element={<Notifications/>} />
          <Route path='/settings' element={<Settings/>} />
          <Route path='/uitesting' element={<UiTesting/>} />

*/          