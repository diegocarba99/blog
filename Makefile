# Makefile for blog project

install-dev-mac:
	@echo "Installing Hugo using Homebrew..."
	brew install hugo

deploy-local:
	@echo "Starting Hugo server locally..."
	hugo server

.PHONY: install-dev-mac deploy-local
