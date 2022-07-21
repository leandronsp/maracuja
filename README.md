# Maracuja

## Requirements

* Docker
* Terraform

## Provisioning
```bash
$ make terraform.init
$ make terraform.apply
```

## SSH connfiguration

Prepare:
```bash
$ chmod 600 ~/.ssh/maracuja-key.pem
$ mkdir -p ~/.ssh/config.d/
```

Get the instance `public_ip`:
```bash
$ make terraform.instance-ip
```

Paste the following to `~/.ssh/config.d/maracuja`:
```
Host maracuja
Hostname {instance_public_ip}
User ubuntu
IdentityFile ~/.ssh/maracuja-key.pem
```

Then:
```bash
$ ssh maracuja
```

## Docker setup
```bash
$ make docker.setup
```

## Deploy
```bash
$ make app.release # builds the image
$ make app.deploy  # deploys the image to the server
$ make run.app     # runs the application
```
