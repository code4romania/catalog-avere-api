# avere
A Django site.

## Development
Development is done in a Vagrant-managed VM. This ensures compatibility with
production. To setup your environment:
- install VirtualBox
- install Vagrant
- install Ansible and passlib:

        pip install ansible passlib

- install the Ansible roles:

        ansible-galaxy install ansible/roles/external.yml

Now you can run:
- `vagrant up` to create the VM and install everything
- `vagrant ssh` to log into the VM
- `./dj_server` to start the Django development server

That's it. Access the site at `http://localhost:8000`.

As an additional step, after you create the hosted repo, set its URL as the
value of `site_repo_url` variable in `ansible/group_vars/all.yml`.

### Useful Vagrant commands
- `vagrant up`: create a VM or start an existing one
- `vagrant provision`: run the Ansible code to provision the VM
- `vagrant suspend`: save the state of the VM and stop it.

For other Vagrant commands, `vagrant help` in the terminal.

## Deployment
By default, there are two deployment targets: staging and production. Start
by adding your host to each target's inventory file. You find that in
`ansible/inventory`. If this is the first deployment, you prepare the remote
host by running:

    ansible-playbook ansible/secure.yml -kK -u <user>

`<user>` should have superuser rights on the target machine.

Before you run the next command, you should set a value for
`nginx_server_name` in `ansible/group_vars/staging.yml` and
`ansible/group_vars/production.yml` respectively.

Now you can deploy by running:

    ansible-playbook ansible/staging.yml -K

For production, there is a corresponding playbook called `production.yml`.


## Workflows
- initial setup
- deployment
- server securing

When you start your day, you run `vagrant up`. If it's the first time, you're
working on the project, the command above will create the VM and installing
everything by running the Ansible code.

When that finishes, you log into the VM by running `vagrant ssh`. Then you
`cd /vagrant` and start the Django server by running `./dj_server`. You can
look at that script to see what it does. It points directly to the
virtualenv, so you don't have to activate it manually.

When you finish your work, you run `vagrant suspend` on your host OS. That
will stop the machine and save the state of every running process. That means
that when you run `vagrant up` again, the Django server will be running. If
you don't want that, you can run `vagrant halt` instead of `vagrant suspend`.

If you make changes to something other than the Django code, you have to run
`vagrant provision` to get the changes on the VM. That includes things like
changes to server configuration or adding a new Ansible role.

## Components
### Vagrant
The `Vagrantfile` tells Vagrant how to create the VM and what to do with it.
You can specify the hostname, the type of network, what ports to forward from
host to guest and what resources to allocate to the VM.

#### Deployment Path
The `Vagrantfile` also tells Vagrant to map the dir of the project from the
host to the path `/var/www/<project>` on the guest. It does that, because
Ansible deploys in production to the same path. So, if you change the
variable `site_deployment_path` in your Ansible setup, you should change
`config.vm.synced_folder` to point to the same path.

#### SSH Key
Vagrant also uses your private key to be able to access the repo of your
project through the `git` protocol. It does that with the second line of
`config.ssh.private_key_path`.

#### Provisioning
Vagrant also handles the Ansible 'development' group in the
`config.vm.provision` section. This saves you from specifying the IP of the VM
in `ansible/inventory/development`. Thus, if the IP changes, it will be
available automatically to Ansible.


### Ansible
To understand the layout of the `ansible` directory, read the [Ansible Best
Practices](http://docs.ansible.com/ansible/playbooks_best_practices.html) guide.

The Ansible setup installs Python-specific libraries or more general ones
needed by Python packages (like the imaging libraries). It also creates a
directory for all virtualenvs.

Then it installs PostgreSQL, nginx, memcached, and uwsgi. It also installs
configuration files for each technology. It makes sure that the technologies
that are meant to talk to each other are configured to do so.

For example, nginx talks to uwsgi through a unix domain socket. The nginx
virtual host is configured to point to the uwsgi domain socket serving the
Django site. The nginx virtual host also knows where the static files and the
error templates are.

The Django site is configured to access the PostgreSQL database and memcached.

The Ansible setup does this through variables. For example, if you look in
`ansible/group_vars/production.yml`, you'll see that `nginx_static_path` is
defined using variables provided by the `django-site` role. If you look in
`ansible/group_vars/all.yml`, you'll see that the PostgreSQL database and
user have the same name as the project.

Ansible variables drive the entire project. They connect the different roles,
so the difference pieces of technology are configured to talk to each other.

When you want to learn more about a variable, you should start with the role
to which it belongs. Look at its description, then look in the `defaults` to
see if it has a default value. Then look in the `group_vars` files to see if
they provide a different value.
