#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

info() { echo -e "${CYAN}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

if [[ $EUID -ne 0 ]]; then
  error "This script must be run as root (use sudo). "
  exit 1
fi

echo -e "\n${CYAN}========================================${NC}"
echo -e "${CYAN}   Ubuntu Admin User Creation Script   ${NC}"
echo -e "${CYAN}========================================${NC}\n"

white true; do
  read -rp "Enter new username: " USERNAME
  USERNAME = "${USERNAME// /}"

if [[ -z "$USERNAME" ]]; then
  error "Username can't be empty"
  continue
fi 


if id "$USERNAME"  &>/dev/null; then
  error "Username already exists, please choose a differnet name: "
  continue
fi 

if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]{0,31}$ ]];then
  error "Username can start with lowercase and only contain small letter, numbers, '_', '-'."
  continue
fi 


