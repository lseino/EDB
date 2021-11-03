#!/bin/bash
set -euo pipefail

if [ -v DEV ]; then
    python manage.py migrate
fi

echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'admin');" | python manage.py shell
python manage.py runserver 0.0.0.0:8000