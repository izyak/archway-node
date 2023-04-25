import tomli
import tomli_w
from pathlib import Path
import os

HOME = os.path.expanduser('~')
PATH = f"{HOME}/testnetx/node2/config/app.toml"

tomlFile = tomli.loads(Path(PATH).read_text(encoding="utf-8"))

tomlFile["grpc"]["enable"] = True
tomlFile["grpc"]["address"] = "0.0.0.0:9092"


tomlFile["grpc-web"]["enable"] = True
tomlFile["grpc-web"]["address"] = "0.0.0.0:9093"

with open(PATH, mode="wb") as fp:
  tomli_w.dump(tomlFile, fp)

PATH = f"{HOME}/testnetx/node2/config/config.toml"

tomlFile = tomli.loads(Path(PATH).read_text(encoding="utf-8"))
tomlFile["rpc"]["laddr"] = "tcp://127.0.0.1:10002"
tomlFile["rpc"]["pprof_laddr"] = "localhost:6062"
tomlFile["p2p"]["laddr"] = "tcp://0.0.0.0:20002"

with open(PATH, mode="wb") as fp:
  tomli_w.dump(tomlFile, fp)
