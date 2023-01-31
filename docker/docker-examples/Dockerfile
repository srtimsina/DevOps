FROM node
LABEL np.com.techaxis.version=v1.1
ENV NODE_ENV="development"
ENV PORT 3000
RUN mkdir -p /var/node
ADD weather-app/ /var/node/
WORKDIR /var/node
RUN npm install
EXPOSE $PORT
CMD ./bin/www
