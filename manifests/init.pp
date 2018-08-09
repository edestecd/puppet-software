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
) inherits software::params {

  # Not Used
  fail("The ${module_name} module does not use the ${name} class. Just include the software or group classes you want.")
}
