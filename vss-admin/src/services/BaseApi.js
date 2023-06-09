import axios from "axios"
import AppConfig from '../config/AppConfig'
const vssApi = axios.create({
  baseURL: AppConfig.K_API_URL,
  headers: {
    "Content-type" : "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": 'Content-Type, Authorization',
    "Accept": "application/json",
  }
})

vssApi.interceptors.response.use(
  (response) => response,
  (error) => {    
    if(error.response === undefined) {
      console.log(error)
      return Promise.reject(error);
    }
    else {
      switch (error.response.status) {
        case 400:
        case 404:
          return {
            data: null
           ,hasError: true
           ,error: [error.response.data]
          }        
          //break;
        case 401:
          // Handle Unauthorized calls here
          // Display an alert
          break
        case 500:
          // Handle 500 here
          // redirect
          break
        // and so on..
        default:
          break
      }
    }
    return Promise.reject(error);
  }
)

const BaseApi = {
  vssApi,
}

export default BaseApi

