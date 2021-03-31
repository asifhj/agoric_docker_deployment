#!/bin/bash

echo "$SETUP == $MONIKER"

if [[ $SETUP == "1" ]]
then

	ag-chain-cosmos version --long

	echo "$(date) Configuring Your Node"
	echo "$(date) Check the Network Parameters. To check the current testnet network parameters:"
	echo "$(date) First, get the network config for the current network."
	echo "$(date) Set chain name to the correct value and Update environment variables to include chainName"
	curl -s https://testnet.agoric.net/network-config > chain.json
	export chainName=`jq -r .chainName < chain.json`

	/bin/bash -c "source $HOME/.profile"

	echo "$(date) Confirm value: should be something like agorictest-N."
	echo $chainName


	echo "$(date) Apply Network Parameters"
	echo "$(date) By default, this is $HOME/.ag-chain-cosmos."
	ag-chain-cosmos init --overwrite --chain-id $chainName $MONIKER 


	echo "$(date) Download the genesis file"
	curl -s https://testnet.agoric.net/genesis.json > $HOME/.ag-chain-cosmos/config/genesis.json 
	echo "$(date) Reset the state of your validator."
	ag-chain-cosmos unsafe-reset-all


	echo "$(date) Adjust configuration"
	echo "$(date) Set peers variable to the correct value"
	peers=$(jq '.peers | join(",")' < chain.json)

	echo "$(date) Set seeds variable to the correct value."
	seeds=$(jq '.seeds | join(",")' < chain.json)

	echo "$(date) Confirm values, each should be something like 077c58e4b207d02bbbb1b68d6e7e1df08ce18a8a@178.62.245.23:26656,..."
	echo $peers
	echo $seeds

	echo "$(date) Fix Error: failed to parse log level"
	sed -i.bak 's/^log_level/# log_level/' $HOME/.ag-chain-cosmos/config/config.toml

	echo "$(date) Replace the seeds and persistent_peers values"
	sed -i.bak -e "s/^seeds *=.*/seeds = $seeds/; s/^persistent_peers *=.*/persistent_peers = $peers/" $HOME/.ag-chain-cosmos/config/config.toml

	ag-chain-cosmos start --log_level=warn;

else
	ag-chain-cosmos start --log_level=warn;
fi;
<<'EOF'