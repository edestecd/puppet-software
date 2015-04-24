# init.pp
# Main class of software
#
#
# Install Generic Software on OS X
# Organized into individual packages and groups.
# Most of these are Graphical apps that require little/no configuration.
# They are just simple Download and place apps.
#
#

class software (
  $applications_path     = $software::params::applications_path,
  $preference_panes_path = $software::params::preference_panes_path,
  $utilities_path        = $software::params::utilities_path,
) inherits software::params {

  # Not Used
  fail("The ${module_name} module does not use the ${name} class.
  Just include the software or group classes you want like this:
  include software::browsers::chrome (just chrome) include software::browsers (all browsers in group)")

}
