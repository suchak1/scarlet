#!/bin/bash

DIR_WIN="/mnt/c/Users/Krish Suchak/.tokens/"
DIR_LIN="${HOME}/.tokens/"
FILE="robinhood.pickle"

# Find most recent token on PC and update the older version
# (either on Windows or Linux)
if [[ "${DIR_WIN}${FILE}" -nt "${DIR_LIN}${FILE}" ]]; then
    cp "${DIR_WIN}${FILE}" "${DIR_LIN}"
    echo Copied Robinhood oauth token from Windows to Linux.
else
    cp "${DIR_LIN}${FILE}" "${DIR_WIN}"
    echo Copied Robinhood oauth token from Linux to Windows.
fi

# Perform tests (thus updating token if necessary)
python -m pytest -vv

# Copy Robinhood token to project dir
cp "${DIR_WIN}${FILE}" ./

# Load env vars
set -a
. ./.env
set +a

# Encrypt token
gpg --quiet --batch --yes --symmetric --cipher-algo AES256 --passphrase="${PASSWORD}" "${FILE}"

# Remove token
rm "${FILE}"
