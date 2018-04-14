#!/bin/bash

set -e

OUTPUT_DIR="${1}"

TSPEC_FILES_DIR="/system/data/ledger/benchmark/*"
if ! [ -d ${TSPEC_FILES_DIR} ]; then
    echo "${TSPEC_FILES_DIR} does not exist. tracing tests will not run"
    exit 1;
fi

# Run all tracing tests.
for tspec_file in $TSPEC_FILES_DIR; do
    # Use the name of the tspec file as the unique test ID. Strip away the
    # ".tspec" file suffix.
    benchmark_id=$(basename $tspec_file .tspec)

    # Make sure the name is not empty.
    if [ -z ${benchmark_id} ]; then
      echo "skipping tspec file with invalid name $tspec_file".
      continue
    fi

    # Run the tracing test.
    trace record --spec-file=$tspec_file \
                 --benchmark-results-file="${OUTPUT_DIR}/${benchmark_id}"
done


