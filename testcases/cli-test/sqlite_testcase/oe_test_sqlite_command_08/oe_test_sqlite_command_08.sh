#!/usr/bin/bash
# Copyright (c) 2021. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.
####################################
#@Author    	:   guochenyang
#@Contact   	:   377012421@qq.com
#@Date      	:   2020-07-02 09:00:43
#@License   	:   Mulan PSL v2
#@Desc      	:   verification sqlite‘s .dump  command
#####################################
source ${OET_PATH}/libs/locallibs/common_lib.sh
function run_test() {
    LOG_INFO "Start to run test."
    expect <<-END
    spawn sqlite3 ../common/test.db
    send "CREATE TABLE COMPANY(
          ID INT PRIMARY KEY     NOT NULL,
          NAME           TEXT    NOT NULL,
          AGE            INT     NOT NULL,
          ADDRESS        CHAR(50),
          SALARY         REAL
          );\n"
    expect "sqlite>"
    send ".read ../common/insert.txt\n"
    expect "sqlite>"
    send ".echo on\n"
    expect "sqlite>"
    send ".output ../common/output.txt\n"
    expect "sqlite>"
    send "select *from COMPANY;\n"
    expect "sqlite>"
    send ".echo off\n"
    expect "sqlite>"
    send ".output ../common/output1.txt\n"
    expect "sqlite>"
    send "select *from COMPANY;\n"
    expect "sqlite>"
    send ".quit\n"
    expect eof
    exit
END
    CHECK_RESULT "$(wc -l ../common/output.txt | grep -cE "25")" 1
    CHECK_RESULT "$(cat ../common/output.txt | grep -cE "select")" 1
    CHECK_RESULT "$(wc -l ../common/output1.txt | grep -cE "24")" 1
    CHECK_RESULT "$(cat ../common/output1.txt | grep -cE "select")" 0
    LOG_INFO "End to run test."
}
function post_test() {
    LOG_INFO "Start to restore the test environment."
    rm -rf ../common/test.db
    rm -rf ../common/output*.txt
    LOG_INFO "End to restore the test environment."
}
main "$@"
