#! /usr/bin/env bash

# TODO: change to lehmannro/assert.sh

source ./bashutils

export TEST_BASH_VERSINFO
export TEST_BASH_VERSION

# override default bashutils::__get_current_bash_version_array()
function bashutils::__get_current_bash_version_array() {
    printf '%s' "${TEST_BASH_VERSINFO[*]}"
}

# override default bashutils::__get_current_bash_version()
function bashutils::__get_current_bash_version() {
    printf '%s' "${TEST_BASH_VERSION}"
}

function do_test() {
    local verbose=0

    if [[ "${1}" == "-v" ]]; then
        verbose=1
        shift
    fi

    local set_version="${1}"
    local required_version="${2}"
    local expected_result="${3}"

    local version_part
    local TEST_BASH_VERSINFO=()

    for version_part in $(echo "${set_version}" | tr "." " "); do
        TEST_BASH_VERSINFO+=( "${version_part}" )
    done

    export TEST_BASH_VERSINFO
    export TEST_BASH_VERSION="${TEST_BASH_VERSINFO[0]}.${TEST_BASH_VERSINFO[1]}.${TEST_BASH_VERSINFO[2]}(${TEST_BASH_VERSINFO[3]})"

    local expected_result_colored="${expected_result}"

    case "${expected_result}" in
        "success" )
            expected_result="0"
            expected_result_colored="$(ansi --green "succeed")"
        ;;

        "fail" )
            expected_result="1"
            expected_result_colored="$(ansi --red "fail")"
        ;;

        * )
            bashutils::terminate "Neznámý očekávaný výsledek [${expected_result}]."
    esac

    local output
    output="$(bashutils::is_min_bash_version "${required_version}" 2>&1)"
    local result="${?}"
    local result_colored=""

    if [[ "${result}" -eq "0" ]]; then
        result_colored="$(ansi --green "succeeded")"
    else
        result_colored="$(ansi --red "failed")"
    fi

    if [[ ${result} -eq ${expected_result} ]]; then
        echo -n "[  $(ansi --green "OK")  ] "
    else
        echo -n "[ $(ansi --red "FAIL") ] "
    fi

    echo "${set_version} >= ${required_version} should ${expected_result_colored} and it ${result_colored}"

    if [[ "${verbose}" -eq 1 ]]; then
        echo "> set_version=${TEST_BASH_VERSINFO[*]}, ${TEST_BASH_VERSION}"
        echo "> required_version=${required_version}"
        echo "> result=${result}"
        echo "> expected_result=${expected_result}"
        printf '> output: %s\n' "${output}"
    fi
}

do_test "4.4.0.0" "4.4" "success"
do_test "4.4.0.0" "4.3" "success"
do_test "4.3.0.0" "4.4" "fail"

do_test "4.4.1.0" "4.4" "success"
do_test "4.4.1.0" "4.4.2" "fail"
do_test "4.4.1.1" "4.4" "success"
do_test "4.4.1.1" "4.4.1.2" "fail"
do_test "3.0.0.0" "4.4.1.2" "fail"
do_test "5.0.0.0" "4.4.1.2" "success"

do_test "1.2.3.4" "1.2.3.5" "fail"
do_test "1.2.4.4" "1.2.3.5" "success"

do_test "5.4.3.2" "5.4.3.1" "success"
do_test "5.4.3.2" "5.4.3.3" "fail"

do_test -v "5.4.3.2" "" "fail"
do_test "5.4.3.2" "1" "success"
