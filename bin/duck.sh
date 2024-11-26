#!/usr/bin/bash

echo url="https://www.duckdns.org/update?domains=leattic&token=120b710c-0c08-4b83-8827-29673ff81d97&ip=" | curl -k -o ~/.duckdns/duck.log -K -

