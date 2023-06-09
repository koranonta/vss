import React from 'react'
import Popup from '../Popup'
import _ from 'lodash'

const LoadingPopup = (props) => {
  const {title, imgSrc, open, setOpen, width} = props;
  return (
    <Popup
      open={open}
      setOpenPopup={setOpen}
      title={title}
      >    
      <div>        
          <img src={imgSrc} alt={title} width={width}/>
          {_.isEmpty(title) ? (<p>{title}</p>) : ""}          
      </div>
    </Popup>  
  )
}

export default LoadingPopup
