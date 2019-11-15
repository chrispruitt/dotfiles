if test ! -e ~/.nvm/nvm.sh
then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi

lts=v$(curl https://nodejs.org/dist/index.json | jq -r '.[] | select(.lts) | .version' | head -n 1 | tail -c +2)
cts=$(node --version)

if [[ $lts != $cts ]]
then
  echo "updating node LTS $cts -> $lts"
  source ~/.nvm/nvm.sh

  nvm install $lts
  nvm alias default $lts
else
  echo "node LTS is current"
fi

if test $(which npm)
then
  npm update npm -g
fi

lnv=$(npm info npm | grep -o -m 1 "version: '.*'" | sed "s/version: '//g" | sed "s/'//g")
cnv=$(npm -v)

if [[ $lnv != $cnv ]]
then
  echo "updating npm $cnv -> $lnv"
  npm install npm -g
else
  echo "npm is current"
fi

if test ! $(which bunyan)
then
  npm install bunyan -g
fi

if test ! $(which nodemon)
then
  npm install nodemon -g
fi

if test ! $(which eslint)
then
  npm install eslint -g
fi

if test ! $(which lab)
then
  npm install lab -g
fi

if test ! $(which gulp)
then
  npm install gulp -g
fi

if test ! $(which nsp)
then
  npm install nsp -g
fi

if test ! $(which npm-check)
then
  npm install npm-check -g
fi
