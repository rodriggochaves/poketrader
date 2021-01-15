test:
	bundle exec rspec

lint:
	bundle exec rubocop

test-js:
	yarn test --ci

ci: test lint test-js
