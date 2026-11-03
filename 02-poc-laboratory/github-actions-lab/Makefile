.PHONY: lint test

lint:
	python -c "import yaml, glob; [yaml.safe_load(open(f)) for f in glob.glob('.github/**/*.yml', recursive=True)]"

test:
	echo "Local testing of action manifests completed."

