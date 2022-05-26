#!/usr/bin/env bash

source "$(dirname "$0")/common.sh"

# Required parameters
RELEASE_NAME=${RELEASE_NAME:?'RELEASE_NAME variable missing.'}
HELM_COMMAND=${HELM_COMMAND:?'HELM_COMMAND variable missing.'}
HELM_CHART_PATH=${HELM_CHART_PATH:?'HELM_CHART_PATH variable missing.'}
AWS_KEY=${AWS_KEY:?'AWS_KEY variable missing.'}
AWS_SECRET=${AWS_SECRET:?'AWS_SECRET variable missing.'}
EKS_CLUSTER=${EKS_CLUSTER:?'EKS_CLUSTER variable missing.'}
AWS_REGION=${AWS_REGION:?'AWS_REGION variable missing.'}
NAMESPACE=${NAMESPACE:?'NAMESPACE variable missing.'}
# Default parameters
DEBUG=${DEBUG:="false"}
BUILD_HELM=${BUILD_HELM:="no"}
HELM_COMMAND_ARGS=${HELM_COMMAND_ARGS:=""}

makedir="$(dirname "$0")"

info "Executing the pipe..."

info ""
run aws configure set aws_access_key_id "${AWS_KEY}"
run aws configure set aws_secret_access_key "${AWS_SECRET}"
if [[ "${status}" != "0" ]]; then
  fail "Error! credentials aws incorrect"
fi

run aws eks update-kubeconfig --region ${AWS_REGION} --name ${EKS_CLUSTER}
if [[ "${status}" != "0" ]]; then
  fail "Error!  could not generate kubeconfig"
fi
run kubectl get namespaces
if [[ "${status}" != "0" ]]; then
  fail "Error! test kubectl not configured"
fi

run helm ${HELM_COMMAND} ${RELEASE_NAME} ${HELM_CHART_PATH} ${HELM_COMMAND_ARGS} -n ${NAMESPACE}

if [[ "${status}" != "0" ]]; then
  fail "Error!"
fi

success "Success!"