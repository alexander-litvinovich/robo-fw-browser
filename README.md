# Robot Framework Browser Example

To install dependencies:

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
rfbrowser init
```

To run all tests:

```bash
robot --outputdir results tests/
```

To run separate tests:

```bash
robot tests/litvinovich_website_test.robot
robot tests/sign_in_test.robot
```
