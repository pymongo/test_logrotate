tee $HOME/.config/systemd/user/test_logrotate.service <<EOF >/dev/null
[Unit]
Description=test_logrotate

[Service]
#Type=simple
#StandardOutput=journal
WorkingDirectory=/home/w/workspace/temp/test_logrotate/
ExecStart=/home/w/workspace/temp/test_logrotate/target/debug/test_logrotate

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user status test_logrotate


# add logrotate config
sudo tee /etc/logrotate.d/test_logrotate <<EOF >/dev/null
/home/w/workspace/temp/test_logrotate/log/*.log {
    daily
    rotate 30 // 只保留最近30天的日志
    dateext // 日志分割分卷时按日期命名(默认只会按xxx.1和xxx.2这样命名)
    dateformat -%Y%m%d
    compress
}
EOF