# Agoric Validator Docker Deployment
This repo helps to run Agoric in the docker container. A pre-built(dependencies and Agoric sdk@2.14.0) ubuntu docker image is available in the hub.docker. A startup script is used to determine the environment to start from the beginning or resume from the exisitng setup.

Note: Network parameters are set to testnet.agoric.net

## How do I use it?
### Step 1: Install pre-requisites docker and docker-compose
### Step 2: Copy docker-compose.yml to the host
https://github.com/asifhj/agoric_docker_deployment/blob/main/docker-compose.yml

### Step 3: Update the environment variables in docker-compose.yml
NOTE: SETUP=0 means just start Agoric service
      SETUP=1 means reset all and start the Agoric service
      
      MONIKER - name for your validator
      
### Step 4: Set persistent storage for your container to prevent data loss in docker-compose.yml
      Default - Volumes - current directory is mapped to /root/.ag-chain-cosmos
      
### Step 5: Configure the port mapping in ports section in docker-compose.yml
      
### Step 5: Start the container
This will pull pre-built(dependencies and Agoric sdk@2.14.0) docker image from docker hub and mounts volume. The startup.sh script is used to read the environment variables and decides whether to setup new environment or resume from the last block. 
```
$ docker-compose up
Pulling node (asif/agoric_validator:sdk2.14.0)...
sdk2.14.0: Pulling from asif/agoric_validator
04a5f4cda3ee: Already exists
ff496a88c8ed: Already exists
0ce83f459fe7: Already exists
4f4fb700ef54: Already exists
a3351484386f: Already exists
53d833f20a21: Already exists
c59f8bfaaf0a: Already exists
650bfe56455b: Already exists
57ec2656e050: Already exists
e183fdfe370b: Already exists
7d21ccc251c3: Already exists
b3f47917a71a: Already exists
d079775ae812: Already exists
ac95b9fa34d0: Already exists
eae75588827d: Already exists
d3beed87d8dd: Already exists
8c4c7b592d73: Already exists
Digest: sha256:6dadea7e142ec239218c908ac1413483ff71011e9d6f5b20325ce48bd21e109f
Status: Downloaded newer image for asif/agoric_validator:sdk2.14.0
Recreating agoric_node_1 ... done
Attaching to agoric_node_1
node_1  | Wed Mar 31 12:42:26 UTC 2021 Starting up.
node_1  | Wed Mar 31 12:42:26 UTC 2021 Environment variable passed are SETUP=1 and MONIKER=MyAgoricValidator
node_1  | Wed Mar 31 12:42:26 UTC 2021 Setting up new environment from scratch
node_1  | name: agoriccosmos
node_1  | server_name: ag-cosmos-server
node_1  | version: 0.24.2
node_1  | commit: 5ad5f483
node_1  | build_tags: ',ledger'
node_1  | go: go version go1.15.7 linux/amd64
node_1  | build_deps:
node_1  | - github.com/99designs/keyring@v1.1.6
node_1  | - github.com/ChainSafe/go-schnorrkel@v0.0.0-20200405005733-88cbf1b4c40d
node_1  | - github.com/Workiva/go-datastructures@v1.0.52
node_1  | - github.com/armon/go-metrics@v0.3.6
node_1  | - github.com/beorn7/perks@v1.0.1
node_1  | - github.com/bgentry/speakeasy@v0.1.0
node_1  | - github.com/btcsuite/btcd@v0.21.0-beta
node_1  | - github.com/cespare/xxhash/v2@v2.1.1
node_1  | - github.com/confio/ics23/go@v0.6.3
node_1  | - github.com/cosmos/cosmos-sdk@v0.42.0
node_1  | - github.com/cosmos/go-bip39@v1.0.0
node_1  | - github.com/cosmos/iavl@v0.15.3
node_1  | - github.com/cosmos/ledger-cosmos-go@v0.11.1
node_1  | - github.com/cosmos/ledger-go@v0.9.2
node_1  | - github.com/davecgh/go-spew@v1.1.1
node_1  | - github.com/dvsekhvalnov/jose2go@v0.0.0-20200901110807-248326c1351b
node_1  | - github.com/enigmampc/btcutil@v1.0.3-0.20200723161021-e2fb6adb2a25
node_1  | - github.com/felixge/httpsnoop@v1.0.1
node_1  | - github.com/fsnotify/fsnotify@v1.4.9
node_1  | - github.com/go-kit/kit@v0.10.0
node_1  | - github.com/go-logfmt/logfmt@v0.5.0
node_1  | - github.com/godbus/dbus@v0.0.0-20190726142602-4481cbc300e2
node_1  | - github.com/gogo/gateway@v1.1.0
node_1  | - github.com/gogo/protobuf@v1.3.3 => github.com/regen-network/protobuf@v1.3.2-alpha.regen.4
node_1  | - github.com/golang/protobuf@v1.4.3
node_1  | - github.com/golang/snappy@v0.0.2
node_1  | - github.com/google/btree@v1.0.0
node_1  | - github.com/gorilla/handlers@v1.5.1
node_1  | - github.com/gorilla/mux@v1.8.0
node_1  | - github.com/gorilla/websocket@v1.4.2
node_1  | - github.com/grpc-ecosystem/go-grpc-middleware@v1.2.2
node_1  | - github.com/grpc-ecosystem/grpc-gateway@v1.16.0
node_1  | - github.com/gsterjov/go-libsecret@v0.0.0-20161001094733-a6f4afe4910c
node_1  | - github.com/gtank/merlin@v0.1.1
node_1  | - github.com/gtank/ristretto255@v0.1.2
node_1  | - github.com/hashicorp/go-immutable-radix@v1.0.0
node_1  | - github.com/hashicorp/golang-lru@v0.5.4
node_1  | - github.com/hashicorp/hcl@v1.0.0
node_1  | - github.com/libp2p/go-buffer-pool@v0.0.2
node_1  | - github.com/magiconair/properties@v1.8.4
node_1  | - github.com/mattn/go-isatty@v0.0.12
node_1  | - github.com/matttproud/golang_protobuf_extensions@v1.0.1
node_1  | - github.com/mimoo/StrobeGo@v0.0.0-20181016162300-f8f6d4d2b643
node_1  | - github.com/minio/highwayhash@v1.0.1
node_1  | - github.com/mitchellh/go-homedir@v1.1.0
node_1  | - github.com/mitchellh/mapstructure@v1.1.2
node_1  | - github.com/mtibben/percent@v0.2.1
node_1  | - github.com/pelletier/go-toml@v1.8.0
node_1  | - github.com/pkg/errors@v0.9.1
node_1  | - github.com/pmezard/go-difflib@v1.0.0
node_1  | - github.com/prometheus/client_golang@v1.8.0
node_1  | - github.com/prometheus/client_model@v0.2.0
node_1  | - github.com/prometheus/common@v0.15.0
node_1  | - github.com/prometheus/procfs@v0.2.0
node_1  | - github.com/rakyll/statik@v0.1.7
node_1  | - github.com/rcrowley/go-metrics@v0.0.0-20200313005456-10cdbea86bc0
node_1  | - github.com/regen-network/cosmos-proto@v0.3.1
node_1  | - github.com/rs/cors@v1.7.0
node_1  | - github.com/rs/zerolog@v1.20.0
node_1  | - github.com/spf13/afero@v1.3.4
node_1  | - github.com/spf13/cast@v1.3.1
node_1  | - github.com/spf13/cobra@v1.1.1
node_1  | - github.com/spf13/jwalterweatherman@v1.1.0
node_1  | - github.com/spf13/pflag@v1.0.5
node_1  | - github.com/spf13/viper@v1.7.1
node_1  | - github.com/stretchr/testify@v1.7.0
node_1  | - github.com/subosito/gotenv@v1.2.0
node_1  | - github.com/syndtr/goleveldb@v1.0.1-0.20200815110645-5c35d600f0ca
node_1  | - github.com/tendermint/btcd@v0.1.1
node_1  | - github.com/tendermint/crypto@v0.0.0-20191022145703-50d29ede1e15
node_1  | - github.com/tendermint/go-amino@v0.16.0
node_1  | - github.com/tendermint/tendermint@v0.34.8 => github.com/agoric-labs/tendermint@v0.33.1-dev2.0.20210310191408-9156bacf449c
node_1  | - github.com/tendermint/tm-db@v0.6.4
node_1  | - github.com/zondax/hid@v0.9.0
node_1  | - golang.org/x/crypto@v0.0.0-20201221181555-eec23a3978ad
node_1  | - golang.org/x/net@v0.0.0-20201021035429-f5854403a974
node_1  | - golang.org/x/sys@v0.0.0-20201015000850-e3ed0017c211
node_1  | - golang.org/x/term@v0.0.0-20201117132131-f5c789dd3221
node_1  | - golang.org/x/text@v0.3.3
node_1  | - google.golang.org/genproto@v0.0.0-20210114201628-6edceaf6022f
node_1  | - google.golang.org/grpc@v1.35.0 => google.golang.org/grpc@v1.33.2
node_1  | - google.golang.org/protobuf@v1.25.0
node_1  | - gopkg.in/ini.v1@v1.51.0
node_1  | - gopkg.in/yaml.v2@v2.4.0
node_1  | - gopkg.in/yaml.v3@v3.0.0-20200313102051-9f266ea9e77c
node_1  |
node_1  | Wed Mar 31 12:42:34 UTC 2021 Configuring Your Node
node_1  | Wed Mar 31 12:42:34 UTC 2021 Check the Network Parameters. To check the current testnet network parameters:
node_1  | Wed Mar 31 12:42:34 UTC 2021 First, get the network config for the current network.
node_1  | Wed Mar 31 12:42:34 UTC 2021 Set chain name to the correct value and Update environment variables to include chainName
node_1  | Wed Mar 31 12:42:36 UTC 2021 Confirm value: should be something like agorictest-N.
node_1  | agorictest-7
node_1  | Wed Mar 31 12:42:36 UTC 2021 Apply Network Parameters
node_1  | Wed Mar 31 12:42:36 UTC 2021 By default, this is /root/.ag-chain-cosmos.
node_1  | {"app_message":{"auth":{"accounts":[],"params":{"max_memo_characters":"256","sig_verify_cost_ed25519":"590","sig_verify_cost_secp256k1":"1000","tx_sig_limit":"7","tx_size_cost_per_byte":"10"}},"bank":{"balances":[],"denom_metadata":[],"params":{"default_send_enabled":true,"send_enabled":[]},"supply":[]},"capability":{"index":"1","owners":[]},"crisis":{"constant_fee":{"amount":"1000","denom":"stake"}},"dibc":null,"distribution":{"delegator_starting_infos":[],"delegator_withdraw_infos":[],"fee_pool":{"community_pool":[]},"outstanding_rewards":[],"params":{"base_proposer_reward":"0.010000000000000000","bonus_proposer_reward":"0.040000000000000000","community_tax":"0.020000000000000000","withdraw_addr_enabled":true},"previous_proposer":"","validator_accumulated_commissions":[],"validator_current_rewards":[],"validator_historical_rewards":[],"validator_slash_events":[]},"evidence":{"evidence":[]},"genutil":{"gen_txs":[]},"gov":{"deposit_params":{"max_deposit_period":"172800s","min_deposit":[{"amount":"10000000","denom":"stake"}]},"deposits":[],"proposals":[],"starting_proposal_id":"1","tally_params":{"quorum":"0.334000000000000000","threshold":"0.500000000000000000","veto_threshold":"0.334000000000000000"},"votes":[],"voting_params":{"voting_period":"172800s"}},"ibc":{"channel_genesis":{"ack_sequences":[],"acknowledgements":[],"channels":[],"commitments":[],"next_channel_sequence":"0","receipts":[],"recv_sequences":[],"send_sequences":[]},"client_genesis":{"clients":[],"clients_consensus":[],"clients_metadata":[],"create_localhost":false,"next_client_sequence":"0","params":{"allowed_clients":["06-solomachine","07-tendermint"]}},"connection_genesis":{"client_connection_paths":[],"connections":[],"next_connection_sequence":"0"}},"mint":{"minter":{"annual_provisions":"0.000000000000000000","inflation":"0.130000000000000000"},"params":{"blocks_per_year":"6311520","goal_bonded":"0.670000000000000000","inflation_max":"0.200000000000000000","inflation_min":"0.070000000000000000","inflation_rate_change":"0.130000000000000000","mint_denom":"stake"}},"params":null,"slashing":{"missed_blocks":[],"params":{"downtime_jail_duration":"600s","min_signed_per_window":"0.500000000000000000","signed_blocks_window":"100","slash_fraction_double_sign":"0.050000000000000000","slash_fraction_downtime":"0.010000000000000000"},"signing_infos":[]},"staking":{"delegations":[],"exported":false,"last_total_power":"0","last_validator_powers":[],"params":{"bond_denom":"stake","historical_entries":10000,"max_entries":7,"max_validators":100,"unbonding_time":"1814400s"},"redelegations":[],"unbonding_delegations":[],"validators":[]},"swingset":{"storage":{}},"transfer":{"denom_traces":[],"params":{"receive_enabled":true,"send_enabled":true},"port_id":"transfer"},"upgrade":{},"vesting":{}},"chain_id":"agorictest-7","gentxs_dir":"","moniker":"MyAgoricValidator","node_id":"785d389811b2a37a7dfd8d7ea2a4e42b3e59b12b"}
node_1  | Wed Mar 31 12:42:44 UTC 2021 Download the genesis file
node_1  | Wed Mar 31 12:42:45 UTC 2021 Reset the state of your validator.
node_1  | 12:42PM INF Removed existing address book file=/root/.ag-chain-cosmos/config/addrbook.json
node_1  | 12:42PM INF Removed all blockchain history dir=/root/.ag-chain-cosmos/data
node_1  | 12:42PM INF Reset private validator file to genesis state keyFile=/root/.ag-chain-cosmos/config/priv_validator_key.json stateFile=/root/.ag-chain-cosmos/data/priv_validator_state.json
node_1  | Wed Mar 31 12:42:53 UTC 2021 Adjust configuration
node_1  | Wed Mar 31 12:42:53 UTC 2021 Set peers variable to the correct value
node_1  | Wed Mar 31 12:42:54 UTC 2021 Set seeds variable to the correct value.
node_1  | Wed Mar 31 12:42:54 UTC 2021 Confirm values, each should be something like 077c58e4b207d02bbbb1b68d6e7e1df08ce18a8a@178.62.245.23:26656,...
node_1  | "9876c1b8f13c4ff3b2102de7b51a2d641092ab35@167.172.36.124:26656,1955d22c8fe1e612a26eeae1176eb55e4f499897@138.68.134.166:26656,7e6be50ffa15e32078e03e2f4cfaedd136237a23@157.245.11.32:26656,d0529494b41949f4d14cd4269d19a72f9c50c443@178.128.51.171:26656"
node_1  | "312ff22094a63ae783b73e43b2732b1d02a7e544@164.90.162.220:26656,647ee57827efcc2b79741f7b95b96da5a111f882@104.236.29.108:26656"
node_1  | Wed Mar 31 12:42:54 UTC 2021 Fix Error: failed to parse log level
node_1  | Wed Mar 31 12:42:54 UTC 2021 Replace the seeds and persistent_peers values
node_1  | Wed Mar 31 12:42:54 UTC 2021 Starting Agoric service
node_1  | 2021-03-31T12:43:02.858Z launch-chain: Launching SwingSet kernel
node_1  | 2021-03-31T12:44:02.292Z block-manager: block 1 begin
node_1  | ibc.go downcall {"method":"bindPort","packet":{"source_port":"echo"},"type":"IBC_METHOD"}
node_1  | ibc.go downcall reply true <nil>
node_1  | 2021-03-31T12:44:06.432Z block-manager: block 1 commit
node_1  | 2021-03-31T12:44:06.472Z block-manager: block 2 begin
node_1  | 2021-03-31T12:44:06.610Z block-manager: block 2 commit
node_1  | 2021-03-31T12:44:06.637Z block-manager: block 3 begin
node_1  | 2021-03-31T12:44:06.706Z block-manager: block 3 commit
node_1  | 2021-03-31T12:44:06.745Z block-manager: block 4 begin
node_1  | 2021-03-31T12:44:06.811Z block-manager: block 4 commit
node_1  | 2021-03-31T12:44:06.837Z block-manager: block 5 begin
node_1  | 2021-03-31T12:44:07.051Z block-manager: block 5 commit
node_1  | 2021-03-31T12:44:07.082Z block-manager: block 6 begin
node_1  | 2021-03-31T12:44:07.629Z block-manager: block 6 commit
node_1  | 2021-03-31T12:44:07.674Z block-manager: block 7 begin
node_1  | 2021-03-31T12:44:07.768Z block-manager: block 7 commit
node_1  | 2021-03-31T12:44:07.808Z block-manager: block 8 begin
node_1  | 2021-03-31T12:44:07.885Z block-manager: block 8 commit
node_1  | 2021-03-31T12:44:07.926Z block-manager: block 9 begin
node_1  | 2021-03-31T12:44:07.995Z block-manager: block 9 commit
node_1  | 2021-03-31T12:44:08.037Z block-manager: block 10 begin
```

