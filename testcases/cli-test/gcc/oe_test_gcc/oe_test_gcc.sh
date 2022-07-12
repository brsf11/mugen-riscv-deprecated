####################################
#@Author    	:   brsf11
#@Contact   	:   brsf11@outlook.com
#@Date      	:   2022-07-12 11:35:43
#@License       :   Mulan PSL v2
#@Desc      	:   verification gcc command
#####################################
source ${OET_PATH}/libs/locallibs/common_lib.sh
function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    DNF_INSTALL gcc
    cp -r ../common ./tmp
    cd ./tmp
    LOG_INFO "End to prepare the test environment."
}
function run_test() {
    LOG_INFO "Start to run test."
    gcc test.c -o test
    CHECK_RESULT $?
    ./test | grep "Hello world!" > /dev/null
    CHECK_RESULT $?
    objdump -D ./test | grep "<main>" > /dev/null
    CHECK_RESULT $?
    LOG_INFO "End to run test."
}
function post_test() {
    LOG_INFO "Start to restore the test environment."
    rm -rf ./tmp
    DNF_REMOVE
    LOG_INFO "End to restore the test environment."
}
main "$@"
