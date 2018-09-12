#!/bin/bash

if [ -z "$1" ]
then
    echo "Extract Billers"
    echo "Usage: $0 path/to/billers.json"
else

for i in {0..1624}

do
    #set the json values to variables
    biller_name=$(cat billers.json | jq '.data.listings.institutions['$i'].name' | tr -d \")
    biller_partner_name=$(cat billers.json | jq '.data.listings.institutions['$i'].partner.name' | tr -d \")
    biller_code=$(cat billers.json | jq '.data.listings.institutions['$i'].code' | tr -d \")
    biller_meta=$(cat billers.json | jq '.data.listings.institutions['$i'].meta')

#create javascript file for billers
cat <<EOF > $biller_code.tmp
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

    #remove double qoutes
    sed -i '' 's/"label"/label/g' $biller_code.tmp
    sed -i '' 's/"field"/field/g' $biller_code.tmp
    sed -i '' 's/"type"/type/g' $biller_code.tmp
    sed -i '' 's/"is_required"/is_required/g' $biller_code.tmp

    #replace double qoutes to single qoutes
    sed -i '' "s/\"/'/g" $biller_code.tmp

    #remove single qoutes on options, key, value
    sed -i '' "s/'options'/options/g" $biller_code.tmp
    sed -i '' "s/'key'/key/g" $biller_code.tmp
    sed -i '' "s/'value'/value/g" $biller_code.tmp

    #beautify the javscript code
    js-beautify $biller_code.tmp >> js/$biller_code.js
    #remove the temporary file
    rm -f $biller_code.tmp

done
fi

