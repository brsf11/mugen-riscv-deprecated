#!/usr/bin/bash

# Copyright (c) 2021. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.

# #############################################
# @Author    :   liujuan
# @Contact   :   lchutian@163.com
# @Date      :   2020/10/27
# @License   :   Mulan PSL v2
# @Desc      :   verify the uasge of memslap command
# ############################################

source "../common/common_libmemcached.sh"

function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    deploy_env
    LOG_INFO "Finish preparing the test environment."
}

function run_test() {
    LOG_INFO "Start to run test."
    memslap --help | grep "-"
    CHECK_RESULT $?
    memslap --version | grep "memslap"
    CHECK_RESULT $?
    memslap --verbose --servers=127.0.0.1 | grep "Threads connecting to servers 1"
    CHECK_RESULT $?
    memslap --concurrency=3 --servers=127.0.0.1 | grep "Threads connecting to servers 3"
    CHECK_RESULT $?
    memslap --debug --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --quiet --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --execute-number=5 --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --flag --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --flush --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --initial-load=3 --servers=127.0.0.1
    CHECK_RESULT $?
    memslap --test=get --servers=127.0.0.1
    CHECK_RESULT $?
    LOG_INFO "End of the test."
}

function post_test() {
    LOG_INFO "Start to restore the test environment."
    clear_env
    LOG_INFO "Finish restoring the test environment."
}

main $@
