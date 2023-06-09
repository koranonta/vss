import React from 'react';
import * as AiIcons from 'react-icons/ai';
import PageHeader from '../../components/PageHeader'

const Settings = () => {
  return (
    <>
    <PageHeader 
         title="Application Settings Management"
       icon={<AiIcons.AiFillSetting />}
      />
    <div className="container px-1">
        Settings UI
    </div>  
    </>
  );
}

export default Settings;