# Agoric Validator Docker Deployment

## How to make change to Dockerfile or update the Agoric SDK version?
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
version: "3.9"
services:
  node:
    image: agoric
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
[tw-mbp-ajamadar agoric (main)]$ docker-compose up
Recreating agoric_node_1 ... done
Attaching to agoric_node_1
node_1  | Wed Mar 31 10:25:14 UTC 2021 Starting up.
node_1  | Environment variable passed are SETUP=1 and MONIKER=MyAgoricValidator
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
node_1  | 2021-03-31T10:25:44.815Z block-manager: block 21 begin
node_1  | 2021-03-31T10:25:44.838Z block-manager: block 21 commit
node_1  | 2021-03-31T10:25:44.844Z block-manager: block 22 begin
node_1  | 2021-03-31T10:25:44.853Z block-manager: block 22 commit
node_1  | 2021-03-31T10:25:44.858Z block-manager: block 23 begin
node_1  | 2021-03-31T10:25:44.868Z block-manager: block 23 commit
node_1  | 2021-03-31T10:25:44.873Z block-manager: block 24 begin
node_1  | 2021-03-31T10:25:44.883Z block-manager: block 24 commit
node_1  | 2021-03-31T10:25:44.888Z block-manager: block 25 begin
node_1  | 2021-03-31T10:25:44.898Z block-manager: block 25 commit
node_1  | 2021-03-31T10:25:44.903Z block-manager: block 26 begin
node_1  | 2021-03-31T10:25:44.931Z block-manager: block 26 commit
node_1  | 2021-03-31T10:25:44.937Z block-manager: block 27 begin
node_1  | 2021-03-31T10:25:44.946Z block-manager: block 27 commit
node_1  | 2021-03-31T10:25:44.951Z block-manager: block 28 begin
node_1  | 2021-03-31T10:25:44.964Z block-manager: block 28 commit
node_1  | 2021-03-31T10:25:44.969Z block-manager: block 29 begin
node_1  | 2021-03-31T10:25:44.979Z block-manager: block 29 commit
node_1  | 2021-03-31T10:25:44.984Z block-manager: block 30 begin
node_1  | 2021-03-31T10:25:44.994Z block-manager: block 30 commit
node_1  | 2021-03-31T10:25:45.000Z block-manager: block 31 begin
node_1  | 2021-03-31T10:25:45.022Z block-manager: block 31 commit
node_1  | 2021-03-31T10:25:45.028Z block-manager: block 32 begin
node_1  | 2021-03-31T10:25:45.039Z block-manager: block 32 commit
node_1  | 2021-03-31T10:25:45.045Z block-manager: block 33 begin
node_1  | 2021-03-31T10:25:45.054Z block-manager: block 33 commit
node_1  | 2021-03-31T10:25:45.060Z block-manager: block 34 begin
node_1  | 2021-03-31T10:25:45.070Z block-manager: block 34 commit
node_1  | 2021-03-31T10:25:45.076Z block-manager: block 35 begin
node_1  | 2021-03-31T10:25:45.085Z block-manager: block 35 commit
node_1  | 2021-03-31T10:25:45.090Z block-manager: block 36 begin
node_1  | 2021-03-31T10:25:45.118Z block-manager: block 36 commit
node_1  | 2021-03-31T10:25:45.123Z block-manager: block 37 begin
node_1  | 2021-03-31T10:25:45.133Z block-manager: block 37 commit
node_1  | 2021-03-31T10:25:45.139Z block-manager: block 38 begin
node_1  | 2021-03-31T10:25:45.149Z block-manager: block 38 commit
node_1  | 2021-03-31T10:25:45.154Z block-manager: block 39 begin
node_1  | 2021-03-31T10:25:45.165Z block-manager: block 39 commit
node_1  | 2021-03-31T10:25:45.171Z block-manager: block 40 begin
node_1  | 2021-03-31T10:25:45.181Z block-manager: block 40 commit
node_1  | 2021-03-31T10:25:45.187Z block-manager: block 41 begin
node_1  | 2021-03-31T10:25:45.200Z block-manager: block 41 commit
node_1  | 2021-03-31T10:25:45.207Z block-manager: block 42 begin
node_1  | 2021-03-31T10:25:45.231Z block-manager: block 42 commit
node_1  | 2021-03-31T10:25:45.237Z block-manager: block 43 begin
node_1  | 2021-03-31T10:25:45.246Z block-manager: block 43 commit
node_1  | 2021-03-31T10:25:45.251Z block-manager: block 44 begin
node_1  | 2021-03-31T10:25:45.260Z block-manager: block 44 commit
node_1  | 2021-03-31T10:25:45.265Z block-manager: block 45 begin
node_1  | 2021-03-31T10:25:45.274Z block-manager: block 45 commit
node_1  | 2021-03-31T10:25:45.280Z block-manager: block 46 begin
node_1  | 2021-03-31T10:25:45.290Z block-manager: block 46 commit
node_1  | 2021-03-31T10:25:45.297Z block-manager: block 47 begin
node_1  | 2021-03-31T10:25:45.325Z block-manager: block 47 commit
node_1  | 2021-03-31T10:25:45.331Z block-manager: block 48 begin
node_1  | 2021-03-31T10:25:45.342Z block-manager: block 48 commit
node_1  | 2021-03-31T10:25:45.348Z block-manager: block 49 begin
node_1  | 2021-03-31T10:25:45.359Z block-manager: block 49 commit
node_1  | 2021-03-31T10:25:45.366Z block-manager: block 50 begin
node_1  | 2021-03-31T10:25:45.379Z block-manager: block 50 commit
node_1  | 2021-03-31T10:25:45.385Z block-manager: block 51 begin
node_1  | 2021-03-31T10:25:45.396Z block-manager: block 51 commit
node_1  | 2021-03-31T10:25:45.401Z block-manager: block 52 begin
node_1  | 2021-03-31T10:25:45.422Z block-manager: block 52 commit
node_1  | 2021-03-31T10:25:45.428Z block-manager: block 53 begin
node_1  | 2021-03-31T10:25:45.439Z block-manager: block 53 commit
node_1  | 2021-03-31T10:25:45.445Z block-manager: block 54 begin
node_1  | 2021-03-31T10:25:45.455Z block-manager: block 54 commit
node_1  | 2021-03-31T10:25:45.460Z block-manager: block 55 begin
node_1  | 2021-03-31T10:25:45.469Z block-manager: block 55 commit
node_1  | 2021-03-31T10:25:45.475Z block-manager: block 56 begin
node_1  | 2021-03-31T10:25:45.483Z block-manager: block 56 commit
node_1  | 2021-03-31T10:25:45.492Z block-manager: block 57 begin
node_1  | 2021-03-31T10:25:45.518Z block-manager: block 57 commit
node_1  | 2021-03-31T10:25:45.523Z block-manager: block 58 begin
node_1  | 2021-03-31T10:25:45.532Z block-manager: block 58 commit
node_1  | 2021-03-31T10:25:45.538Z block-manager: block 59 begin
node_1  | 2021-03-31T10:25:45.549Z block-manager: block 59 commit
node_1  | 2021-03-31T10:25:45.555Z block-manager: block 60 begin
node_1  | 2021-03-31T10:25:45.566Z block-manager: block 60 commit
node_1  | 2021-03-31T10:25:45.571Z block-manager: block 61 begin
node_1  | 2021-03-31T10:25:45.580Z block-manager: block 61 commit
node_1  | 2021-03-31T10:25:45.586Z block-manager: block 62 begin
node_1  | 2021-03-31T10:25:45.605Z block-manager: block 62 commit
node_1  | 2021-03-31T10:25:45.610Z block-manager: block 63 begin
node_1  | 2021-03-31T10:25:45.621Z block-manager: block 63 commit
node_1  | 2021-03-31T10:25:45.626Z block-manager: block 64 begin
node_1  | 2021-03-31T10:25:45.636Z block-manager: block 64 commit
node_1  | 2021-03-31T10:25:45.642Z block-manager: block 65 begin
node_1  | 2021-03-31T10:25:45.652Z block-manager: block 65 commit
node_1  | 2021-03-31T10:25:45.657Z block-manager: block 66 begin
node_1  | 2021-03-31T10:25:45.667Z block-manager: block 66 commit
node_1  | 2021-03-31T10:25:45.673Z block-manager: block 67 begin
```
#### When SETUP=0
```
$ docker-compose up
Starting docker_node_1 ... done
Attaching to docker_node_1
node_1  | 0 == MyAgoricValidator
node_1  | 2021-03-31T10:09:06.864Z launch-chain: Launching SwingSet kernel
node_1  | 2021-03-31T10:09:15.036Z block-manager: block 2287 begin
node_1  | 2021-03-31T10:09:15.175Z block-manager: block 2287 commit
node_1  | 2021-03-31T10:09:15.214Z block-manager: block 2288 begin
node_1  | 2021-03-31T10:09:15.281Z block-manager: block 2288 commit
node_1  | 2021-03-31T10:09:15.317Z block-manager: block 2289 begin
```
Use -d to detach from the container and run in background.
