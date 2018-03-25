#!/bin/bash

set -e

# We generate odoo configuration based on default values and vars
dockerize -template /opt/odoo/etc/odoo.conf.tmpl:/opt/odoo/etc/odoo.conf

case "$1" in
    -- | odoo)
        shift
        exec odoo_src/odoo-bin "$@"
        ;;
    *)
        exec "$@"
esac

exit 1