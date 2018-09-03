#!/bin/bash

if [ -z "$1" ]
then
    echo "Extract Billers"
    echo "Usage: $0 path/to/billers.json"
else

biller_count=$(grep meta $1 | wc -l | tr -d \ )

for i in {0..1624}

do
    #set the json values to variables
    biller_name=$(cat billers.json | jq '.data.listings.institutions['$i'].name' | tr -d \")
    biller_partner_name=$(cat billers.json | jq '.data.listings.institutions['$i'].partner.name' | tr -d \")
    biller_code=$(cat billers.json | jq '.data.listings.institutions['$i'].code' | tr -d \")
    biller_meta=$(cat billers.json | jq '.data.listings.institutions['$i'].meta' | tr -d \")

#create javascript file for billers
cat <<EOF > BC_$biller_code.tmp
import billerForm from '../utils/billers_form';

export default billerForm(
	'utilities',
	'$biller_partner_name',
	'$biller_code',
	$biller_meta
)

EOF

    #log current process
    echo "Extracting biller $biller_name"
    #beautify the javscript code
    js-beautify BC_$biller_code.tmp >> js/BC_$biller_code.js
    #remove the temporary file
    rm -f BC_$biller_code.tmp

done
fi

