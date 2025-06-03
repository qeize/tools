#!/bin/bash

# Advanced DDoS Protection Script for Ubuntu VPS
# Enterprise-level protection comparable to CloudFlare/Google
# Author: Generated for high-security VPS protection
# Usage: sudo ./ddos_protection.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="/opt/ddos-protection"
LOG_DIR="/var/log/ddos-protection"
CONFIG_FILE="$SCRIPT_DIR/config.conf"
WHITELIST_FILE="$SCRIPT_DIR/whitelist.txt"
BLACKLIST_FILE="$SCRIPT_DIR/blacklist.txt"

# Default thresholds (can be customized)
CONNECTION_LIMIT=50
RATE_LIMIT=100
BURST_LIMIT=200
BAN_TIME=3600
SCAN_INTERVAL=10

echo -e "${BLUE}===========================================${NC}"
echo -e "${BLUE}   Advanced DDoS Protection Installer     ${NC}"
echo -e "${BLUE}   Enterprise-Grade Security System       ${NC}"
echo -e "${BLUE}===========================================${NC}"

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}Error: This script must be run as root${NC}"
        echo "Please run: sudo $0"
        exit 1
    fi
}

# Create directories
create_directories() {
    echo -e "${YELLOW}Creating directories...${NC}"
    mkdir -p "$SCRIPT_DIR"
    mkdir -p "$LOG_DIR"
    mkdir -p "/etc/ddos-protection"
    chmod 755 "$SCRIPT_DIR"
    chmod 755 "$LOG_DIR"
}

# Install required packages
install_dependencies() {
    echo -e "${YELLOW}Installing required packages...${NC}"
    apt-get update -qq
    apt-get install -y \
        iptables \
        iptables-persistent \
        fail2ban \
        ufw \
        netstat-nat \
        tcpdump \
        htop \
        iftop \
        nload \
        hping3 \
        nmap \
        conntrack \
        ipset \
        nginx \
        redis-server \
        rsyslog \
        logrotate \
        curl \
        wget \
        jq \
        bc \
        cron \
        dnsutils
}

# Configure kernel parameters for DDoS protection
configure_kernel() {
    echo -e "${YELLOW}Configuring kernel parameters...${NC}"
    
    cat > /etc/sysctl.d/99-ddos-protection.conf << 'EOF'
# DDoS Protection Kernel Parameters
# Network security
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_time = 300
net.ipv4.tcp_keepalive_probes = 5
net.ipv4.tcp_keepalive_intvl = 15

# IP spoofing protection
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore ICMP ping requests
net.ipv4.icmp_echo_ignore_all = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Ignore bogus ICMP responses
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Log suspicious packets
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Disable source packet routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

# Disable ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

# Connection tracking
net.netfilter.nf_conntrack_max = 2000000
net.netfilter.nf_conntrack_tcp_timeout_established = 54000
net.netfilter.nf_conntrack_generic_timeout = 300

# Memory and file limits
fs.file-max = 2097152
net.core.somaxconn = 65535
net.core.netdev_max_backlog = 5000
net.core.rmem_default = 262144
net.core.rmem_max = 16777216
net.core.wmem_default = 262144
net.core.wmem_max = 16777216

# TCP buffer sizes
net.ipv4.tcp_rmem = 4096 65536 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_congestion_control = bbr

# Disable IPv6 if not needed
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

    sysctl -p /etc/sysctl.d/99-ddos-protection.conf
}

