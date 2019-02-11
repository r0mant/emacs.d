#!/bin/bash

PROJECTS="jobs reputation analytics arsenal turret api mgcore website mgcounter watchdog billing bunker"

# Verify env
if [ -z "$MAILGUN_HOME" ]; then
    echo "Environment variable MAILGUN_HOME is not set"
fi

# Run current test if CURRENT_BUFFER env var is set
if [ -n "${CURRENT_BUFFER+x}" ]; then
    if [ -n "$CURRENT_BUFFER" ]; then
        # Determine current project
        CURRENT_PROJECT=""
        for project in $PROJECTS; do
            if [[ "$CURRENT_BUFFER" = *$project* ]]; then
                CURRENT_PROJECT=$project
                break
            fi
        done

        if [[ "$CURRENT_PROJECT" = "$CURRENT_BUFFER" ]]; then
            echo "Running tests for $CURRENT_PROJECT"
            cd "$MAILGUN_HOME/$project" && python setup.py develop > /dev/null && nosetests
        elif [ -n "$CURRENT_PROJECT" ]; then
            echo "Running tests from $CURRENT_BUFFER"
            cd "$MAILGUN_HOME/$project" && nosetests $CURRENT_BUFFER
        else
            echo "Don't know how to run test - unknown project"
        fi
        exit 0
    fi
fi

# Otherwise run all tests
for project in $PROJECTS; do
    echo "Running tests from $project"
    cd "$MAILGUN_HOME/$project" && python setup.py develop > /dev/null && nosetests
    echo "-"
    echo ""
done
