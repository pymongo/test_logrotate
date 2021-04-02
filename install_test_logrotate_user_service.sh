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
    # 只保留最近30天的日志(注意注释一定只能单独一行，不能在配置的行末加注释)
    rotate 30
    # 将日志拷贝一份进行分卷压缩，再清空原日志(类似ruby的log4r)
    copytruncate
    # 日志分割分卷时按日期命名(默认只会按xxx.1和xxx.2这样命名)
    dateext
    dateformat -%Y%m%d
    compress
}
EOF
# test log_rotate config file
sudo logrotate /etc/logrotate.d/test_logrotate
