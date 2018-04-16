#!/bin/bash

load_rc() {
    if [ -f /vagrant/.vmrc ]; then 
        source /vagrant/.vmrc
    fi
}