# Configure advanced iptables rules
configure_iptables() {
    echo -e "${YELLOW}Configuring advanced iptables rules...${NC}"
    
    # Flush existing rules
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -t mangle -F
    iptables -t mangle -X
    
    # Set default policies
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT
    
    # Allow loopback
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
    
    # Allow established connections
    iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    
    # Create custom chains
    iptables -N DDOS_PROTECTION
    iptables -N RATE_LIMIT
    iptables -N PORT_SCAN
    iptables -N BLACKLIST_CHECK
    
    # Anti-DDoS rules
    iptables -A DDOS_PROTECTION -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
    iptables -A DDOS_PROTECTION -p tcp --dport 443 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
    iptables -A DDOS_PROTECTION -p tcp --dport 22 -m limit --limit 4/minute --limit-burst 10 -j ACCEPT
    
    # SYN flood protection
    iptables -A INPUT -p tcp --syn -m limit --limit 1/s --limit-burst 3 -j ACCEPT
    iptables -A INPUT -p tcp --syn -j DROP
    
    # Port scan protection
    iptables -A PORT_SCAN -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j ACCEPT
    iptables -A PORT_SCAN -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j DROP
    
    # ICMP flood protection
    iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s --limit-burst 2 -j ACCEPT
    iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
    
    # UDP flood protection
    iptables -A INPUT -p udp -m limit --limit 1/s --limit-burst 4 -j ACCEPT
    iptables -A INPUT -p udp -j DROP
    
    # Connection limit per IP
    iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above $CONNECTION_LIMIT -j REJECT
    iptables -A INPUT -p tcp --syn --dport 443 -m connlimit --connlimit-above $CONNECTION_LIMIT -j REJECT
    
    # Block invalid packets
    iptables -A INPUT -m state --state INVALID -j DROP
    iptables -A FORWARD -m state --state INVALID -j DROP
    iptables -A OUTPUT -m state --state INVALID -j DROP
    
    # Block fragmented packets
    iptables -A INPUT -f -j DROP
    
    # Block packets with bogus TCP flags
    iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
    iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,PSH,ACK,URG -j DROP
    iptables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
    iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
    iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
    iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j DROP
    iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j DROP
    
    # Allow SSH (change port if needed)
    iptables -A INPUT -p tcp --dport 22 -j DDOS_PROTECTION
    
    # Allow HTTP/HTTPS
    iptables -A INPUT -p tcp --dport 80 -j DDOS_PROTECTION
    iptables -A INPUT -p tcp --dport 443 -j DDOS_PROTECTION
    
    # Allow DNS
    iptables -A INPUT -p udp --dport 53 -j ACCEPT
    iptables -A INPUT -p tcp --dport 53 -j ACCEPT
    
    # Jump to custom chains
    iptables -A INPUT -j BLACKLIST_CHECK
    iptables -A INPUT -j PORT_SCAN
    iptables -A INPUT -j RATE_LIMIT
    
    # Save rules
    iptables-save > /etc/iptables/rules.v4
}

