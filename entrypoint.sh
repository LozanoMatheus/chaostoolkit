#!/usr/bin/env bash

set -xe

function the_end {
  [[ "${REPORT^^}" == "ENABLED" ]] && generate_report
}
trap the_end EXIT

function generate_report() {
  for i in ${REPORT_FORMAT} ; do
    chaos report --export-format="${i// /}" "${JOURNAL_FILE}" "${REPORTS_PATH}/report.${i//5/}"
  done
}

[[ ! -d "${REPORTS_PATH}" ]] && mkdir -p "${REPORTS_PATH}"

cd /opt/chaostoolkit-documentation-code/tutorials/a-simple-walkthrough
cp valid-cert.pem cert.pem

python3 astre.py > /dev/null 2>&1 &
python3 sunset.py > /dev/null 2>&1 &

chaos run experiment.json
