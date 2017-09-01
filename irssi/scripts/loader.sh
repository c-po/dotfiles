cd ~/.irssi/scripts
rm autorun/*
find * -maxdepth 0 -iname "*.pl" | xargs -t -ishitler ln -s ~/.irssi/scripts/shitler ~/.irssi/scripts/autorun/shitler
