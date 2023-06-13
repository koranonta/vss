import BaseApi from "./BaseApi"
const api = BaseApi.vssApi

const getEmployees         = ()   =>  api.get(`/employees.php`)     
const getEmployeeById      = (id) =>  api.get(`/employees.php?id=${id}`) 
const addEmployee = (formData) => {
  return api.post("/employees.php", formData,
    {
      headers: { 'Content-Type': 'multipart/form-data' },
      transformRequest: formData => formData,
    })
}
const deleteEmployee           = (id) => api.delete(`/employees.php?id=${id}`)

const getUsers             = ()   =>  api.get(`/users.php`)              
const getUserById          = (id) =>  api.get(`/users.php?id=${id}`)     
const addUser = (formData) => {
  return api.post("/users.php", formData,
    {
      headers: { 'Content-Type': 'multipart/form-data' },
      transformRequest: formData => formData,
    })
}
const deleteUser           = (id)   => api.delete(`/users.php?id=${id}`)

const getAddresses         = ()     => api.get(`/addresses.php`)
const addAddress           = (body) => api.post(`/addresses.php`, body)
const deleteAddress        = (id)   => api.delete(`/addresses.php?id=${id}`)

const getDeductionRules    = ()     =>  api.get(`/deductionrules.php`)     
const getPropertiesByGroup = (id)   =>  api.get(`/propertytypes.php?id=${id}`)    



const ApiService = {
  getEmployees,
  getEmployeeById,
  addEmployee,
  deleteEmployee,
  getUsers,
  getUserById,
  addUser,
  deleteUser,
  getAddresses,
  addAddress,
  deleteAddress,
  getDeductionRules,
  getPropertiesByGroup,
}

export default ApiService