# Configure fail2ban
configure_fail2ban() {
    echo -e "${YELLOW}Configuring fail2ban...${NC}"
    
    cat > /etc/fail2ban/jail.d/ddos-protection.conf << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600

[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 3

[nginx-noscript]
enabled = true
port = http,https
filter = nginx-noscript
logpath = /var/log/nginx/access.log
maxretry = 6

[nginx-badbots]
enabled = true
port = http,https
filter = nginx-badbots
logpath = /var/log/nginx/access.log
maxretry = 2

[nginx-noproxy]
enabled = true
port = http,https
filter = nginx-noproxy
logpath = /var/log/nginx/access.log
maxretry = 2

[nginx-limit-req]
enabled = true
filter = nginx-limit-req
port = http,https
logpath = /var/log/nginx/error.log
maxretry = 10
findtime = 600
bantime = 7200

[ddos-protection]
enabled = true
filter = ddos-protection
port = http,https
logpath = /var/log/ddos-protection/attacks.log
maxretry = 10
findtime = 60
bantime = 86400
EOF

    # Create custom filter for DDoS protection
    cat > /etc/fail2ban/filter.d/ddos-protection.conf << 'EOF'
[Definition]
failregex = ^.*DDoS attack detected from <HOST>.*$
            ^.*Suspicious activity from <HOST>.*$
            ^.*Rate limit exceeded from <HOST>.*$
            ^.*Connection flood from <HOST>.*$

ignoreregex =
EOF

    systemctl enable fail2ban
    systemctl restart fail2ban
}

# Create monitoring script
create_monitoring_script() {
    echo -e "${YELLOW}Creating monitoring script...${NC}"
    
    cat > "$SCRIPT_DIR/monitor.sh" << 'EOF'
#!/bin/bash

SCRIPT_DIR="/opt/ddos-protection"
LOG_DIR="/var/log/ddos-protection"
WHITELIST_FILE="$SCRIPT_DIR/whitelist.txt"
BLACKLIST_FILE="$SCRIPT_DIR/blacklist.txt"
ALERT_LOG="$LOG_DIR/alerts.log"
ATTACK_LOG="$LOG_DIR/attacks.log"

# Thresholds
CONNECTION_THRESHOLD=100
PACKET_THRESHOLD=1000
CPU_THRESHOLD=80
MEMORY_THRESHOLD=90

# Function to log alerts
log_alert() {
    echo "$(date): $1" >> "$ALERT_LOG"
    logger -t ddos-protection "$1"
}

# Function to ban IP
ban_ip() {
    local ip=$1
    local reason=$2
    
    # Check if IP is whitelisted
    if grep -q "^$ip$" "$WHITELIST_FILE" 2>/dev/null; then
        return 0
    fi
    
    # Add to blacklist
    echo "$ip" >> "$BLACKLIST_FILE"
    
    # Block with iptables
    iptables -I INPUT -s "$ip" -j DROP
    
    log_alert "Banned IP $ip - Reason: $reason"
    echo "$(date): DDoS attack detected from $ip - $reason" >> "$ATTACK_LOG"
}

# Monitor connections
monitor_connections() {
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | while read count ip; do
        if [[ $count -gt $CONNECTION_THRESHOLD && $ip != "127.0.0.1" && $ip != "" ]]; then
            ban_ip "$ip" "Excessive connections: $count"
        fi
    done
}

# Monitor network traffic
monitor_traffic() {
    local interface=$(ip route | grep default | awk '{print $5}' | head -1)
    local rx_packets=$(cat /sys/class/net/$interface/statistics/rx_packets)
    local tx_packets=$(cat /sys/class/net/$interface/statistics/tx_packets)
    
    sleep 1
    
    local rx_packets_new=$(cat /sys/class/net/$interface/statistics/rx_packets)
    local tx_packets_new=$(cat /sys/class/net/$interface/statistics/tx_packets)
    
    local rx_rate=$((rx_packets_new - rx_packets))
    local tx_rate=$((tx_packets_new - tx_packets))
    
    if [[ $rx_rate -gt $PACKET_THRESHOLD ]]; then
        log_alert "High incoming packet rate detected: $rx_rate pps"
    fi
}

# Monitor system resources
monitor_resources() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    local memory_usage=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100.0}')
    
    cpu_usage=${cpu_usage%.*}
    
    if [[ $cpu_usage -gt $CPU_THRESHOLD ]]; then
        log_alert "High CPU usage detected: ${cpu_usage}%"
    fi
    
    if [[ $memory_usage -gt $MEMORY_THRESHOLD ]]; then
        log_alert "High memory usage detected: ${memory_usage}%"
    fi
}

# Check for port scans
check_port_scans() {
    local suspicious_ips=$(netstat -ntu | grep ':80\|:443\|:22' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | awk '$1 > 50 {print $2}')
    
    for ip in $suspicious_ips; do
        if [[ $ip != "127.0.0.1" && $ip != "" ]]; then
            ban_ip "$ip" "Port scan detected"
        fi
    done
}

# Main monitoring loop
while true; do
    monitor_connections
    monitor_traffic
    monitor_resources
    check_port_scans
    sleep 10
done
EOF

    chmod +x "$SCRIPT_DIR/monitor.sh"
}

