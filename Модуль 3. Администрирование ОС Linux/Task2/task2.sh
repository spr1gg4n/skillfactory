#!/bin/bash
BACKUP_DIR="/archive"
TIMESTAMP=$(date '+%d.%B.%Y_%H:%M')

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup HOME directory
tar cpf "$BACKUP_DIR/home-backup-$TIMESTAMP.tar" -C / home

# Backup SSH Config File
tar cpf "$BACKUP_DIR/ssh-backup-$TIMESTAMP.tar" -C / etc/ssh/sshd_config

# Backup RDP Config File
tar cpf "$BACKUP_DIR/xrdp-backup-$TIMESTAMP.tar" -C / etc/xrdp/xrdp.ini

# Backup FTP Config file
tar cpf "$BACKUP_DIR/vsftpd-backup-$TIMESTAMP.tar" -C / etc/vsftpd.conf

# Backup /var/log directory
tar cpf "$BACKUP_DIR/varlog-backup-$TIMESTAMP.tar" -C / var/log

if [ $? -eq 0 ]; then
    echo "All backup commands completed successfully."
else
    echo "There were errors during backup process. Check the individual messages above."
fi
