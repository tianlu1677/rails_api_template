import { application } from './application'
import FormController from './form_controller'
import PasswordController from './password_controller'

application.register('form', FormController)
application.register('password', PasswordController)
