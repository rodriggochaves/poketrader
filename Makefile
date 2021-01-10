test:
	bundle exec rspec

lint:
	bundle exec rubocop

ci: test lint