# Create rate limiting script
create_rate_limiter() {
    echo -e "${YELLOW}Creating rate limiter...${NC}"
    
    cat > "$SCRIPT_DIR/rate_limiter.sh" << 'EOF'
#!/bin/bash

REDIS_CLI="redis-cli"
RATE_LIMIT=100
TIME_WINDOW=60

# Function to check rate limit
check_rate_limit() {
    local ip=$1
    local key="rate_limit:$ip"
    
    # Get current count
    local current_count=$($REDIS_CLI GET $key)
    current_count=${current_count:-0}
    
    if [[ $current_count -gt $RATE_LIMIT ]]; then
        return 1  # Rate limit exceeded
    else
        # Increment counter
        $REDIS_CLI INCR $key
        $REDIS_CLI EXPIRE $key $TIME_WINDOW
        return 0  # OK
    fi
}

# Monitor access log for rate limiting
tail -f /var/log/nginx/access.log | while read line; do
    ip=$(echo $line | awk '{print $1}')
    
    if ! check_rate_limit "$ip"; then
        echo "$(date): Rate limit exceeded from $ip" >> /var/log/ddos-protection/attacks.log
        iptables -I INPUT -s "$ip" -j DROP
    fi
done
EOF

    chmod +x "$SCRIPT_DIR/rate_limiter.sh"
}

