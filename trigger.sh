#!/bin/bash

echo 'hello world'

sed -i -e "s/'.\/src\/\*\*\/\*.{js,jsx,ts,tsx}'/'.\/src\/\*\*\/\*.{js,jsx,ts,tsx}', '.\/.storybook\/\*.{js,jsx,ts,tsx}'/g" tailwind.config.js
