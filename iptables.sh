iptables -F ANTI-PORN
iptables -X ANTI-PORN
iptables -D FORWARD -j ANTI-PORN

iptables -N ANTI-PORN
curl https://raw.githubusercontent.com/jiemoshu/anti-porn-ips/master/ipv4s | xargs -I % iptables -A ANTI-PORN -d % -j DROP
iptables -I FORWARD 1 -j ANTI-PORN

