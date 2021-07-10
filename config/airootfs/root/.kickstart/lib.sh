log_message () {
  message=$1
  level=$2
  timestamp=$(date '+%F %T')
  
  LEVEL_COLOR="\e[1;34m"
  RESET_COLOR="\e[0m"

  case "$level" in 
    "WARN")
      LEVEL_COLOR="\e[0;33m"
      ;;
    "ERROR")
      LEVEL_COLOR="\e[0;31m"
      ;;
    "PASS")
      LEVEL_COLOR="\e[0;36m"
      ;;
    "SUCCESS")
      LEVEL_COLOR="\e[0;32m"
      ;;
  esac

  printf "%b" "${RESET_COLOR}[${timestamp}][${LEVEL_COLOR}${level}${RESET_COLOR}]: ${message}\n"
}

log_info () {
  log_message "$1" "INFO"
}

log_warn () {
  log_message "$1" "WARN"
}

log_err () {
  log_message "$1" "ERROR"
}

log_pass () {
  log_message "$1" "PASS"
}

log_succ () {
  log_message "$1" "SUCCESS"
}