FROM docker.io/library/nginx:1.27.4-bookworm
COPY dist/index.html /usr/share/nginx/html/index.html
