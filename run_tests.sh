#!/bin/bash

# Install dependencies
pip install -r requirements.txt

# Initialize browsers for robotframework-browser
rfbrowser init

# Run the tests
robot --outputdir results tests/

echo "Test execution completed. Check results/ directory for reports."
