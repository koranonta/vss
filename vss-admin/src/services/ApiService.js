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
const deleteUser                 = (id)   => api.delete(`/users.php?id=${id}`)

const getAddresses               = ()     => api.get(`/addresses.php`)
const addAddress                 = (body) => api.post(`/addresses.php`, JSON.stringify(body))
const deleteAddress              = (id)   => api.delete(`/addresses.php?id=${id}`)

const getDeductionRules          = ()     =>  api.get(`/deductionrules.php`)     
const getPropertiesByGroup       = (id)   =>  api.get(`/propertytypes.php?id=${id}`)    

const getPayrollRunByDate        = (date) => api.get(`/payrollruns.php?runDate=${date}`)
const addPayrollTransaction      = (body) => api.post(`/payrolltransactions.php`, JSON.stringify(body))
const addPayrollTransactionItem  = (body) => api.post(`/payrolltransactionitems.php`, JSON.stringify(body))
const getPayrollTransactionItems = (id)   => api.get(`/payrolltransactionitems.php?runId=${id}`)

const authenticate               = (body) => api.post(`/authentication.php`, JSON.stringify(body))

const getMembers                 = ()     => api.get(`/members.php`)

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
  getPayrollRunByDate,
  addPayrollTransaction,
  addPayrollTransactionItem,
  getPayrollTransactionItems,
  authenticate,
  getMembers,
}

export default ApiService
