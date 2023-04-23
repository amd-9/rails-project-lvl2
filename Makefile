setup:
	bin/setup

start:
	bin/rails s -p 3000 -b "0.0.0.0"

start-railway:
	bin/rails db:migrate
	bin/rails s -p 3000 -b "0.0.0.0"

install:
	bundle install

console:
	bin/rails console

test:
	bin/rails test

lint:
	rubocop

lint-fix:
	rubocop --auto-correct

.PHONY: test