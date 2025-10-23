#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

get_percent() {
    case $(uname -s) in
    Linux)
        total_mem=$(free -g | awk '/^Mem/ {print $2}')
        used_mem=$(free -g | awk '/^Mem/ {print $3}')
        memory_percent=$(((used_mem * 100) / total_mem))
        echo "$memory_percent%"
        ;;
    Darwin)
        #          vm_stat | only look at active    | extract numbers   | put both into   | adds active & wired, converts to megabytes 
        #                  |        & wired         |                   |    same line    | 
        used_mem=$(vm_stat | grep ' active\|wired ' | sed 's/[^0-9]//g' | paste -sd ' ' - | awk -v pagesize=$(pagesize) '{printf "%d\n", ($1+$2) * pagesize / 1048576}')
        total_mem=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2}')
        memory_percent=$(((used_mem) / total_mem / 10))
        echo "$memory_percent%"
        ;;
    FreeBSD)
        hw_pagesize="$(sysctl -n hw.pagesize)"
        mem_inactive="$(($(sysctl -n vm.stats.vm.v_inactive_count) * hw_pagesize))"
        mem_unused="$(($(sysctl -n vm.stats.vm.v_free_count) * hw_pagesize))"
        mem_cache="$(($(sysctl -n vm.stats.vm.v_cache_count) * hw_pagesize))"

        free_mem=$(((mem_inactive + mem_unused + mem_cache) / 1024 / 1024))
        total_mem=$(($(sysctl -n hw.physmem) / 1024 / 1024))
        used_mem=$((total_mem - free_mem))
        memory_percent=$(((used_mem * 100) / total_mem))
        echo "$memory_percent%"
        ;;
    CYGWIN* | MINGW32* | MSYS* | MINGW*) ;;
    esac
}

main() {
    ram_label=" " # Change the icon if you prefer
    ram_percent=$(get_percent)
    echo "$ram_label $ram_percent"
}

main
