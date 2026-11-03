.PHONY: test scan lint

test:
	cd src && python -m unittest test_finops_scanner.py

scan:
	python src/finops_scanner.py --inventory examples/sample-inventory.json --output examples/sample-report.json

lint:
	python -m flake8 src/

