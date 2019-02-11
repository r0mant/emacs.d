#!/bin/bash
cd "$MAILGUN_HOME/website" && paster serve development.ini --reload
