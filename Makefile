test:
	bin/rails test $(CURDIR)/test	
	
install:
	bundle install

console:
	bin/rails console

start:
	bin/rails s -p 3000 -b "0.0.0.0"

deploy:
	git push heroku main

lint:
	rubocop

lint-fix:
	rubocop --auto-correct

.PHONY: test
