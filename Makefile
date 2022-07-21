include iac/Makefile

bash:
	@docker-compose run app bash

bundle:
	@docker-compose run app bundle

up:
	@docker-compose up
