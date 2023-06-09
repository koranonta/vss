import BaseApi from "./BaseApi"
const api = BaseApi.vssApi

const getEmployees         = ()   => { return api.get(`/employees.php`)          }
const getEmployeeById      = (id) => { return api.get(`/employees.php?id=${id}`) }
const getDeductionRules    = ()   => { return api.get(`/deductionrules.php`)     }
const getPropertiesByGroup = (id) => { return api.get(`/propertytypes.php?id=${id}`)     }


const getUsers             = ()   => { return api.get(`/users.php`)              }
const getUserById          = (id) => { return api.get(`/users.php?id=${id}`)     }
const addUser = (formData) => {
  return api.post("/users.php", formData,
    {
      headers: { 'Content-Type': 'multipart/form-data' },
      transformRequest: formData => formData,
    })
}
const deleteUser = (id) => {
  return api.delete(`/users.php?id=${id}`)
}

const ApiService = {
  getEmployees,
  getEmployeeById,
  getDeductionRules,
  getPropertiesByGroup,
  getUsers,
  getUserById,
  addUser,
  deleteUser,
}

export default ApiService
