import React, { useState, useEffect } from 'react';
import * as AiIcons from 'react-icons/ai';
import PageHeader from '../../components/PageHeader'
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import Constants from '../../util/Constants';
import MemberList from './MemberList'

const Cooperation = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [members, setMembers] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10) 

  useEffect(() => {
    console.log("Members")
    const loadMembers = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading members...")

        //  Load employee list
        const resp = await ApiService.getMembers()        
        if (resp.status === Constants.K_HTTP_OK) {
          console.log(resp.data.response.data)
          setMembers(resp.data.response.data)
        }
      } catch (e) {
        setMembers([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
      setIsLoading(false)
    }

    loadMembers()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>   

  return (
    <>
    <PageHeader 
         title="สหกรณ์"
       icon={<AiIcons.AiFillSetting />}
      />
    <div className="container px-1">
        <MemberList
          data={members}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
    </div>   
    </>
  );
}

export default Cooperation;
