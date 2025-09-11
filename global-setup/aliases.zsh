# Other
alias aptuu="sudo apt update && sudo apt upgrade -y"
alias ports="ss -tulnp"
alias getallusers="cut -d: -f1 /etc/passwd"

alias getpip="curl ifconfig.me" # get public IP
alias getpipdetailed="curl https://ipinfo.io" # get public IP with ISP Details

# SystemD
alias sysstart="sudo systemctl start"
alias sysenable="sudo systemctl enable"
alias sysstop="sudo systemctl stop"
alias sysdisable="sudo systemctl disable"
alias sysrestart="sudo systemctl restart"

# Git
alias g="git"

# Terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"

# Ansible
alias anplay="ansible-playbook"
alias anvc="ansible-vault create"
alias anve="ansible-vault edit"
alias anv="ansible-vault view"

# Docker
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}'"
alias dpsa="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}'"
alias wdps="watch docker ps -a"
alias dl="docker logs"
alias dirm="docker images rm"
alias dil="docker image list"
alias dip="docker image prune"
alias dcrm="docker container rm"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcp="docker compose pull"
alias de="docker exec -it"

# crowdsec in docker container
alias crowdsecdl="docker exec crowdsec cscli decisions list"
alias crowdsecal="docker exec crowdsec cscli alert list"
alias crowdsecbl="docker exec crowdsec cscli bouncers list"
alias crowdsecai="docker exec crowdsec cscli alerts inspect -d"
alias crowdsecmetrics="docker exec crowdsec cscli metrics"
alias crowdsecban="docker exec crowdsec cscli decisions add --ip"
alias crowdsecunban="docker exec crowdsec cscli decisions delete --ip"
