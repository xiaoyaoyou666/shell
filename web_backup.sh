#!/bin/bash
WEBBACK_DIR="/mnt/web_backup"

#格式化日期,备份文件时用日期来做文件名的
DATE=`date +%Y%m%d-%H%M%S`
#保存日期
DAYS=10

############ www info ######################
#WEB目录
WEBSITE_DIR="/data/"
TARGET_DIR="web"

# 排除某些目录(日志和缓存),exclude.txt文件中写入   
#/data/web/Runtime 
#/data/web/logs
#指定www备份文件的前缀

#开始备份网站目录，备份过程同上
cd $WEBSITE_DIR
tar zcvf ${WEBBACK_DIR}/${DATE}.tar.gz ${TARGET_DIR}
if [ $? -eq 0 ]; then
        echo "succed $DATE" >> /var/log/web_backup.log
else
        echo "failed $DATE" >> /var/log/web_backup.log
fi


#远程备份 需要配置ssh的无密码传输
scp /mnt/web_backup/${DATE}.tar.gz 用户名@IP地址:/mnt/【目录】


#只保留指定时间内的文件
find ${WEBBACK_DIR} -name "*.tar.gz" -type f -mtime +${DAYS} -exec rm {} \;
