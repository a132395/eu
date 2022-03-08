#!/bin/sh

# Download and install eu
mkdir /tmp/eu
curl -L -H "Cache-Control: no-cache" -o /tmp/eu/eu.zip https://github.com/a132395/eu/releases/download/1.0.0/123.zip
unzip /tmp/eu/eu.zip -d /tmp/eu
install -m 755 /tmp/eu/xray /usr/local/bin/eu

# Remove temporary directory
rm -rf /tmp/eu

# eu new configuration
install -d /usr/local/etc/eu
cat << EOF > /usr/local/etc/eu/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 0
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                "path": "/"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run eu
/usr/local/bin/eu -config /usr/local/etc/eu/config.json
