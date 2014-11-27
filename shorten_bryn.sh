#!/bin/bash

URL='http://google.com'; for ((;;)); do URL=$(curl -s --data-urlencode 'longurl='$URL xbryn.com/short/shorten.php); echo $URL; done