## How do I make changes to Dockerfile or update the Agoric SDK version and deploy it?
### Step 1: Clone the repository
```
git clone https://github.com/asifhj/agoric_docker_deployment.git
```

### Step 2: Edit Dockerfile
```
Update line number @33, Agoric SDK version
```

### Step 3: Build docker image
```
$ docker build -t agoric .
[+] Building 5.4s (22/22) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                                                                                                                                   0.1s
 => => transferring dockerfile: 129B                                                                                                                                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                                                                                                                                                                                                                                       4.8s
 => [internal] load build context                                                                                                                                                                                                                                                                                      0.0s
 => => transferring context: 32B                                                                                                                                                                                                                                                                                       0.0s
 => [ 1/17] FROM docker.io/library/ubuntu:latest@sha256:a15789d24a386e7487a407274b80095c329f89b1f830e8ac6a9323aa61803964                                                                                                                                                                                               0.0s
 => CACHED [ 2/17] WORKDIR /root                                                                                                                                                                                                                                                                                       0.0s
 => CACHED [ 3/17] RUN apt-get update                                                                                                                                                                                                                                                                                  0.0s
 => CACHED [ 4/17] RUN apt-get -y install curl git jq                                                                                                                                                                                                                                                                  0.0s
 => CACHED [ 5/17] RUN curl https://deb.nodesource.com/setup_12.x | bash                                                                                                                                                                                                                                               0.0s
 => CACHED [ 6/17] RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -                                                                                                                                                                                                                               0.0s
 => CACHED [ 7/17] RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list                                                                                                                                                                                                   0.0s
 => CACHED [ 8/17] RUN apt update                                                                                                                                                                                                                                                                                      0.0s
 => CACHED [ 9/17] RUN apt upgrade -y                                                                                                                                                                                                                                                                                  0.0s
 => CACHED [10/17] RUN apt install nodejs=12.* yarn build-essential jq -y                                                                                                                                                                                                                                              0.0s
 => CACHED [11/17] RUN rm -rf /usr/local/go                                                                                                                                                                                                                                                                            0.0s
 => CACHED [12/17] RUN curl https://dl.google.com/go/go1.15.7.linux-amd64.tar.gz | tar -C/usr/local -zxvf -                                                                                                                                                                                                            0.0s
 => CACHED [13/17] RUN git clone https://github.com/Agoric/agoric-sdk -b @agoric/sdk@2.14.0                                                                                                                                                                                                                            0.0s
 => CACHED [14/17] RUN cat <<'EOF' >>$HOME/.profile                                                                                                                                                                                                                                                                    0.0s
 => CACHED [15/17] RUN /bin/bash -c "source $HOME/.profile"                                                                                                                                                                                                                                                            0.0s
 => CACHED [16/17] RUN cd agoric-sdk && yarn install && yarn build && (cd packages/cosmic-swingset && make)                                                                                                                                                                                                            0.0s
 => CACHED [17/17] COPY startup.sh /root                                                                                                                                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                                                                                                                                                                 0.1s
 => => exporting layers                                                                                                                                                                                                                                                                                                0.0s
 => => writing image sha256:12d07f95522c7172bba3a01e51d5bc9c27786d18cb05356ddb0ac4dd8e461ab6                                                                                                                                                                                                                           0.0s
 => => naming to docker.io/library/agoric                                                                                                                                                                                                                                                                              0.0s
$
```
Now the image is created and stored locally.
```
$ docker images
REPOSITORY                                          TAG       IMAGE ID       CREATED         SIZE
agoric                                              latest    12d07f95522c   16 hours ago    3.57GB
```

