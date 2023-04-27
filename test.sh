

for _ in {1..1000}
    do
        curl -s http://foo.localhost
        curl -s http://bar.localhost
    done