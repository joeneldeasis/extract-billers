# extract-billers
Shell script to extract billers from the json file

### Requirements
Get the billers json: `wget http//<api_here>/api/site/billers/all -O billers.json`

Install js-beautify: `npm -g install js-beautify`

### Usage
`chmod +x extractbillers.sh`

`sh extractbillers.sh path/to/billers.json`
