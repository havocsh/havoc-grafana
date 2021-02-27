FROM grafana/grafana:latest

RUN mkdir /var/lib/grafana/provisioning
RUN mkdir /var/lib/grafana/provisioning/datasources
RUN mkdir /var/lib/grafana/provisioning/dashboards

COPY elasticsearch.yaml /var/lib/grafana/provisioning/datasources/elasticsearch.yaml
COPY havoc-dashboard.json /var/lib/grafana/provisioning/dashboards/havoc-dashboard.json
COPY exploit-monitor.json /var/lib/grafana/provisioning/dashboards/exploit-monitor.json
COPY dashboards.yaml /var/lib/grafana/provisioning/dashboards/dashboards.yaml

USER root
COPY fav32.png /usr/share/grafana/public/img/fav32.png
COPY grafana_icon.svg /usr/share/grafana/public/img/grafana_icon.svg
COPY login_background_dark.svg /usr/share/grafana/public/img/login_background_dark.svg
COPY login_background_dark.svg /usr/share/grafana/public/img/login_background_light.svg

RUN sed -i 's/rgba(18, 28, 41, 0.65)/rgba(0, 0, 0, 0.65)/g' /usr/share/grafana/public/build/app.*.js
RUN sed -i 's/Welcome to Grafana/havoc.sh/g' /usr/share/grafana/public/build/app.*.js
RUN sed -i 's/,u.AppTitle="Grafana"/,u.AppTitle="havoc.sh"/g' /usr/share/grafana/public/build/app.*.js
RUN sed -i -E 's/e=\["Don[^]]+\]/e=\["Embrace havoc"\]/g' /usr/share/grafana/public/build/app.*.js
USER grafana
