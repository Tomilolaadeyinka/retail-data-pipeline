.PHONY: test lint format deploy all

test:
	pytest tests/

lint:
	flake8 your_project/

format:
	black your_project/

deploy:
	python deploy.py

all: lint format test deploy
