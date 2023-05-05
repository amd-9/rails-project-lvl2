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
	slim-lint

lint-fix:
	rubocop -A

.PHONY: test