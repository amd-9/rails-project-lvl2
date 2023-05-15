setup:
	bin/setup

start:
	bin/rails s -p "3000" -b "0.0.0.0"

start-railway:
	yarn run build
	yarn run build:css
	bin/rails db:migrate
	bin/rails assets:precompile
	bin/rails s -p ${PORT} -b "0.0.0.0"

install:
	bundle install

console:
	bin/rails console

test:
	bin/rails test

lint:
	rubocop
	slim-lint app/**/*.slim

lint-fix:
	rubocop -A

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:schema:load
	bin/rails db:migrate
	bin/rails db:fixtures:load

.PHONY: test