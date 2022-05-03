FROM alpine:3.15.4

RUN apk --no-cache add tcpdump

RUN mkdir /var/tmp/capture/
# -W filecount, -G Seconds per file, maybe use -C file size limit as well
ENTRYPOINT [ "/usr/bin/tcpdump", "-i", "eth0" ,"-w", "/var/tmp/capture/trace-%yyyy-%mm-%dd-%H-%M-%S", "-W", "10",  "-G", "20",  "-K",  "-n"]

#docker run --name tshark --network host --rm --cap-add=NET_RAW --cap-add=NET_ADMIN --volume=$(pwd):/var/tmp/capture/ elbrusanalyticsdocker/capturdevice:0.7.5