# Configure nginx for DDoS protection
configure_nginx() {
    echo -e "${YELLOW}Configuring nginx for DDoS protection...${NC}"
    
    cat > /etc/nginx/conf.d/ddos-protection.conf << 'EOF'
# DDoS Protection Configuration
limit_req_zone $binary_remote_addr zone=login:10m rate=1r/s;
limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
limit_req_zone $binary_remote_addr zone=general:10m rate=50r/s;
limit_conn_zone $binary_remote_addr zone=conn_limit_per_ip:10m;

# Rate limiting
limit_req zone=general burst=20 nodelay;
limit_conn conn_limit_per_ip 20;

# Client body size limit
client_max_body_size 10M;
client_body_timeout 60s;
client_header_timeout 60s;

# Buffer sizes
client_body_buffer_size 128k;
client_header_buffer_size 1k;
large_client_header_buffers 4 4k;

# Timeouts
keepalive_timeout 65;
send_timeout 60s;

# Hide nginx version
server_tokens off;

# Security headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "no-referrer-when-downgrade" always;
add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

# Block bad bots
if ($http_user_agent ~* (nmap|nikto|wikto|sf|sqlmap|bsqlbf|w3af|acunetix|havij|appscan)) {
    return 444;
}

# Block suspicious requests
location ~* \.(asp|aspx|jsp|cgi|sh|bat|exe|dll)$ {
    return 444;
}

# Block SQL injection attempts
location ~* union.*select.*\( { return 444; }
location ~* union.*all.*select.* { return 444; }
location ~* concat.*\( { return 444; }

# Rate limit specific locations
location /login {
    limit_req zone=login burst=5 nodelay;
}

location /api {
    limit_req zone=api burst=20 nodelay;
}
EOF

    systemctl restart nginx
}

# Create startup service
create_service() {
    echo -e "${YELLOW}Creating systemd service...${NC}"
    
    cat > /etc/systemd/system/ddos-protection.service << 'EOF'
[Unit]
Description=Advanced DDoS Protection System
After=network.target

[Service]
Type=simple
User=root
ExecStart=/opt/ddos-protection/monitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    cat > /etc/systemd/system/ddos-rate-limiter.service << 'EOF'
[Unit]
Description=DDoS Rate Limiter
After=network.target redis.service

[Service]
Type=simple
User=root
ExecStart=/opt/ddos-protection/rate_limiter.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable ddos-protection.service
    systemctl enable ddos-rate-limiter.service
}

# Create configuration files
create_config_files() {
    echo -e "${YELLOW}Creating configuration files...${NC}"
    
    # Main configuration
    cat > "$CONFIG_FILE" << EOF
# DDoS Protection Configuration
CONNECTION_LIMIT=$CONNECTION_LIMIT
RATE_LIMIT=$RATE_LIMIT
BURST_LIMIT=$BURST_LIMIT
BAN_TIME=$BAN_TIME
SCAN_INTERVAL=$SCAN_INTERVAL

# Monitoring thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=90
DISK_THRESHOLD=85
CONNECTION_THRESHOLD=100
PACKET_THRESHOLD=1000

# Notification settings
ENABLE_EMAIL_ALERTS=false
ADMIN_EMAIL=""
ENABLE_SLACK_ALERTS=false
SLACK_WEBHOOK=""
EOF

    # Whitelist file (add your IPS here)
    cat > "$WHITELIST_FILE" << 'EOF'
127.0.0.1
::1
# Add your trusted IPs here
# Format: one IP per line
EOF

    # Initialize blacklist
    touch "$BLACKLIST_FILE"
    
    chmod 644 "$CONFIG_FILE" "$WHITELIST_FILE" "$BLACKLIST_FILE"
}

# Create log rotation
configure_log_rotation() {
    echo -e "${YELLOW}Configuring log rotation...${NC}"
    
    cat > /etc/logrotate.d/ddos-protection << 'EOF'
/var/log/ddos-protection/*.log {
    daily
    missingok
    rotate 30
    compress
    delaycompress
    notifempty
    create 644 root root
    postrotate
        systemctl reload rsyslog > /dev/null 2>&1 || true
    endscript
}
EOF
}

# Create status script
create_status_script() {
    cat > "$SCRIPT_DIR/status.sh" << 'EOF'
#!/bin/bash

echo "=== DDoS Protection Status ==="
echo

echo "System Status:"
systemctl is-active ddos-protection.service
systemctl is-active ddos-rate-limiter.service
systemctl is-active fail2ban.service
systemctl is-active nginx.service

echo
echo "Current Connections:"
netstat -ntu | grep ':80\|:443\|:22' | wc -l

echo
echo "Banned IPs:"
iptables -L INPUT -n | grep DROP | wc -l

echo
echo "Recent Attacks:"
tail -5 /var/log/ddos-protection/attacks.log 2>/dev/null || echo "No attacks logged"

echo
echo "System Load:"
uptime

echo
echo "Memory Usage:"
free -h
EOF

    chmod +x "$SCRIPT_DIR/status.sh"
}

# Main installation function
main() {
    check_root
    
    echo -e "${GREEN}Starting DDoS protection installation...${NC}"
    
    create_directories
    install_dependencies
    configure_kernel
    configure_iptables
    configure_fail2ban
    configure_nginx
    create_monitoring_script
    create_rate_limiter
    create_config_files
    create_service
    configure_log_rotation
    create_status_script
    
    # Start services
    systemctl start redis-server
    systemctl enable redis-server
    systemctl start ddos-protection.service
    systemctl start ddos-rate-limiter.service
    
    echo
    echo -e "${GREEN}===========================================${NC}"
    echo -e "${GREEN}   DDoS Protection Installation Complete   ${NC}"
    echo -e "${GREEN}===========================================${NC}"
    echo
    echo -e "${YELLOW}Configuration files:${NC}"
    echo "- Main config: $CONFIG_FILE"
    echo "- Whitelist: $WHITELIST_FILE"
    echo "- Blacklist: $BLACKLIST_FILE"
    echo
    echo -e "${YELLOW}Management commands:${NC}"
    echo "- Check status: $SCRIPT_DIR/status.sh"
    echo "- View logs: tail -f $LOG_DIR/attacks.log"
    echo "- Restart protection: systemctl restart ddos-protection.service"
    echo
    echo -e "${YELLOW}Important:${NC}"
    echo "1. Add your trusted IPs to $WHITELIST_FILE"
    echo "2. Customize thresholds in $CONFIG_FILE"
    echo "3. Monitor logs regularly: $LOG_DIR/"
    echo "4. Test your configuration before going live"
    echo
    echo -e "${GREEN}Your server is now protected with enterprise-level DDoS protection!${NC}"
}

# Run main function
main "$@"