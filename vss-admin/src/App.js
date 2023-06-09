import React from 'react';
import './App.css';
import Navbar from './components/Navbar';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Employees from './pages/Employees';
import Payroll from './pages/Payroll';
import Users from './pages/Users';
import { Dashboard } from '@material-ui/icons';
//  Fonts
import './assets/fonts/DIN_Alternate_Bold.ttf'
import './assets/fonts/Hero_Light.otf'
import './assets/fonts/Hero.otf'

function App() {
  return (
      <BrowserRouter basename="/app/vss/admin">
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
      </BrowserRouter>
  );
}

export default App;


/*

          <Route path='/products' element={<Products/>} />
          <Route path='/users' element={<Users/>} />
          <Route path='/orders' element={<Orders/>} />
          <Route path='/video' element={<Video/>} />
          <Route path='/notifications' element={<Notifications/>} />
          <Route path='/settings' element={<Settings/>} />
          <Route path='/uitesting' element={<UiTesting/>} />

*/          