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

app.logs:
	@ssh maracuja "docker logs -f maracuja"

create.network:
	ssh maracuja docker network create maracuja

run.app:
	@cat iac/docker/maracuja | ssh maracuja "set -x && cat - | bash"

run.postgres:
	@cat iac/docker/postgres | ssh maracuja "set -x && cat - | bash"

run.redis:
	@cat iac/docker/redis | ssh maracuja "set -x && cat - | bash"

run.sidekiq:
	@cat iac/docker/sidekiq | ssh maracuja "set -x && cat - | bash"

run.sidekiq-web:
	@cat iac/docker/sidekiq-web | ssh maracuja "set -x && cat - | bash"
