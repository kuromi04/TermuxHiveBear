#!/bin/bash
PEERS='[{"external_addr":"181.58.39.152:10729","serving_model_id":"Llama-3-70B.gguf"},{"external_addr":"8.8.8.8:1234","serving_model_id":null}]'
echo $PEERS | jq -r '.[] | select(.serving_model_id != null) | "\(.serving_model_id)|\(.external_addr)"'
