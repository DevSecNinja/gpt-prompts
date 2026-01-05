#!/bin/bash

# Dev container post-create setup script

set -e

echo "Installing pre-commit..."
pip install pre-commit

echo "Installing pre-commit hooks..."
pre-commit install

echo "✅ Dev container setup complete!"
