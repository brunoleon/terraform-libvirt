FROM hashicorp/terraform:full

LABEL maintainer="bruno.leon@suse.com"

RUN git clone https://github.com/dmacvicar/terraform-provider-libvirt.git
WORKDIR terraform-provider-libvirt
RUN export GO111MODULE=on
RUN export GOFLAGS=-mod=vendor

RUN apk add --update make pkgconfig libvirt-dev gcc libc-dev
RUN make install

FROM hashicorp/terraform:light
COPY --from=0 /go/bin/terraform-provider-libvirt /bin/
RUN apk add --update libvirt
