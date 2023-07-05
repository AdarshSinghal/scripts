//Need to execute these steps manually whenever new alpine server is provisioned. 
//The automation part to be updated in alpine.sh

```
apk add git
mkdir /usr/local/git-repo
cd /usr/local/git-repo
git clone https://github.com/AdarshSinghal/scripts.git
chmod +x ./scripts/server/alpine.sh
./scripts/server/alpine.sh
```
