# Use the official Node.js image as the base image
FROM node:20.4

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install --no-audit --fund false --registry https://registry.npmmirror.com

# Copy the rest of the files to the container
COPY . .

# Change ownership of files in lib/bin and set permissions
RUN chown -R node:node lib/bin/* && \
    chmod u+x lib/bin/* && \
    chmod -R 777 /app

# Run as the "node" user for better security practices
USER node

RUN ls -la
ENV COOKIE=""
ENV COOKIE_ARRAY =""
ENV http_proxy=""
ENV https_proxy=""

# Start the application
CMD ["node", "clewd.js"]
