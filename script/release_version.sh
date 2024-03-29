#!/bin/bash

if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
    DIRTY="-dirty"
fi

COMMIT=$(git rev-parse --short HEAD)
GIT_TAG=$(git tag -l --contains HEAD | head -n 1)

if [ -z "$VERSION" ]; then
    if [[ -z "$DIRTY" && -n "$GIT_TAG" ]]; then
        VERSION=$GIT_TAG
    else
        VERSION="${COMMIT}${DIRTY}"
    fi
fi

export VERSION COMMIT GIT_TAG DIRTY

# Suffix
export SUFFIX=""
if [ -n "${ARCH}" ] && [ "${ARCH}" != "amd64" ]; then
    SUFFIX="_${ARCH}"
fi
