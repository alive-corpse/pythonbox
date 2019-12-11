#!/bin/sh
set -e
cd `dirname "$0"`
[ -f ".env" ] && . ./.env

if [ -n "$REGISTRY" ]; then
    docker build -t "$REGISTRY/$CTNAME" .
else
    docker build -t "$CTNAME" .
fi

