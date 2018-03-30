# Setup:
# + create symlink 'project' pointing to the Django project root
# + create symlink to project/static from inside public
# + create tmp/restart.txt to restart passenger

# name of the Django project, and directory that contains ENV_settings.py
projectname = 'bashoneliners'
# the environment label for using the right settings file
envname = 'prod'

import sys
import os

# nececessary for using Python 3 installed locally
os.environ['LD_LIBRARY_PATH'] = os.path.join(os.environ['HOME'], 'usr', 'local', 'lib')

cwd = os.getcwd()
virtualenv_root = os.path.join(cwd, 'project', 'virtualenv')

INTERP = os.path.join(virtualenv_root, 'bin', 'python')
if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

sys.path.append(os.path.join(cwd, 'project'))
os.environ['DJANGO_SETTINGS_MODULE'] = '{}.{}_settings'.format(projectname, envname)

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()

#from paste.exceptions.errormiddleware import ErrorMiddleware
#application = ErrorMiddleware(application, debug=True)
