# Navigate into the client directory
cd client
# Create a Dockerfile 
touch Dockerfile
# Insert and save into Dockerfile the following commands
FROM node:alpine3.18

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

ENV DEBUG=*

EXPOSE 3000

CMD ["npm", "start"]
# Build the image and tag it and then push the image to your dockerhub
# Navigate into the backend
cd ../backend
# Create another Dockerfile
# Insert and save into Dockerfile the following commands
FROM node:alpine3.18

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

EXPOSE 5000

CMD ["npm", "start"]
# Build the image and tag it and then push the image to your dockerhub
# Navigate into the root folder
cd ..
# Create a docker-compose file with the services for backend, frontend and mongodb
# Ensure that you create the necessary volumes and also networks to enable the containers to communicate