#!/bin/bash
# @file: entrypoint.sh
# @brief: source the Python virtual environment
# @note: this is script is expected to be run by the non-root user

# Source the Python virtual environment
source "$HOME/.venv/bin/activate"

# Start the application or command you wish to run
exec "$@"
