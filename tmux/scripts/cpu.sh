
#!/usr/bin/env bash

export LC_ALL=en_US.UTF-8

get_cpu_usage() {
    case $(uname -s) in
    Linux)
        # Get CPU usage from `top`
        top -bn2 -d 0.01 | grep "Cpu(s)" | tail -1 | \
        sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "%.0f%%", 100 - $1}'
        ;;

    Darwin)
        # Get CPU usage for macOS
        cpuvalue=$(ps -A -o %cpu | awk -F. '{s+=$1} END {print s}')
        cpucores=$(sysctl -n hw.logicalcpu)
        cpuusage=$((cpuvalue / cpucores))
        printf "%d%%" "$cpuusage"
        ;;

    CYGWIN* | MINGW32* | MSYS* | MINGW*)
        echo "Unsupported OS"
        ;;
    esac
}

main () {
    cpu_label=""
    cpu_percent=$(get_cpu_usage)
    echo "$cpu_label  $cpu_percent"
}

main
