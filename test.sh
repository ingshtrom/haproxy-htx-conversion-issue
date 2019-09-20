#!/bin/sh

echo "You need docker to continue"

echo "Running the failure test..."
docker run \
  --rm \
  --name haproxy \
  -v $(pwd)/haproxy-bad.cfg:/usr/local/etc/haproxy/haproxy-bad.cfg:ro \
  -v $(pwd)/429-bad.http:/etc/haproxy/429-bad.http:ro \
  haproxy:2.0.5 \
  haproxy -c -V -f /usr/local/etc/haproxy/haproxy-bad.cfg
echo "Failed test finished!"

echo "Running the success test..."
docker run \
  --rm \
  --name haproxy \
  -v $(pwd)/haproxy-good.cfg:/usr/local/etc/haproxy/haproxy-good.cfg:ro \
  -v $(pwd)/429-good.http:/etc/haproxy/429-good.http:ro \
  haproxy:2.0.5 \
  haproxy -c -V -f /usr/local/etc/haproxy/haproxy-good.cfg
echo "Good test finished!"
