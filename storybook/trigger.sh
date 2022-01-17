#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

echo ""
echo -e "${GREEN}======================="
echo "Storybook installing..."
echo "======================="
echo -e "${NC}"

#region  //*=========== Install Packages ===========
echo -e "${NC}"
echo -e "${GREEN}[Step 1] Initializing Storybook with Webpack 5${NC}"
echo -e ""
echo -e "This may take a while to download."
echo ""
echo y | npx sb init --builder webpack5
echo yes
echo -e ""
echo -e "Installing Dev Packages: ${GREEN}@storybook/addons @storybook/addon-postcss @storybook/addon-a11y @storybook/theming storybook-theme-css-vars plop inquirer-fuzzy-path"
echo -e "${NC}"
yarn add -D @storybook/addons @storybook/addon-postcss @storybook/addon-a11y @storybook/theming storybook-theme-css-vars plop inquirer-fuzzy-path

echo -e "${NC}"
echo -e "${GREEN}[Step 2] Adding Webpack 5 as a resolution${NC}"
echo ""
npx --no -y npe resolutions.webpack "^5"
echo ""
yarn

echo ""
echo -e "${GREEN}[Step 3] Adding storybook-generate components command${NC}"
echo ""
npx npe scripts.storybook:generate "yarn plop"
# endregion  //*======== Install Packages ===========

#region  //*=========== Create Directories ===========
mkdir -p src/generators
#endregion  //*======== Create Directories ===========

#region  //*=========== Downloading Files ===========
echo ""
echo -e "${GREEN}[Step 4] Downloading files${NC}"
echo ""

DIRNAME="storybook"

files=(
  ".storybook/preview.js"
  ".storybook/manager.js"
  ".storybook/main.js"
  "plopfile.js"
  "src/generators/Component.stories.tsx.hbs"
  "src/generators/story.js"
)

for i in "${files[@]}"
do
  echo "Downloading... $i"
  curl -LJs -o $i https://raw.githubusercontent.com/flosrn/expansion-pack/master/$DIRNAME/$i
done

echo ""
echo -e "${GREEN}[Step 5] Adding storybook folder to tailwind purge${NC}"
sed -i -e "s/'.\/src\/\*\*\/\*.{js,jsx,ts,tsx}'/'.\/src\/\*\*\/\*.{js,jsx,ts,tsx}', '.\/.storybook\/\*.{js,jsx,ts,tsx}'/g" tailwind.config.js
rm -r tailwind.config.js-e
echo ""
echo "tailwind.config.js has been updated."

echo ""
echo -e "${CYAN}============================================"
echo "🔋 Storybook Expansion Completed"
echo ""
echo "Run yarn storybook:generate to generate your storybook components"
echo "Run yarn storybook to start storybook"
echo ""

