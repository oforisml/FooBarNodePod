

for _ in {1..1000}
    do
        curl -s foo.localhost
        curl -s bar.localhost
    done