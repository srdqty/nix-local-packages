#!@bash@

set -eu

PROFILE=${1:-default}
TYPE=${2:-t2.xlarge}

@aws@ --profile "${PROFILE}" ec2 describe-reserved-instances-offerings \
  --filters 'Name=scope,Values=Availability Zone' \
  --no-include-marketplace --instance-type "${TYPE}" \
  | @jq@ -r '.ReservedInstancesOfferings[].AvailabilityZone' \
  | @sort@ | @uniq@
