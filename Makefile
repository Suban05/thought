start:
	rm -rf tmp/pids/server.pid
	bin/rails s

install:
	bin/setup

check: test lint

test:
	bin/rails test

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop -A

.PHONY: test