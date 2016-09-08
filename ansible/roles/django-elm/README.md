# django-site
- Installs Django BASH completion
- Creates a user for the app
- Adds the user's group to the groups of www-data user
- Clones the project to a build dir and makes the app user the owner
- Installs an `.env` file
- Installs Python dependencies
- Runs `migrate` and `collectstatic`
- Copies the site to the deployment path
- Deletes the build dir


# Role Variables

## Required Variables

| Variable | Description |
|----------|-------------|
|`site_dir_name`| Name of the dir that stores the code. E.g. "alphago" |
|`site_repo_url`| URL of the site repository. E.g. "git@bitbucket.org:google/alphago.git" |

## Optional Variables

| Variable | Description | Default value |
|----------|-------------|---------------|
|`site_app_user`| User running the app | `{{ site_dir_name }}` |
|`site_app_group`| Group of the user running the app | `{{ site_app_user }}` |

|`site_django_settings`| Django settings module | `{{ site_dir_name }}.settings` |
|`site_pip_requirements`| Path to the requirements file | `{{ site_build_path }}/requirements/{{ ENV }}.pip` |
|`site_virtualenv`| Path to virtual env used by the site | `{{ python_virtualenvs_dir }}/{{ site_dir_name }}` |

|`site_deployment_path`| Path to which we deploy the site | `/var/www/` |
|`site_build_path`| Intermediate path used to run migrations and collect static files | `/tmp/{{ site_dir_name }}` |

|`site_django_bash_completion_url`| URL of the bash completion file for Django | `https://raw.githubusercontent.com/django/django/master/extras/django_bash_completion` |
|`site_prod_env`| Flag that says whether we're deploying to production | `ENV != development` |

Dependencies
============
- [python](https://github.LucianU/ansible-python)

License
=======
BSD
