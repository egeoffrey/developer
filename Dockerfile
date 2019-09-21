FROM nginx:alpine

# install python and pip
RUN apk update && apk add python py-pip && rm -rf /var/cache/apk/*

# install mkdocs and optional themes
RUN pip install mkdocs mkdocs-cinder

# copy the files 
COPY . $WORKDIR

# build the site
RUN mkdocs build

# move the site to the right location
RUN mv site/* /usr/share/nginx/html