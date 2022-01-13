#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

echo -e "${CYAN}========================="
echo "Storybook Expansion"
echo "========================="
echo -e "${NC}"

#region  //*=========== Install Packages ===========
echo -e "${NC}"
echo -e "${GREEN}[Step 1] Initializing Storybook with Webpack 5${NC}"
echo -e "This may take a while to download."
echo ""
echo y | npx sb init --builder webpack5
echo yes
echo -e ""
echo -e "Installing Dev Packages: ${GREEN}@storybook/addon @storybook/addon-postcss @storybook/theming @storybook/addon-a11y plop inquirer-fuzzy-path"
echo -e "${NC}"
yarn add -D @storybook/addon-postcss plop inquirer-fuzzy-path

echo -e "${NC}"
echo -e "${GREEN}[Step 2] Adding Webpack 5 as a resolution${NC}"
npx --no -y npe resolutions.webpack "^5"
yarn

echo -e "${GREEN}[Step 3] Adding storybook-generate components command${NC}"
npx npe scripts.storybook-generate "yarn plop"
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
echo -e "${CYAN}============================================"
echo "🔋 Storybook Expansion Completed"
echo "Run yarn plop to generate your storybook components"
echo "Run yarn storybook to start the storybook"

