run() {
    (
        shopt -s dotglob
        cp -r "$scriptdir/python/common"/* "$targetdir"/
        cp -r "$scriptdir/python/django"/* "$targetdir"/
        cd "$targetdir"
        ./scripts/setup.sh
        ./pip.sh install django
        ./scripts/gen-requirements.sh
        (
            set +u
            . ./virtualenv.sh
            django-admin startproject "$targetdir"
        )
        mv -v "$targetdir" "$targetdir.tmp"
        mv -v "$targetdir.tmp"/* .
        rmdir "$targetdir.tmp"
        ./manage.sh migrate
        echo_createsuperuser | ./manage.sh shell
    )
}

echo_createsuperuser() {
    cat << EOF
from django.contrib.auth.models import User
User.objects.filter(email='admin@example.com').delete()
User.objects.create_superuser('admin', 'admin@example.com', 'admin')
EOF
}
