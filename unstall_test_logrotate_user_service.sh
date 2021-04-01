systemctl --user stop test_logrotate
systemctl --user disable test_logrotate
rm $HOME/.config/systemd/user/test_logrotate.service
systemctl --user daemon-reload

sudo rm /etc/logrotate.d/test_logrotate
