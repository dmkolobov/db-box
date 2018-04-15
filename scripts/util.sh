#!/bin/bash

load_proxy() {
    if [ -f /vagrant/.proxyrc ]; then 
        source /vagrant/.proxyrc
    fi
}