import React, { useState, useContext, useEffect } from 'react';
import { Link } from 'react-router-dom';
import {useNavigate} from "react-router-dom"
import { sideBarData } from './SidebarData';
import './Navbar.css';
import {images} from '../../util/Images';
import _ from 'lodash';
import { AppContext } from '../../context/AppContext';
import AppConfig from '../../config/AppConfig';
import Header from '../Header';
import Util from '../../util/Util';
const Navbar = () => {
  //const [curMenu, setCurMenu] = useState(sideBarData[0].title)
  const [sidebar, setSidebar] = useState(false)

  const { selMenu, setSelMenu, login, setLogin } = useContext(AppContext)
  const navigate = useNavigate();

  useEffect(() => {
    setSelMenu(sideBarData[0].title)
  },[])

  const showSidebar = () => {
    setSidebar(!sidebar)
  }  

  const logout = () => {
    setLogin({})
    setSelMenu(sideBarData[0].title)
    navigate("/")
  }

  return (
          <div className="side_bar">
	          <div className="side_bar_top">
	            <div className="profile_pic">
		            <img src={images.logo} width="100px"/>
		          </div>
	          </div>
	          <div className="side_bar_bottom">
	            <ul> 
		          {
                sideBarData.map((item, index) => (
                  <li key={index} 
                    className={ _.isEmpty(item.title) 
                       ? "" : item.title === selMenu && 'active'}>
                    <Link to={item.path} onClick={() => setSelMenu(item.title)}>
                      <span className="top_curve"></span>
                      <span className="icon"><img src={item.title === selMenu ? item.activeIcon : item.icon} 
					              width="15px" alt={item.title}/></span>
                      <span className="item">{item.title}</span>
                      <span className="bottom_curve"></span>
                    </Link>
                  </li>))
              }
	            </ul>
              <br/>
              <br/>
              <div className="container">
                <div className="team-profile">
                { _.isEmpty(login) ? "" : 
                <>
                  <img src={ AppConfig.K_AVATAR_DIR + (Util.hasImage(login.image) ?`${login.image}` : 'no-image.png')} width="40" style={{borderRadius: '40px'}}/>
                <div className="team-name">
                   {login.name}                  
                </div>

                &nbsp;&nbsp;
                <a href="#" onClick={e => logout()}>Logout</a>
                </>
                }
                </div>
              </div>
	          </div>
            
  	      </div>    
    )
  }

export default Navbar
