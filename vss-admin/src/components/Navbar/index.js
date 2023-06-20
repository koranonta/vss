import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { sideBarData } from './SidebarData';
import './Navbar.css';
import {images} from '../../util/Images';
import _ from 'lodash';
import { IconContext } from 'react-icons/lib'
import {FaBars} from 'react-icons/fa'
import { AiOutlineClose } from 'react-icons/ai'

const Navbar = () => {
  const [curMenu, setCurMenu] = useState(sideBarData[0].title)
  const [sidebar, setSidebar] = useState(false)

  const showSidebar = () => {
    setSidebar(!sidebar)
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
                       ? "" : item.title === curMenu && 'active'}>
                    <Link to={item.path} onClick={() => setCurMenu(item.title)}>
                      <span className="top_curve"></span>
                      <span className="icon"><img src={item.title === curMenu ? item.activeIcon : item.icon} 
					              width="15px" alt={item.title}/></span>
                      <span className="item">{item.title}</span>
                      <span className="bottom_curve"></span>
                    </Link>
                  </li>))
              }
	            </ul>
	          </div>
  	      </div>    
  )
}

export default Navbar


/*


      <IconContext.Provider value={{color: "#fff"}}>
        <div className="navbar">
          <Link to="#" className="menu-bars">
            <FaBars onClick={showSidebar} />  
          </Link>
          <div style={{paddingLeft:"15px", color: "white" }}>
            Satcom Global
          </div>
        </div>

        <nav className={sidebar ? "nav-menu active" : "nav-menu"}>
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
                       ? "" : item.title === curMenu && 'active'}>
                    <Link to={item.path} onClick={() => setCurMenu(item.title)}>
                      <span className="top_curve"></span>
                      <span className="icon"><img src={item.title === curMenu ? item.activeIcon : item.icon} 
					              width="15px" alt={item.title}/></span>
                      <span className="item">{item.title}</span>
                      <span className="bottom_curve"></span>
                    </Link>
                  </li>))
              }
	            </ul>
	          </div>
  	      </div>    
        </nav>
      </IconContext.Provider> 


*/