# extract-billers
Shell script to extract billers from the json file

### Requirements
Get the billers json: `wget http//<api_here>/api/site/billers/all -O billers.json`

Install js-beautify: `npm -g install js-beautify`

### Usage

Create a js directory: `mkdir js`

Make the script executable: `chmod +x extractbillers.sh`

Run the script that extract all the billers: `sh extractbillers.sh path/to/billers.json`
