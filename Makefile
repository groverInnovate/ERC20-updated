-include .env

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80


empty:
	echo "Type Something"

repo:
	gh repo create foundry-smart-contract-lottery --public --source=. --remote=origin

upload:
	git push -u origin main

commit:
	@echo "Enter commit message: "; \
	read msg; \
	git add .; \
	git commit -m "$$msg"

contractD:
	forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit

log:
	git log --oneline

logon:
	@echo "Enter number of logs: "; \
	read msg; \
	git log --oneline "-$$msg"

dotest: 
	@echo "Enter name of test: "; \
	read msg; \
	forge test --mt "$$msg"


deploy:
	@forge script script/DeployOurToken.s.sol:DeployOurToken --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast





# import {Script} from "lib/forge-std/src/Script.sol";
# import {Raffle} from "../src/Raffle.sol";
# 

#Variables can be used in makefile