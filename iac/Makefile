terraform.init:
	@terraform -chdir=iac/terraform init

terraform.apply:
	@terraform -chdir=iac/terraform apply

terraform.instance-ip:
	@terraform -chdir=iac/terraform output -raw maracuja_public_ip

docker.setup:
	@cat iac/docker/setup | ssh maracuja "set -x && cat - | bash"

app.release:
	@docker build -t maracuja --target release .

app.deploy:
	@docker save maracuja | ssh -C maracuja docker load

app.stop:
	@ssh maracuja "docker stop maracuja"

app.start:
	@ssh maracuja "docker run -p 3000:3000 --name maracuja --rm -d maracuja"

app.restart:
	@make app.stop
	@make app.start

app.logs:
	@ssh maracuja "docker logs -f maracuja"
