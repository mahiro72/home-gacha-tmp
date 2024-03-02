.DEFAULT_GOAL := help

.PHONY: help
help: ## [ヘルプ] コマンドの一覧を標示する
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'

.PHONY: up
up: ## [環境構築] docker compose環境を起動する
	docker compose up -d

.PHONY: build
build: ## [環境構築] docker compose環境をbuildする(キャッシュ利用)
	docker compose build

.PHONY: down
down: ## [環境構築] dockerイメージを削除し, docker-compose環境を停止する
	docker compose down --rmi all --volumes --remove-orphans

.PHONY: fclean
fclean:down ## [環境構築] docker compose環境の 完全リセット

.PHONY: re ## [環境構築] 完全に初期化した状態でdocker環境を立ち上げる
re:fclean build up
