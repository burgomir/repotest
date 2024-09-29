.PHONY: up

up:
	docker-compose --env-file .production.env up -d --build

stop:
	docker-compose --env-file .production.env stop

down:
	docker-compose --env-file .production.env down

logs:
	docker-compose logs app -f

open_db:
	docker exec -it production_database bash

seed_referals: 
	docker exec -it production_backend npm run seed:referrals

migrate: 
	docker exec -it production_backend npm run prisma:migrate:prod