## How to deploy Agoric docker container?
### Step 4: Go to cloned git repo and edit the environment variables and volume mount points as required.
```
version: "1.0"
services:
  node:
    image: asif/agoric_validator:sdk2.14.0
    command: /bin/bash /root/startup.sh
    ports:
      - "26660:26660"
      - "26656:26656"
      - "9464:9464"
      - "1317:1317"
    environment:
      - SETUP=0
      - MONIKER=MyAgoricValidator
    volumes:
      - .ag-chain-cosmos:/root/.ag-chain-cosmos/
```
NOTE: SETUP=0 means just start Agoric service
      SETUP=1 means reset all and start the Agoric service
      
      Volumes - current directory is mapped to /root/.ag-chain-cosmos
      
      

### Step 5: Start the docker container

#### When SETUP=1
```
$ docker-compose up
Recreating agoric_node_1 ... done
Attaching to agoric_node_1
node_1  | Wed Mar 31 10:25:14 UTC 2021 Starting up.
node_1  | Wed Mar 31 10:25:14 UTC 2021 Environment variable passed are SETUP=1 and MONIKER=MyAgoricValidator
node_1  | Wed Mar 31 10:25:14 UTC 2021 Setting up new environment from scratch
node_1  | name: agoriccosmos
node_1  | server_name: ag-cosmos-server
node_1  | version: 0.24.2
node_1  | commit: 5ad5f483
node_1  | build_tags: ',ledger'
node_1  | go: go version go1.15.7 linux/amd64
node_1  | build_deps:
node_1  | - github.com/99designs/keyring@v1.1.6
node_1  | - github.com/ChainSafe/go-schnorrkel@v0.0.0-20200405005733-88cbf1b4c40d
node_1  | - github.com/Workiva/go-datastructures@v1.0.52
node_1  | - github.com/armon/go-metrics@v0.3.6
node_1  | - github.com/beorn7/perks@v1.0.1
node_1  | - github.com/bgentry/speakeasy@v0.1.0
node_1  | - github.com/btcsuite/btcd@v0.21.0-beta
node_1  | - github.com/cespare/xxhash/v2@v2.1.1
node_1  | - github.com/confio/ics23/go@v0.6.3
node_1  | - github.com/cosmos/cosmos-sdk@v0.42.0
node_1  | - github.com/cosmos/go-bip39@v1.0.0
node_1  | - github.com/cosmos/iavl@v0.15.3
node_1  | - github.com/cosmos/ledger-cosmos-go@v0.11.1
node_1  | - github.com/cosmos/ledger-go@v0.9.2
node_1  | - github.com/davecgh/go-spew@v1.1.1
node_1  | - github.com/dvsekhvalnov/jose2go@v0.0.0-20200901110807-248326c1351b
node_1  | - github.com/enigmampc/btcutil@v1.0.3-0.20200723161021-e2fb6adb2a25
node_1  | - github.com/felixge/httpsnoop@v1.0.1
node_1  | - github.com/fsnotify/fsnotify@v1.4.9
node_1  | - github.com/go-kit/kit@v0.10.0
node_1  | - github.com/go-logfmt/logfmt@v0.5.0
node_1  | - github.com/godbus/dbus@v0.0.0-20190726142602-4481cbc300e2
node_1  | - github.com/gogo/gateway@v1.1.0
node_1  | - github.com/gogo/protobuf@v1.3.3 => github.com/regen-network/protobuf@v1.3.2-alpha.regen.4
node_1  | - github.com/golang/protobuf@v1.4.3
node_1  | - github.com/golang/snappy@v0.0.2
node_1  | - github.com/google/btree@v1.0.0
node_1  | - github.com/gorilla/handlers@v1.5.1
node_1  | - github.com/gorilla/mux@v1.8.0
node_1  | - github.com/gorilla/websocket@v1.4.2
node_1  | - github.com/grpc-ecosystem/go-grpc-middleware@v1.2.2
node_1  | - github.com/grpc-ecosystem/grpc-gateway@v1.16.0
node_1  | - github.com/gsterjov/go-libsecret@v0.0.0-20161001094733-a6f4afe4910c
node_1  | - github.com/gtank/merlin@v0.1.1
node_1  | - github.com/gtank/ristretto255@v0.1.2
node_1  | - github.com/hashicorp/go-immutable-radix@v1.0.0
node_1  | - github.com/hashicorp/golang-lru@v0.5.4
node_1  | - github.com/hashicorp/hcl@v1.0.0
node_1  | - github.com/libp2p/go-buffer-pool@v0.0.2
node_1  | - github.com/magiconair/properties@v1.8.4
node_1  | - github.com/mattn/go-isatty@v0.0.12
node_1  | - github.com/matttproud/golang_protobuf_extensions@v1.0.1
node_1  | - github.com/mimoo/StrobeGo@v0.0.0-20181016162300-f8f6d4d2b643
node_1  | - github.com/minio/highwayhash@v1.0.1
node_1  | - github.com/mitchellh/go-homedir@v1.1.0
node_1  | - github.com/mitchellh/mapstructure@v1.1.2
node_1  | - github.com/mtibben/percent@v0.2.1
node_1  | - github.com/pelletier/go-toml@v1.8.0
node_1  | - github.com/pkg/errors@v0.9.1
node_1  | - github.com/pmezard/go-difflib@v1.0.0
node_1  | - github.com/prometheus/client_golang@v1.8.0
node_1  | - github.com/prometheus/client_model@v0.2.0
node_1  | - github.com/prometheus/common@v0.15.0
node_1  | - github.com/prometheus/procfs@v0.2.0
node_1  | - github.com/rakyll/statik@v0.1.7
node_1  | - github.com/rcrowley/go-metrics@v0.0.0-20200313005456-10cdbea86bc0
node_1  | - github.com/regen-network/cosmos-proto@v0.3.1
node_1  | - github.com/rs/cors@v1.7.0
node_1  | - github.com/rs/zerolog@v1.20.0
node_1  | - github.com/spf13/afero@v1.3.4
node_1  | - github.com/spf13/cast@v1.3.1
node_1  | - github.com/spf13/cobra@v1.1.1
node_1  | - github.com/spf13/jwalterweatherman@v1.1.0
node_1  | - github.com/spf13/pflag@v1.0.5
node_1  | - github.com/spf13/viper@v1.7.1
node_1  | - github.com/stretchr/testify@v1.7.0
node_1  | - github.com/subosito/gotenv@v1.2.0
node_1  | - github.com/syndtr/goleveldb@v1.0.1-0.20200815110645-5c35d600f0ca
node_1  | - github.com/tendermint/btcd@v0.1.1
node_1  | - github.com/tendermint/crypto@v0.0.0-20191022145703-50d29ede1e15
node_1  | - github.com/tendermint/go-amino@v0.16.0
node_1  | - github.com/tendermint/tendermint@v0.34.8 => github.com/agoric-labs/tendermint@v0.33.1-dev2.0.20210310191408-9156bacf449c
node_1  | - github.com/tendermint/tm-db@v0.6.4
node_1  | - github.com/zondax/hid@v0.9.0
node_1  | - golang.org/x/crypto@v0.0.0-20201221181555-eec23a3978ad
node_1  | - golang.org/x/net@v0.0.0-20201021035429-f5854403a974
node_1  | - golang.org/x/sys@v0.0.0-20201015000850-e3ed0017c211
node_1  | - golang.org/x/term@v0.0.0-20201117132131-f5c789dd3221
node_1  | - golang.org/x/text@v0.3.3
node_1  | - google.golang.org/genproto@v0.0.0-20210114201628-6edceaf6022f
node_1  | - google.golang.org/grpc@v1.35.0 => google.golang.org/grpc@v1.33.2
node_1  | - google.golang.org/protobuf@v1.25.0
node_1  | - gopkg.in/ini.v1@v1.51.0
node_1  | - gopkg.in/yaml.v2@v2.4.0
node_1  | - gopkg.in/yaml.v3@v3.0.0-20200313102051-9f266ea9e77c
node_1  |
node_1  | Wed Mar 31 10:25:17 UTC 2021 Configuring Your Node
node_1  | Wed Mar 31 10:25:17 UTC 2021 Check the Network Parameters. To check the current testnet network parameters:
node_1  | Wed Mar 31 10:25:17 UTC 2021 First, get the network config for the current network.
node_1  | Wed Mar 31 10:25:17 UTC 2021 Set chain name to the correct value and Update environment variables to include chainName
node_1  | Wed Mar 31 10:25:18 UTC 2021 Confirm value: should be something like agorictest-N.
node_1  | agorictest-7
node_1  | Wed Mar 31 10:25:18 UTC 2021 Apply Network Parameters
node_1  | Wed Mar 31 10:25:18 UTC 2021 By default, this is /root/.ag-chain-cosmos.
node_1  | {"app_message":{"auth":{"accounts":[],"params":{"max_memo_characters":"256","sig_verify_cost_ed25519":"590","sig_verify_cost_secp256k1":"1000","tx_sig_limit":"7","tx_size_cost_per_byte":"10"}},"bank":{"balances":[],"denom_metadata":[],"params":{"default_send_enabled":true,"send_enabled":[]},"supply":[]},"capability":{"index":"1","owners":[]},"crisis":{"constant_fee":{"amount":"1000","denom":"stake"}},"dibc":null,"distribution":{"delegator_starting_infos":[],"delegator_withdraw_infos":[],"fee_pool":{"community_pool":[]},"outstanding_rewards":[],"params":{"base_proposer_reward":"0.010000000000000000","bonus_proposer_reward":"0.040000000000000000","community_tax":"0.020000000000000000","withdraw_addr_enabled":true},"previous_proposer":"","validator_accumulated_commissions":[],"validator_current_rewards":[],"validator_historical_rewards":[],"validator_slash_events":[]},"evidence":{"evidence":[]},"genutil":{"gen_txs":[]},"gov":{"deposit_params":{"max_deposit_period":"172800s","min_deposit":[{"amount":"10000000","denom":"stake"}]},"deposits":[],"proposals":[],"starting_proposal_id":"1","tally_params":{"quorum":"0.334000000000000000","threshold":"0.500000000000000000","veto_threshold":"0.334000000000000000"},"votes":[],"voting_params":{"voting_period":"172800s"}},"ibc":{"channel_genesis":{"ack_sequences":[],"acknowledgements":[],"channels":[],"commitments":[],"next_channel_sequence":"0","receipts":[],"recv_sequences":[],"send_sequences":[]},"client_genesis":{"clients":[],"clients_consensus":[],"clients_metadata":[],"create_localhost":false,"next_client_sequence":"0","params":{"allowed_clients":["06-solomachine","07-tendermint"]}},"connection_genesis":{"client_connection_paths":[],"connections":[],"next_connection_sequence":"0"}},"mint":{"minter":{"annual_provisions":"0.000000000000000000","inflation":"0.130000000000000000"},"params":{"blocks_per_year":"6311520","goal_bonded":"0.670000000000000000","inflation_max":"0.200000000000000000","inflation_min":"0.070000000000000000","inflation_rate_change":"0.130000000000000000","mint_denom":"stake"}},"params":null,"slashing":{"missed_blocks":[],"params":{"downtime_jail_duration":"600s","min_signed_per_window":"0.500000000000000000","signed_blocks_window":"100","slash_fraction_double_sign":"0.050000000000000000","slash_fraction_downtime":"0.010000000000000000"},"signing_infos":[]},"staking":{"delegations":[],"exported":false,"last_total_power":"0","last_validator_powers":[],"params":{"bond_denom":"stake","historical_entries":10000,"max_entries":7,"max_validators":100,"unbonding_time":"1814400s"},"redelegations":[],"unbonding_delegations":[],"validators":[]},"swingset":{"storage":{}},"transfer":{"denom_traces":[],"params":{"receive_enabled":true,"send_enabled":true},"port_id":"transfer"},"upgrade":{},"vesting":{}},"chain_id":"agorictest-7","gentxs_dir":"","moniker":"MyAgoricValidator","node_id":"785d389811b2a37a7dfd8d7ea2a4e42b3e59b12b"}
node_1  | Wed Mar 31 10:25:21 UTC 2021 Download the genesis file
node_1  | Wed Mar 31 10:25:22 UTC 2021 Reset the state of your validator.
node_1  | 10:25AM INF Removed all blockchain history dir=/root/.ag-chain-cosmos/data
node_1  | 10:25AM INF Reset private validator file to genesis state keyFile=/root/.ag-chain-cosmos/config/priv_validator_key.json stateFile=/root/.ag-chain-cosmos/data/priv_validator_state.json
node_1  | Wed Mar 31 10:25:25 UTC 2021 Adjust configuration
node_1  | Wed Mar 31 10:25:25 UTC 2021 Set peers variable to the correct value
node_1  | Wed Mar 31 10:25:25 UTC 2021 Set seeds variable to the correct value.
node_1  | Wed Mar 31 10:25:25 UTC 2021 Confirm values, each should be something like 077c58e4b207d02bbbb1b68d6e7e1df08ce18a8a@178.62.245.23:26656,...
node_1  | "9876c1b8f13c4ff3b2102de7b51a2d641092ab35@167.172.36.124:26656,1955d22c8fe1e612a26eeae1176eb55e4f499897@138.68.134.166:26656,7e6be50ffa15e32078e03e2f4cfaedd136237a23@157.245.11.32:26656,d0529494b41949f4d14cd4269d19a72f9c50c443@178.128.51.171:26656"
node_1  | "312ff22094a63ae783b73e43b2732b1d02a7e544@164.90.162.220:26656,647ee57827efcc2b79741f7b95b96da5a111f882@104.236.29.108:26656"
node_1  | Wed Mar 31 10:25:25 UTC 2021 Fix Error: failed to parse log level
node_1  | Wed Mar 31 10:25:25 UTC 2021 Replace the seeds and persistent_peers values
node_1  | Wed Mar 31 10:25:25 UTC 2021 Starting Agoric service
node_1  | 2021-03-31T10:25:28.026Z launch-chain: Launching SwingSet kernel
node_1  | 2021-03-31T10:25:41.856Z block-manager: block 1 begin
node_1  | 10:25AM ERR dialing failed (attempts: 1): dial tcp 138.68.134.166:26656: i/o timeout addr={"id":"1955d22c8fe1e612a26eeae1176eb55e4f499897","ip":"138.68.134.166","port":26656} module=pex
node_1  | ibc.go downcall {"method":"bindPort","packet":{"source_port":"echo"},"type":"IBC_METHOD"}
node_1  | ibc.go downcall reply true <nil>
node_1  | 2021-03-31T10:25:42.476Z block-manager: block 1 commit
node_1  | 2021-03-31T10:25:42.481Z block-manager: block 2 begin
node_1  | 2021-03-31T10:25:42.502Z block-manager: block 2 commit
node_1  | 2021-03-31T10:25:43.713Z block-manager: block 3 begin
node_1  | 2021-03-31T10:25:43.727Z block-manager: block 3 commit
node_1  | 2021-03-31T10:25:43.732Z block-manager: block 4 begin
node_1  | 2021-03-31T10:25:43.744Z block-manager: block 4 commit
node_1  | 2021-03-31T10:25:43.751Z block-manager: block 5 begin
node_1  | 2021-03-31T10:25:43.789Z block-manager: block 5 commit
node_1  | 2021-03-31T10:25:44.335Z block-manager: block 6 begin
node_1  | 2021-03-31T10:25:44.354Z block-manager: block 6 commit
node_1  | 2021-03-31T10:25:44.360Z block-manager: block 7 begin
node_1  | 2021-03-31T10:25:44.373Z block-manager: block 7 commit
node_1  | 2021-03-31T10:25:44.379Z block-manager: block 8 begin
node_1  | 2021-03-31T10:25:44.392Z block-manager: block 8 commit
node_1  | 2021-03-31T10:25:44.593Z block-manager: block 9 begin
node_1  | 2021-03-31T10:25:44.603Z block-manager: block 9 commit
node_1  | 2021-03-31T10:25:44.608Z block-manager: block 10 begin
node_1  | 2021-03-31T10:25:44.618Z block-manager: block 10 commit
node_1  | 2021-03-31T10:25:44.623Z block-manager: block 11 begin
node_1  | 2021-03-31T10:25:44.646Z block-manager: block 11 commit
node_1  | 2021-03-31T10:25:44.652Z block-manager: block 12 begin
node_1  | 2021-03-31T10:25:44.661Z block-manager: block 12 commit
node_1  | 2021-03-31T10:25:44.666Z block-manager: block 13 begin
node_1  | 2021-03-31T10:25:44.679Z block-manager: block 13 commit
node_1  | 2021-03-31T10:25:44.685Z block-manager: block 14 begin
node_1  | 2021-03-31T10:25:44.695Z block-manager: block 14 commit
node_1  | 2021-03-31T10:25:44.700Z block-manager: block 15 begin
node_1  | 2021-03-31T10:25:44.710Z block-manager: block 15 commit
node_1  | 2021-03-31T10:25:44.716Z block-manager: block 16 begin
node_1  | 2021-03-31T10:25:44.743Z block-manager: block 16 commit
node_1  | 2021-03-31T10:25:44.750Z block-manager: block 17 begin
node_1  | 2021-03-31T10:25:44.760Z block-manager: block 17 commit
node_1  | 2021-03-31T10:25:44.766Z block-manager: block 18 begin
node_1  | 2021-03-31T10:25:44.776Z block-manager: block 18 commit
node_1  | 2021-03-31T10:25:44.782Z block-manager: block 19 begin
node_1  | 2021-03-31T10:25:44.792Z block-manager: block 19 commit
node_1  | 2021-03-31T10:25:44.799Z block-manager: block 20 begin
node_1  | 2021-03-31T10:25:44.808Z block-manager: block 20 commit
.........
.........
```
#### When SETUP=0
```
$ docker-compose up
Recreating agoric_node_1 ... done
Attaching to agoric_node_1
node_1  | Wed Mar 31 10:31:38 UTC 2021 Starting up.
node_1  | Wed Mar 31 10:31:38 UTC 2021 Environment variable passed are SETUP=0 and MONIKER=MyAgoricValidator
node_1  | Wed Mar 31 10:31:38 UTC 2021 Starting Agoric service
node_1  | 2021-03-31T10:31:41.657Z launch-chain: Launching SwingSet kernel
node_1  | 2021-03-31T10:31:42.423Z block-manager: block 127 begin
node_1  | 2021-03-31T10:31:42.430Z block-manager: block 127 commit
node_1  | 2021-03-31T10:31:44.020Z block-manager: block 128 begin
node_1  | 2021-03-31T10:31:44.033Z block-manager: block 128 commit
node_1  | 2021-03-31T10:31:44.610Z block-manager: block 129 begin
node_1  | 2021-03-31T10:31:44.639Z block-manager: block 129 commit
node_1  | 2021-03-31T10:31:45.201Z block-manager: block 130 begin
node_1  | 2021-03-31T10:31:45.239Z block-manager: block 130 commit
```
Use -d to detach from the container and run in the background.
