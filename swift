#!/usr/bin/env bash
# Shim: injects --disable-sandbox for build/test/run so they work inside a containing sandbox
case "${1-}" in
  build|test|run) exec /usr/bin/swift "$@" --disable-sandbox ;;
  *)              exec /usr/bin/swift "$@" ;;
esac
